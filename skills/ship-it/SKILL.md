---
name: ship-it
description: Use when deploying a project to production (first deploy or updates) - runs the pre-flight checklist (tests, build, env vars, migrations, security), deploys, and verifies the live site actually works.
---

# Ship It

Pre-flight → deploy → verify. Never skip pre-flight to "just get it out."

## Step 1 — Pre-flight (all must pass; paste real output)

1. `git status` clean or only intended changes; on the expected branch.
2. Tests pass. Typecheck/lint passes. Production build passes (`npm run build` / equivalent).
3. **Env vars:** diff `.env.example` against the platform's configured vars (`vercel env ls`) — every required var present in production, no secret committed anywhere (`git ls-files | grep -i env`).
4. **Database:** pending migrations identified; migrations are backward-compatible with currently-running code (deploy DB first, then code). Supabase: run `get_advisors` and triage security findings — RLS gaps block the deploy.
5. **First deploy only:** run the security-auditor agent on the codebase; Critical findings block.

## Step 2 — Deploy

- **Next.js:** `vercel --prod` (or push to main if CI-driven — check which mode the project uses first).
- **Supabase migrations:** `supabase db push` (or `apply_migration` via MCP) BEFORE the code deploy.
- **Other stacks:** follow the project CLAUDE.md's deploy section; if none exists, stop and write one first with the devops-engineer agent.

Deploying is outward-facing: on a FIRST production deploy or anything user-visible and irreversible, confirm with the user before executing unless they already said to ship.

## Step 3 — Verify live (mandatory)

1. Request the production URL — expect 200 and real content, not just exit code 0 from the CLI.
2. Exercise the critical path once (signup/login/core action) via curl or playwright.
3. Check platform logs for fresh errors (`vercel logs`, Supabase `get_logs`).
4. If broken: roll back first (`vercel rollback` / redeploy previous), debug second.

## Step 4 — Report

URL, what shipped, verification evidence, and any follow-ups (warnings triaged as non-blocking, advisors to revisit).
