# BizActivate — Premium Business Activation Agency Website

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fsadman48229-cmyk%2FBTT-App&project-name=bizactivate&repository-name=bizactivate&root-directory=.&framework=nextjs&build-command=npm+run+build&install-command=npm+install&output-directory=.next)

> **One-click deploy:** Click the button above to instantly deploy to Vercel.

---

## Quick Deploy to Vercel

### Option 1 — One-Click (Recommended)

Click the **Deploy with Vercel** button above. It will:
1. Fork the repo to your GitHub account
2. Create a new Vercel project
3. Deploy automatically — live URL in ~90 seconds

### Option 2 — Import Existing Repo

1. Go to [vercel.com/new](https://vercel.com/new)
2. Click **"Import Git Repository"**
3. Select `sadman48229-cmyk/BTT-App` (or the `claude/bizactivate-agency-site-5pj8j9` branch)
4. Framework: **Next.js** (auto-detected)
5. Click **Deploy**

### Option 3 — Vercel CLI

```bash
npm i -g vercel
vercel login
vercel --prod
```

---

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Next.js 16 (App Router) |
| Language | TypeScript |
| Styling | Tailwind CSS |
| Animation | Framer Motion |
| UI Components | Radix UI + custom |
| Icons | Lucide React |
| Fonts | Syne + Inter (Google Fonts) |
| Theme | next-themes (dark/light) |
| Deployment | Vercel |

## Pages (15 routes, all static)

| Route | Description |
|-------|-------------|
| `/` | Full homepage — Hero, Services, Framework™, Pricing, FAQ, CTA |
| `/about` | Team, story, timeline, values |
| `/services` | All 6 service categories with detail |
| `/industries` | 10 industry verticals |
| `/portfolio` | Filterable project grid |
| `/case-studies` | 3 in-depth transformation case studies |
| `/pricing` | 3-tier pricing, monthly/annual toggle |
| `/blog` | Filterable blog with categories |
| `/faq` | Animated accordion FAQ |
| `/contact` | Contact form with success state |
| `/book-call` | Free strategy call booking form |
| `/privacy` | Privacy policy |
| `/terms` | Terms of service |

## Environment Variables

No environment variables required for base deployment. For integrations add to Vercel dashboard:

```env
# Email sending (contact/booking forms)
RESEND_API_KEY=re_xxxxxxxxxxxx

# Database (optional — for CMS/leads)
NEXT_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJxxxx

# Analytics (optional)
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX
```

## Local Development

```bash
npm install
npm run dev     # → http://localhost:3000
npm run build   # Production build check
npm run start   # Run production build locally
```

---

Built by [BizActivate](https://bizactivate.com) — *We Activate Businesses Digitally.*
