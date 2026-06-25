-- BTT Genius AI — Supabase PostgreSQL Schema
-- Run this in the Supabase SQL Editor after creating your project.

-- ============================================================
-- Extensions
-- ============================================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================
-- ENUM TYPES
-- ============================================================
CREATE TYPE user_role AS ENUM ('student', 'admin');
CREATE TYPE subscription_type AS ENUM ('free', 'monthly', 'yearly', 'lifetime');
CREATE TYPE user_level AS ENUM ('beginner', 'intermediate', 'advanced');
CREATE TYPE question_difficulty AS ENUM ('easy', 'medium', 'hard');
CREATE TYPE question_type AS ENUM ('multiple_choice', 'true_false', 'image_based');
CREATE TYPE achievement_tier AS ENUM ('bronze', 'silver', 'gold', 'platinum');
CREATE TYPE quiz_mode AS ENUM ('practice', 'mock_exam', 'daily_challenge', 'chapter', 'mistake_review');

-- ============================================================
-- USERS TABLE (extends Supabase auth.users)
-- ============================================================
CREATE TABLE public.users (
    id              UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    email           TEXT NOT NULL UNIQUE,
    display_name    TEXT NOT NULL DEFAULT '',
    avatar_url      TEXT,
    role            user_role NOT NULL DEFAULT 'student',
    subscription    subscription_type NOT NULL DEFAULT 'free',
    level           user_level NOT NULL DEFAULT 'beginner',
    subscription_expires_at TIMESTAMPTZ,

    -- Study stats
    study_streak            INTEGER NOT NULL DEFAULT 0,
    longest_streak          INTEGER NOT NULL DEFAULT 0,
    last_study_date         DATE,
    total_questions_answered INTEGER NOT NULL DEFAULT 0,
    total_correct_answers   INTEGER NOT NULL DEFAULT 0,
    total_study_minutes     INTEGER NOT NULL DEFAULT 0,
    confidence_score        REAL NOT NULL DEFAULT 0,
    xp_points               INTEGER NOT NULL DEFAULT 0,

    -- Preferences
    preferred_language  TEXT NOT NULL DEFAULT 'en',
    notifications_enabled BOOLEAN NOT NULL DEFAULT true,
    daily_goal_minutes  INTEGER NOT NULL DEFAULT 30,

    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Trigger: auto-create user profile after signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.users (id, email, display_name, avatar_url)
    VALUES (
        NEW.id,
        NEW.email,
        COALESCE(NEW.raw_user_meta_data->>'full_name', split_part(NEW.email, '@', 1)),
        NEW.raw_user_meta_data->>'avatar_url'
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
    AFTER INSERT ON auth.users
    FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Trigger: auto-update updated_at
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER users_updated_at
    BEFORE UPDATE ON public.users
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ============================================================
-- CHAPTERS TABLE
-- ============================================================
CREATE TABLE public.chapters (
    id              SERIAL PRIMARY KEY,
    slug            TEXT NOT NULL UNIQUE,
    title           TEXT NOT NULL,
    description     TEXT NOT NULL DEFAULT '',
    emoji           TEXT NOT NULL DEFAULT '📖',
    color_hex       TEXT NOT NULL DEFAULT '#6366F1',
    order_index     INTEGER NOT NULL DEFAULT 0,
    total_lessons   INTEGER NOT NULL DEFAULT 0,
    total_questions INTEGER NOT NULL DEFAULT 0,
    is_premium      BOOLEAN NOT NULL DEFAULT false,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- LESSONS TABLE
-- ============================================================
CREATE TABLE public.lessons (
    id          SERIAL PRIMARY KEY,
    chapter_id  INTEGER NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,
    title       TEXT NOT NULL,
    content     TEXT NOT NULL DEFAULT '',  -- Markdown content
    type        TEXT NOT NULL DEFAULT 'text', -- text | video | quiz
    order_index INTEGER NOT NULL DEFAULT 0,
    duration_minutes INTEGER NOT NULL DEFAULT 5,
    is_premium  BOOLEAN NOT NULL DEFAULT false,
    is_active   BOOLEAN NOT NULL DEFAULT true,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ============================================================
-- QUESTIONS TABLE
-- ============================================================
CREATE TABLE public.questions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    chapter_id      INTEGER REFERENCES public.chapters(id) ON DELETE SET NULL,
    chapter_name    TEXT NOT NULL,
    question        TEXT NOT NULL,
    option_a        TEXT NOT NULL,
    option_b        TEXT NOT NULL,
    option_c        TEXT NOT NULL,
    option_d        TEXT NOT NULL,
    correct_option_index INTEGER NOT NULL CHECK (correct_option_index BETWEEN 0 AND 3),
    explanation     TEXT NOT NULL DEFAULT '',
    wrong_explanations  JSONB NOT NULL DEFAULT '[]', -- array of 4 strings
    difficulty      question_difficulty NOT NULL DEFAULT 'medium',
    question_type   question_type NOT NULL DEFAULT 'multiple_choice',
    image_url       TEXT,
    tags            TEXT[] NOT NULL DEFAULT '{}',
    estimated_time_seconds INTEGER NOT NULL DEFAULT 30,
    times_answered  INTEGER NOT NULL DEFAULT 0,
    times_correct   INTEGER NOT NULL DEFAULT 0,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_questions_chapter_id ON public.questions(chapter_id);
CREATE INDEX idx_questions_difficulty ON public.questions(difficulty);
CREATE INDEX idx_questions_tags ON public.questions USING GIN(tags);

CREATE TRIGGER questions_updated_at
    BEFORE UPDATE ON public.questions
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ============================================================
-- QUIZ SESSIONS TABLE
-- ============================================================
CREATE TABLE public.quiz_sessions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    mode            quiz_mode NOT NULL DEFAULT 'practice',
    chapter_id      INTEGER REFERENCES public.chapters(id) ON DELETE SET NULL,

    -- Session stats
    total_questions INTEGER NOT NULL DEFAULT 0,
    correct_answers INTEGER NOT NULL DEFAULT 0,
    time_taken_seconds INTEGER NOT NULL DEFAULT 0,
    score_percent   REAL GENERATED ALWAYS AS (
        CASE WHEN total_questions = 0 THEN 0
        ELSE (correct_answers::REAL / total_questions * 100)
        END
    ) STORED,

    -- For mock exam
    is_passed       BOOLEAN,
    pass_threshold  INTEGER DEFAULT 45,

    started_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    completed_at    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_quiz_sessions_user_id ON public.quiz_sessions(user_id);
CREATE INDEX idx_quiz_sessions_mode ON public.quiz_sessions(mode);

-- ============================================================
-- QUIZ ANSWERS TABLE (individual answers per session)
-- ============================================================
CREATE TABLE public.quiz_answers (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    session_id      UUID NOT NULL REFERENCES public.quiz_sessions(id) ON DELETE CASCADE,
    question_id     UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
    selected_option_index INTEGER NOT NULL CHECK (selected_option_index BETWEEN 0 AND 3),
    is_correct      BOOLEAN NOT NULL,
    time_taken_seconds INTEGER NOT NULL DEFAULT 0,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_quiz_answers_session_id ON public.quiz_answers(session_id);
CREATE INDEX idx_quiz_answers_question_id ON public.quiz_answers(question_id);

-- ============================================================
-- USER PROGRESS TABLE (per-chapter progress)
-- ============================================================
CREATE TABLE public.user_progress (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    chapter_id  INTEGER NOT NULL REFERENCES public.chapters(id) ON DELETE CASCADE,

    lessons_completed   INTEGER NOT NULL DEFAULT 0,
    questions_answered  INTEGER NOT NULL DEFAULT 0,
    questions_correct   INTEGER NOT NULL DEFAULT 0,
    best_score_percent  REAL NOT NULL DEFAULT 0,
    is_completed        BOOLEAN NOT NULL DEFAULT false,

    last_accessed_at    TIMESTAMPTZ,
    created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, chapter_id)
);

CREATE INDEX idx_user_progress_user_id ON public.user_progress(user_id);

CREATE TRIGGER user_progress_updated_at
    BEFORE UPDATE ON public.user_progress
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ============================================================
-- SPACED REPETITION TABLE
-- ============================================================
CREATE TABLE public.spaced_repetition (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    question_id     UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,

    ease_factor     REAL NOT NULL DEFAULT 2.5,       -- SM-2 ease factor
    interval_days   INTEGER NOT NULL DEFAULT 1,       -- Current interval
    repetitions     INTEGER NOT NULL DEFAULT 0,       -- Total repetitions
    next_review_at  DATE NOT NULL DEFAULT CURRENT_DATE,
    last_reviewed_at DATE,
    is_mastered     BOOLEAN NOT NULL DEFAULT false,

    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, question_id)
);

CREATE INDEX idx_spaced_rep_user_id ON public.spaced_repetition(user_id);
CREATE INDEX idx_spaced_rep_next_review ON public.spaced_repetition(next_review_at);

CREATE TRIGGER spaced_rep_updated_at
    BEFORE UPDATE ON public.spaced_repetition
    FOR EACH ROW EXECUTE FUNCTION public.update_updated_at();

-- ============================================================
-- MISTAKES TABLE
-- ============================================================
CREATE TABLE public.mistakes (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    question_id     UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
    selected_option_index INTEGER NOT NULL CHECK (selected_option_index BETWEEN 0 AND 3),
    times_wrong     INTEGER NOT NULL DEFAULT 1,
    is_resolved     BOOLEAN NOT NULL DEFAULT false,
    last_seen_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, question_id)
);

CREATE INDEX idx_mistakes_user_id ON public.mistakes(user_id);

-- ============================================================
-- BOOKMARKS TABLE
-- ============================================================
CREATE TABLE public.bookmarks (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    question_id UUID NOT NULL REFERENCES public.questions(id) ON DELETE CASCADE,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, question_id)
);

CREATE INDEX idx_bookmarks_user_id ON public.bookmarks(user_id);

-- ============================================================
-- ACHIEVEMENTS TABLE
-- ============================================================
CREATE TABLE public.achievements (
    id          TEXT PRIMARY KEY,
    title       TEXT NOT NULL,
    description TEXT NOT NULL,
    emoji       TEXT NOT NULL,
    tier        achievement_tier NOT NULL DEFAULT 'bronze',
    condition   TEXT NOT NULL,
    xp_reward   INTEGER NOT NULL DEFAULT 50,
    is_active   BOOLEAN NOT NULL DEFAULT true
);

-- ============================================================
-- USER ACHIEVEMENTS TABLE
-- ============================================================
CREATE TABLE public.user_achievements (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    achievement_id  TEXT NOT NULL REFERENCES public.achievements(id) ON DELETE CASCADE,
    unlocked_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, achievement_id)
);

CREATE INDEX idx_user_achievements_user_id ON public.user_achievements(user_id);

-- ============================================================
-- SUBSCRIPTIONS TABLE (payment records)
-- ============================================================
CREATE TABLE public.subscriptions (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    plan            subscription_type NOT NULL,
    store           TEXT NOT NULL DEFAULT 'unknown', -- app_store | play_store | stripe
    store_product_id TEXT,
    store_transaction_id TEXT UNIQUE,
    price_paid_sgd  NUMERIC(10, 2),
    currency        TEXT NOT NULL DEFAULT 'SGD',
    started_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at      TIMESTAMPTZ,
    is_active       BOOLEAN NOT NULL DEFAULT true,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_subscriptions_user_id ON public.subscriptions(user_id);

-- ============================================================
-- AI CHAT HISTORY TABLE (optional — for premium users)
-- ============================================================
CREATE TABLE public.ai_chat_history (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id     UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    role        TEXT NOT NULL CHECK (role IN ('user', 'assistant')),
    content     TEXT NOT NULL,
    context     TEXT,  -- question context if any
    tokens_used INTEGER DEFAULT 0,
    created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_ai_chat_history_user_id ON public.ai_chat_history(user_id, created_at DESC);

-- ============================================================
-- DAILY CHALLENGE TABLE
-- ============================================================
CREATE TABLE public.daily_challenges (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    challenge_date  DATE NOT NULL DEFAULT CURRENT_DATE,
    is_completed    BOOLEAN NOT NULL DEFAULT false,
    score_percent   REAL,
    completed_at    TIMESTAMPTZ,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    UNIQUE(user_id, challenge_date)
);

CREATE INDEX idx_daily_challenges_user_date ON public.daily_challenges(user_id, challenge_date);

-- ============================================================
-- SEED DATA — Achievements
-- ============================================================
INSERT INTO public.achievements (id, title, description, emoji, tier, condition, xp_reward) VALUES
('first_quiz',      'First Steps',          'Completed your first practice quiz',                       '🎯', 'bronze',   'Complete 1 quiz',                  50),
('streak_3',        '3-Day Streak',         'Studied 3 days in a row',                                  '🔥', 'bronze',   'Maintain a 3-day streak',          75),
('streak_7',        'Week Warrior',         'Studied 7 days in a row',                                  '💪', 'silver',   'Maintain a 7-day streak',          150),
('streak_30',       'Monthly Master',       'Studied every day for a full month',                       '🏆', 'gold',     'Maintain a 30-day streak',         500),
('questions_100',   'Century Mark',         'Answered 100 questions total',                             '💯', 'bronze',   'Answer 100 questions',             100),
('questions_500',   'Question Machine',     'Answered 500 questions total',                             '🤖', 'silver',   'Answer 500 questions',             250),
('perfect_quiz',    'Perfectionist',        'Got 100% on a practice quiz',                              '⭐', 'silver',   'Score 100% on any quiz',           200),
('road_sign_master','Road Sign Expert',     'Completed all Road Signs chapter questions',               '🚦', 'gold',     'Answer all Road Sign questions',    300),
('parking_expert',  'Parking Pro',          'Mastered all parking rules questions',                     '🅿️', 'silver',  'Answer all Parking questions',      200),
('mock_pass',       'Exam Ready',           'Passed a full mock exam with 90% or above',               '🎓', 'gold',     'Pass mock exam with ≥45/50',        400),
('fast_learner',    'Speed Demon',          'Answered 10 questions in under 5 minutes',                '⚡', 'bronze',   'Fast answer speed',                 75),
('all_chapters',    'All-Rounder',          'Studied at least one question from every chapter',        '🌟', 'platinum', 'Study all 9 chapters',             1000),
('ai_explorer',     'AI Explorer',          'Used the AI Tutor for the first time',                    '🤖', 'bronze',   'Send 1 AI message',                 50),
('daily_7',         'Daily Champion',       'Completed 7 daily challenges',                            '📅', 'silver',   'Complete 7 daily challenges',      200);

-- ============================================================
-- SEED DATA — Chapters
-- ============================================================
INSERT INTO public.chapters (slug, title, description, emoji, color_hex, order_index, total_lessons, total_questions, is_premium) VALUES
('road-signs',       'Road Signs',          'Traffic signs, warning signs, and regulatory signs',    '🚦', '#EF4444', 1, 8, 60, false),
('road-markings',    'Road Markings',       'Lines, arrows, and symbols on the road surface',        '🛣️', '#F97316', 2, 6, 40, false),
('traffic-rules',    'Traffic Rules',       'General traffic laws and right-of-way rules',           '📋', '#EAB308', 3, 10, 70, false),
('parking',          'Parking Rules',       'Where and how to park legally in Singapore',            '🅿️', '#22C55E', 4, 6, 45, true),
('speed-limits',     'Speed Limits',        'Speed limits for different roads and vehicles',         '⚡', '#06B6D4', 5, 5, 35, true),
('right-of-way',     'Right of Way',        'Priority rules at junctions and pedestrian crossings',  '🔄', '#6366F1', 6, 7, 50, true),
('expressway',       'Expressway Rules',    'Special rules for PIE, AYE, CTE, and other expressways','🛤️', '#8B5CF6', 7, 6, 40, true),
('vehicle-controls', 'Vehicle Controls',    'Controls, instruments, and basic car operations',       '🚗', '#EC4899', 8, 5, 30, true),
('safety',           'Safety & Environment','Safety belts, child seats, and environmental rules',    '🛡️', '#14B8A6', 9, 5, 35, true);

-- ============================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================

-- Enable RLS on all tables
ALTER TABLE public.users              ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.chapters           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.lessons            ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_sessions      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_answers       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_progress      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.spaced_repetition  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.mistakes           ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.bookmarks          ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.achievements       ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_achievements  ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.subscriptions      ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ai_chat_history    ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.daily_challenges   ENABLE ROW LEVEL SECURITY;

-- Users: read/update own row only
CREATE POLICY "users_select_own" ON public.users
    FOR SELECT USING (auth.uid() = id);
CREATE POLICY "users_update_own" ON public.users
    FOR UPDATE USING (auth.uid() = id);

-- Chapters & lessons: everyone can read active ones
CREATE POLICY "chapters_select_all" ON public.chapters
    FOR SELECT USING (is_active = true);
CREATE POLICY "lessons_select_all" ON public.lessons
    FOR SELECT USING (is_active = true);

-- Questions: everyone can read active ones
CREATE POLICY "questions_select_all" ON public.questions
    FOR SELECT USING (is_active = true);

-- Achievements: everyone can read
CREATE POLICY "achievements_select_all" ON public.achievements
    FOR SELECT USING (is_active = true);

-- User-owned data: CRUD own rows only
CREATE POLICY "quiz_sessions_own" ON public.quiz_sessions
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "quiz_answers_own" ON public.quiz_answers
    FOR ALL USING (
        session_id IN (SELECT id FROM public.quiz_sessions WHERE user_id = auth.uid())
    );
CREATE POLICY "user_progress_own" ON public.user_progress
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "spaced_rep_own" ON public.spaced_repetition
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "mistakes_own" ON public.mistakes
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "bookmarks_own" ON public.bookmarks
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "user_achievements_own" ON public.user_achievements
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "subscriptions_own" ON public.subscriptions
    FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "ai_chat_own" ON public.ai_chat_history
    FOR ALL USING (auth.uid() = user_id);
CREATE POLICY "daily_challenges_own" ON public.daily_challenges
    FOR ALL USING (auth.uid() = user_id);

-- Admins: full access (role check via users table)
CREATE POLICY "admin_full_access_users" ON public.users
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
    );
CREATE POLICY "admin_full_access_questions" ON public.questions
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
    );
CREATE POLICY "admin_full_access_chapters" ON public.chapters
    FOR ALL USING (
        EXISTS (SELECT 1 FROM public.users WHERE id = auth.uid() AND role = 'admin')
    );

-- ============================================================
-- USEFUL VIEWS
-- ============================================================

-- User stats summary view
CREATE VIEW public.user_stats AS
SELECT
    u.id,
    u.display_name,
    u.email,
    u.subscription,
    u.study_streak,
    u.longest_streak,
    u.total_questions_answered,
    u.total_correct_answers,
    u.total_study_minutes,
    u.xp_points,
    CASE WHEN u.total_questions_answered = 0 THEN 0
         ELSE ROUND((u.total_correct_answers::NUMERIC / u.total_questions_answered * 100), 1)
    END AS accuracy_percent,
    (SELECT COUNT(*) FROM public.user_achievements ua WHERE ua.user_id = u.id) AS achievements_unlocked,
    (SELECT COUNT(*) FROM public.bookmarks b WHERE b.user_id = u.id) AS bookmarks_count,
    (SELECT COUNT(*) FROM public.mistakes m WHERE m.user_id = u.id AND m.is_resolved = false) AS active_mistakes
FROM public.users u;

-- Leaderboard view (anonymous, top 50)
CREATE VIEW public.leaderboard AS
SELECT
    ROW_NUMBER() OVER (ORDER BY xp_points DESC) AS rank,
    LEFT(display_name, 1) || REPEAT('*', GREATEST(LENGTH(display_name) - 1, 0)) AS masked_name,
    xp_points,
    study_streak,
    total_questions_answered
FROM public.users
WHERE role = 'student'
ORDER BY xp_points DESC
LIMIT 50;

-- ============================================================
-- FUNCTIONS
-- ============================================================

-- Update user streak and stats after quiz completion
CREATE OR REPLACE FUNCTION public.complete_quiz_session(
    p_session_id UUID,
    p_user_id UUID,
    p_correct INTEGER,
    p_total INTEGER,
    p_time_seconds INTEGER
)
RETURNS VOID AS $$
DECLARE
    v_today DATE := CURRENT_DATE;
    v_last_date DATE;
    v_streak INTEGER;
    v_xp INTEGER;
BEGIN
    -- Complete the session
    UPDATE public.quiz_sessions
    SET correct_answers = p_correct,
        total_questions = p_total,
        time_taken_seconds = p_time_seconds,
        completed_at = NOW()
    WHERE id = p_session_id AND user_id = p_user_id;

    -- Get current streak info
    SELECT last_study_date, study_streak
    INTO v_last_date, v_streak
    FROM public.users
    WHERE id = p_user_id;

    -- Update streak
    IF v_last_date = v_today THEN
        -- Already studied today, no streak change
        NULL;
    ELSIF v_last_date = v_today - INTERVAL '1 day' THEN
        -- Consecutive day, increment streak
        v_streak := v_streak + 1;
    ELSE
        -- Streak broken, reset to 1
        v_streak := 1;
    END IF;

    -- Calculate XP earned (10 per correct + bonus for perfect)
    v_xp := p_correct * 10;
    IF p_correct = p_total AND p_total > 0 THEN
        v_xp := v_xp + 50; -- Perfect score bonus
    END IF;

    -- Update user stats
    UPDATE public.users
    SET total_questions_answered = total_questions_answered + p_total,
        total_correct_answers = total_correct_answers + p_correct,
        study_streak = v_streak,
        longest_streak = GREATEST(longest_streak, v_streak),
        last_study_date = v_today,
        xp_points = xp_points + v_xp,
        updated_at = NOW()
    WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
