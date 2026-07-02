---
name: new-project
description: Use when starting any new app, webapp, API, tool, or side project from scratch - when the user names an idea to build or says new project, scaffold, start a repo, set up a project. Produces a running, git-tracked, Claude-ready project skeleton.
---

# New Project

Take a raw idea to a running, git-tracked, Claude-ready project skeleton.

Templates are bundled with this skill in `templates/` (synced copies — the source of truth is the toolkit repo at `X:\Projects\ClaudeCode\templates\`; edit there, then re-run `sync.ps1`).

Copy this checklist and check off items as you complete them:

```
New Project Progress:
- [ ] Step 1: Gather requirements
- [ ] Step 2: Design gate
- [ ] Step 3: Scaffold by type
- [ ] Step 4: CLAUDE.md + git init
- [ ] Step 5: Verify it runs (mandatory)
- [ ] Step 6: Hand off
```

## Step 1 — Gather

Use what the user already provided (including arguments to this skill); ask only for what's missing.

- **Name** (kebab-case) and one-line purpose.
- **Type:** webapp (default), api, or other.
- **Location:** default `X:\Projects\<name>`.
- **Paid product?** If yes, note it — Step 6 points at `/monetize`.

## Step 2 — Design gate

If the product hasn't been brainstormed yet in this conversation, invoke `superpowers:brainstorming` for the product itself BEFORE scaffolding. Never scaffold an undesigned product. If a design/spec already exists, proceed.

## Step 3 — Scaffold by type

If a scaffold command fails, stop and fix it before continuing: read the exact error; for generator flag errors run the generator's `--help` and adapt — flags drift between versions and the intent below matters more than the exact flags. Never leave a half-scaffolded folder silently: finish it, or delete it and report why.

**webapp** (Next.js + TypeScript + Tailwind + Supabase):

```powershell
npx create-next-app@latest <name> --typescript --tailwind --eslint --app --src-dir --import-alias "@/*" --use-npm --yes
cd <name>
npm install @supabase/supabase-js @supabase/ssr
```

Then create `.env.example` (NEXT_PUBLIC_SUPABASE_URL, NEXT_PUBLIC_SUPABASE_ANON_KEY, commented), `src/lib/supabase/` client helpers per current `@supabase/ssr` docs (fetch them via the context7 MCP tools — the cookie/session patterns change), and a `supabase/migrations/` folder. Only create the actual Supabase project when the design needs a database — ask before creating cloud resources.

**api** (Python + FastAPI):

```powershell
mkdir <name>; cd <name>
python -m venv .venv; .\.venv\Scripts\Activate.ps1
pip install fastapi "uvicorn[standard]" pytest httpx; pip freeze > requirements.txt
```

Structure: `app/main.py` (FastAPI instance + health route), `app/routers/`, `app/models.py`, `tests/test_health.py`.

**other** (CLI, extension, desktop, mobile): consult `templates/project-structures.md` for the layout, scaffold minimally with the ecosystem's official generator.

## Step 4 — Claude-ready

1. Copy the matching template from this skill's `templates/` — `CLAUDE.webapp.md`, `CLAUDE.api.md`, or `CLAUDE.generic.md` — to the project root as `CLAUDE.md` and fill every `{{placeholder}}`.
2. Check your work: search the new CLAUDE.md for `{{` — it must return zero matches.
3. `git init`; ensure `.gitignore` covers `.env*` (except `.env.example`), `node_modules`/`.venv`, build output.
4. Do NOT commit — per global rules the user commits explicitly.

## Step 5 — Verify (mandatory)

Run the real check and paste its real output. webapp: `npm run build`. api: `pytest`. other: the ecosystem's build/test command.

- Passes → continue to Step 6.
- Fails → fix and re-run until it passes. If you cannot make it pass, report the exact failing output and what you tried — never hand off a skeleton claimed as working without passing output.

## Step 6 — Hand off

Report: location, what was scaffolded, verification output. Suggest next actions: write the first vertical slice (`superpowers:writing-plans`), and if it's a paid product, run `/monetize` BEFORE building features — pricing shapes scope.
