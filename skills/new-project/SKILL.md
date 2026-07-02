---
name: new-project
description: Use when starting any new app, webapp, API, or tool from scratch - scaffolds the project folder, applies the right CLAUDE.md template, sets up git and the dev environment, and verifies everything runs before real work begins.
---

# New Project

Take a raw idea to a running, git-tracked, Claude-ready project skeleton. Toolkit home: `X:\Projects\ClaudeCode` (templates live in `templates/`).

## Step 1 — Gather (ask only what's missing)

- **Name** (kebab-case) and one-line purpose.
- **Type:** webapp (default), api, or other.
- **Location:** default `X:\Projects\<name>`.
- **Paid product?** If yes, note it — Step 6 will point at `/monetize`.

## Step 2 — Design gate

If the product hasn't been brainstormed yet in this conversation, invoke `superpowers:brainstorming` for the product itself BEFORE scaffolding. Never scaffold an undesigned product. If a design/spec already exists, proceed.

## Step 3 — Scaffold by type

**webapp** (Next.js + TypeScript + Tailwind + Supabase):

```powershell
npx create-next-app@latest <name> --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --yes
cd <name>
npm install @supabase/supabase-js @supabase/ssr
```

Then create `.env.example` (NEXT_PUBLIC_SUPABASE_URL, NEXT_PUBLIC_SUPABASE_ANON_KEY, commented), `src/lib/supabase/` client helpers per current `@supabase/ssr` docs (check context7 — patterns change), and a `supabase/migrations/` folder. Only create the actual Supabase project when the design needs a database — ask before creating cloud resources.

**api** (Python + FastAPI):

```powershell
mkdir <name>; cd <name>
python -m venv .venv; .\.venv\Scripts\Activate.ps1
pip install fastapi "uvicorn[standard]" pytest httpx; pip freeze > requirements.txt
```

Structure: `app/main.py` (FastAPI instance + health route), `app/routers/`, `app/models.py`, `tests/test_health.py`.

**other** (CLI, extension, desktop, mobile): consult `templates/project-structures.md` for the layout, scaffold minimally with the ecosystem's official generator.

## Step 4 — Claude-ready

1. Copy the matching template — `templates/CLAUDE.webapp.md`, `templates/CLAUDE.api.md`, or `templates/CLAUDE.generic.md` — to the project root as `CLAUDE.md` and fill every `{{placeholder}}`.
2. `git init`, ensure `.gitignore` covers `.env*` (except `.env.example`), `node_modules`/`.venv`, build output.
3. Do NOT commit — per global rules the user commits explicitly.

## Step 5 — Verify (mandatory)

Run the dev server / tests and confirm they actually work; paste real output. webapp: `npm run build`. api: `pytest`. A skeleton that doesn't run is not done.

## Step 6 — Hand off

Report: location, what was scaffolded, verification output. Suggest next actions: write the first vertical slice (superpowers:writing-plans), and if it's a paid product, run `/monetize` BEFORE building features — pricing shapes scope.
