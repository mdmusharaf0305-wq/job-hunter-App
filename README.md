# 🛰️ Job Command Center (Job Search OS)

An elite, high-performance, glassmorphic recruitment pipeline and job-hunting hub built with Next.js (App Router), TypeScript, Tailwind CSS, Notion API integration, and Python-based real-time job scraping.

---

## 🎨 Premium Design System & UI/UX

- **Glassmorphism Theme**: Fully-realized dark/light translucent glass design cards using harmonized color palettes, blur layouts (`backdrop-blur-md`), and active hover effects.
- **Centered Mobile Floating Menu**: Redesigned floating capsule navigation header centered at the top of viewports on mobile devices.
- **Glassmorphic Mobile Alerts**: Replaced default browser alert dialogs with a beautiful, custom sliding glassmorphic modal overlay centered below the floating menubar.
- **Monkey D. Luffy Retro Loader**: Integrated Monkey D. Luffy pixel-art walking animation.
  - **Full-page loader**: Shows a premium horizontal loading bar with a running percentage indicator (0–100%).
  - **Inline actions**: Renders a compact, pulsing percentage indicator directly inside action buttons and inline lists.

---

## ⚡ Core Features

### 1. Unified Notion Database Integration
- Direct sync with Notion tables tracking **Inbound, Outbound, Pipeline, and Recruiters** databases.
- **Instant Option Creation & Cache Busting**: Add custom Clients directly from the opportunity modals. To bypass Notion's 1-hour cache delay, the application immediately clears local schema caches and triggers Next.js revalidation tags (`notion-schema`) on write.

### 2. Elite Board & Pipeline Workspaces
- **Inbound Tracking**: Manage recruiter outreach and cold call offers.
- **Outbound Sourcing**: Track self-sourced applications.
- **Interview Pipeline**: Track scheduling, rounds, and offers.
- **Recruiter Directory**: A dedicated directory mapping contacts, companies, genders, and history.

### 3. Inline Card Editors (Zero-friction updates)
To avoid opening full details modals, standard fields are editable directly from preview cards:
- **Auto-saving Notes**: Local state textareas that validate changes and auto-save to Notion on `onBlur` to prevent redundant network requests.
- **Inline Date Pickers**: Native calendar input to immediately change `Last Contacted` timestamps.
- **Inline Select Dropdowns**: Edit `Priority` (🔴 High, 🟡 Medium, 🔵 Low) or `Follow-up Channel` directly inside unexpanded cards.
- **Priority Filter Row**: Capsule pill filters default to **🔴 High** priority on load, dynamically updating column metrics and table views.

### 4. Interactive Call Log Modal
Clicking a recruiter's phone icon opens a custom call-tracking utility:
- Log outcomes (e.g., Scheduled, Completed, Missed).
- Save call minutes, transcripts, and notes.
- Provides deep-link dialing fallback for instant connections.

### 5. Multi-channel Recruiter Communications
Coordinated deep-links across all boards optimized for desktop and native mobile apps:
- **Calling**: Direct `tel:` links.
- **WhatsApp**: Triggers native `whatsapp://send?phone=...` protocols on mobile devices, and Web WhatsApp redirection on desktop.
- **Gmail Composer**: Deep links to the official Gmail app (`googlegmail:///co` on iOS, and Android intents) to compose emails immediately. Falls back to web-based Gmail composers on desktop.
- **Google Messages (SMS)**: Opens native `sms:` deep links on mobile devices, and redirects to `messages.google.com/web` on desktop.

---

## 🔍 Featured Real-time Jobs Aggregator

Searches and crawls actual job postings matching your developer profile in real-time.

- **Profile-tailored Filters**: Matches targets under **5 YOE** (optimized for 4.4 YOE) and filters location by Indian tech hubs (**Bengaluru, Hyderabad, Chennai, Pune, or Remote**).
- **2026 Tech Stack Target Matching**: Scrapes job descriptions and highlights matching skills in blue badges (React, Next.js, TypeScript, Node.js, Python, FastAPI, AI/LLMs, RAG, Vector Databases).
- **Subprocess Scraper (`python-jobspy`)**: Runs a python crawler inside a project virtual environment (`.venv`).
- **Naukri, Wellfound, Foundit, & Hirist Aggregation**: Direct API scraping of these portals triggers recaptcha walls. To bypass this, we use Google Jobs queries with advanced site operators (`(site:naukri.com OR site:wellfound.com OR site:foundit.in OR site:hirist.tech)`) to scrape listings cleanly.
- **Anti-404 URL Sanitizer**:
  - Prioritizes direct-to-ATS workday application pages (`job_url_direct`).
  - Sanitize LinkedIn URLs into search queries (`linkedin.com/jobs/search/?currentJobId={id}`) to bypass auth/login gates and prevent guest 404s.
  - Corrects Indeed relative URLs with absolute path prefix resolvers.
- **One-Click Tracking**: Clicking "Import Track" instantly saves the listing into your Notion Outbound pipeline under the "Sourcing" stage.

---

## 🧪 Comprehensive Testing Suite

We maintain a robust test footprint across unit, component, integration, and E2E tests:
- **Pure Unit Tests**: Runs in Vitest. Tests Notion database object-mapping (`mapPageToApplication`) and status parsers.
- **React Testing Library**: Component validation for `ApplicationModal` and `TimelineClient` interaction flows.
- **Integration Tests**: Tests complex interactions between Next.js server actions, state handlers, and mock schema options.
- **Playwright E2E**: Automates chromium browser runs visiting pages, opening form modals, and filling tracking details.

---

## 🛠️ Technology Stack

- **Frontend**: Next.js 15 (App Router), React, Tailwind CSS, Lucide React icons, Framer Motion animations.
- **Backend**: Next.js Server Actions, Notion Client SDK.
- **Scraper**: Python 3.10+, `python-jobspy` (with TLS-client, BeautifulSoup, and Pandas).
- **Testing**: Vitest, `@testing-library/react`, Playwright.

---

## 🚀 Getting Started

### Prerequisites
- Node.js (v18+)
- Python 3.10+
- Git

### Installation
1. Clone the repository and install npm packages:
   ```bash
   npm install
   ```
2. Initialize the Python virtual environment and install scraping dependencies:
   ```bash
   python -m venv .venv
   .venv/Scripts/pip install python-jobspy
   ```
3. Set up your `.env.local` file in the root directory:
   ```env
   NOTION_TOKEN=your_notion_integration_token
   NOTION_INBOUND_DATABASE_ID=your_inbound_db_id
   NOTION_OUTBOUND_DATABASE_ID=your_outbound_db_id
   NOTION_PIPELINE_DATABASE_ID=your_pipeline_db_id
   NOTION_RECRUITERS_DATABASE_ID=your_recruiters_db_id
   ```

### Development Commands
- Run Next.js local development server:
  ```bash
  npm run dev
  ```
- Build production package:
  ```bash
  # On Windows PowerShell
  cmd.exe /c "npm run build"
  ```
- Run Vitest unit & integration tests:
  ```bash
  npm run test
  ```
- Run E2E Playwright tests:
  ```bash
  npx playwright test
  ```
