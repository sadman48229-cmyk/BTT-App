import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_constants.dart';
import '../errors/app_exception.dart';

final openAiServiceProvider = Provider<OpenAiService>((ref) => OpenAiService());

class OpenAiService {
  late final Dio _dio;

  OpenAiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.openAiBaseUrl,
      headers: {
        'Authorization': 'Bearer ${AppConstants.openAiApiKey}',
        'Content-Type': 'application/json',
      },
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    ));
  }

  // System prompt for BTT tutor
  static const String _systemPrompt = '''
You are BTT Genius AI, an expert Singapore Basic Theory Test (BTT) tutor.
Your goal is to help learners — especially Bangladeshi and Indian migrant workers —
understand and pass the Singapore BTT exam.

IMPORTANT RULES:
1. Always be encouraging, patient, and supportive
2. Use simple, clear English — avoid complex vocabulary
3. When explaining rules, use real-world examples from Singapore
4. Always remind learners that this is a study tool and the official Highway Code is authoritative
5. Never guarantee exam success
6. When asked about road signs, describe them clearly
7. For wrong answers, explain WHY the correct answer is right AND why other options are wrong
8. Keep explanations concise but complete

CAPABILITIES:
- Explain BTT concepts clearly
- Generate practice questions with explanations
- Analyze mistakes and identify weak areas
- Create personalized study plans
- Teach in simple English; optionally translate key points to Bengali or Hindi if asked
- Give memory tricks and mnemonics

DISCLAIMER: Always remind users this is an independent study platform, not affiliated with
any Singapore government agency or driving school.
''';

  Future<String> chat({
    required String userMessage,
    required List<Map<String, String>> history,
    String? context,
  }) async {
    try {
      final messages = [
        {'role': 'system', 'content': _systemPrompt},
        if (context != null)
          {'role': 'system', 'content': 'Context: $context'},
        ...history,
        {'role': 'user', 'content': userMessage},
      ];

      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConstants.openAiModel,
          'messages': messages,
          'max_tokens': 800,
          'temperature': 0.7,
        },
      );

      return response.data['choices'][0]['message']['content'] as String;
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  Future<String> explainMistake({
    required String question,
    required String correctAnswer,
    required String selectedAnswer,
    required String explanation,
  }) async {
    final prompt = '''
The student answered this BTT question incorrectly:

Question: $question
Student's Answer: $selectedAnswer
Correct Answer: $correctAnswer
Official Explanation: $explanation

Please:
1. Explain why "$correctAnswer" is correct in simple terms
2. Explain why "$selectedAnswer" is wrong
3. Give a memory tip to remember this for the exam
4. Keep it friendly and encouraging
''';

    return chat(userMessage: prompt, history: []);
  }

  Future<String> generateStudyPlan({
    required List<String> weakTopics,
    required int studyDaysAvailable,
    required String currentLevel,
  }) async {
    final prompt = '''
Create a personalized BTT study plan for this student:

Weak Topics: ${weakTopics.join(', ')}
Days Available: $studyDaysAvailable days
Current Level: $currentLevel

Create a day-by-day study plan that:
1. Focuses on weak areas first
2. Includes daily time estimates (30-60 minutes max)
3. Uses spaced repetition
4. Mixes reading, practice questions, and mock exams
5. Is realistic for a busy worker

Format it clearly and keep it motivating!
''';

    return chat(userMessage: prompt, history: []);
  }

  Future<String> generateChapterSummary(String chapterName) async {
    final prompt = '''
Create a concise, easy-to-understand summary of "$chapterName" for the Singapore BTT exam.

Include:
1. Key rules (3-5 most important)
2. Common exam traps to avoid
3. Memory tricks
4. Quick-reference table if helpful

Keep it simple enough for someone learning English as a second language.
''';

    return chat(userMessage: prompt, history: []);
  }

  Future<List<Map<String, dynamic>>> generatePracticeQuestions({
    required String topic,
    required int count,
    required String difficulty,
  }) async {
    final prompt = '''
Generate $count original multiple-choice questions about "$topic" for the Singapore BTT exam.
Difficulty: $difficulty

Return ONLY valid JSON array with this exact structure:
[
  {
    "question": "Question text here?",
    "options": ["Option A", "Option B", "Option C", "Option D"],
    "correct": 0,
    "explanation": "Why this is correct...",
    "wrongExplanations": ["Why A is wrong", "Why B is wrong", "Why C is wrong"],
    "difficulty": "$difficulty",
    "topic": "$topic"
  }
]

Rules:
- Questions must be original (not copied from official materials)
- Based on Singapore Highway Code concepts
- Practical, scenario-based questions
- Only return valid JSON, no other text
''';

    try {
      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConstants.openAiModel,
          'messages': [
            {'role': 'system', 'content': _systemPrompt},
            {'role': 'user', 'content': prompt},
          ],
          'max_tokens': 2000,
          'temperature': 0.8,
          'response_format': {'type': 'json_object'},
        },
      );

      final content = response.data['choices'][0]['message']['content'] as String;
      final parsed = jsonDecode(content);
      if (parsed is Map && parsed.containsKey('questions')) {
        return List<Map<String, dynamic>>.from(parsed['questions'] as List);
      }
      return List<Map<String, dynamic>>.from(parsed is List ? parsed : []);
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }

  Stream<String> chatStream({
    required String userMessage,
    required List<Map<String, String>> history,
  }) async* {
    try {
      final messages = [
        {'role': 'system', 'content': _systemPrompt},
        ...history,
        {'role': 'user', 'content': userMessage},
      ];

      final response = await _dio.post(
        '/chat/completions',
        data: {
          'model': AppConstants.openAiModel,
          'messages': messages,
          'max_tokens': 800,
          'temperature': 0.7,
          'stream': true,
        },
        options: Options(responseType: ResponseType.stream),
      );

      final stream = response.data.stream as Stream<List<int>>;
      final buffer = StringBuffer();

      await for (final chunk in stream) {
        final decoded = utf8.decode(chunk);
        buffer.write(decoded);
        final lines = buffer.toString().split('\n');

        for (int i = 0; i < lines.length - 1; i++) {
          final line = lines[i].trim();
          if (line.startsWith('data: ')) {
            final data = line.substring(6);
            if (data == '[DONE]') return;
            try {
              final json = jsonDecode(data);
              final delta = json['choices'][0]['delta'];
              if (delta['content'] != null) {
                yield delta['content'] as String;
              }
            } catch (_) {}
          }
        }

        buffer.clear();
        if (lines.isNotEmpty) buffer.write(lines.last);
      }
    } on DioException catch (e) {
      throw AppException.fromDioError(e);
    }
  }
}
