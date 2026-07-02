---
name: ship-it
description: Use when deploying a project to production - first deploy or an update - or when the user says ship it, deploy, go live, push to prod, or release.
---

# Ship It

Pre-flight → deploy → verify. Never skip pre-flight to "just get it out."

Copy this checklist and check off items as you complete them:

```
Ship-It Progress:
- [ ] Step 1: Pre-flight — every gate passes
- [ ] Step 2: Deploy (DB before code)
- [ ] Step 3: Verify live (mandatory)
- [ ] Step 4: Report
```

## Step 1 — Pre-flight (every gate must pass; paste real output)

1. `git status` clean or only intended changes; on the expected branch.
2. Tests pass. Typecheck/lint passes. Production build passes (`npm run build` / equivalent). If no test suite exists, record that as a risk in the report and run whatever checks do exist — never report a gate as passed that doesn't exist.
3. **Env vars:** diff `.env.example` against the platform's configured vars (`vercel env ls`) — every required var present in production, no secret committed anywhere (check `git ls-files` for tracked env files).
4. **Database:** pending migrations identified; migrations are backward-compatible with currently-running code (deploy DB first, then code). Supabase: run the supabase MCP `get_advisors` tool and triage security findings — RLS gaps block the deploy.
5. **First deploy only:** run the security-auditor agent on the codebase; Critical findings block.

A failed gate stops the deploy: fix it, or get the user's explicit go-ahead to ship anyway and record that in the report. Never reinterpret a failing gate as passing.

## Step 2 — Deploy

- **Next.js:** `vercel --prod` (or push to main if CI-driven — check which mode the project uses first). If the CLI isn't logged in or the project isn't linked, stop and ask the user to run `vercel login` / `vercel link` — never guess credentials.
- **Supabase migrations:** `supabase db push` (or the supabase MCP `apply_migration` tool) BEFORE the code deploy.
- **Other stacks:** follow the project CLAUDE.md's deploy section; if none exists, stop and write one first with the devops-engineer agent.

Deploying is outward-facing: on a FIRST production deploy or anything user-visible and irreversible, confirm with the user before executing unless they already said to ship.

## Step 3 — Verify live (mandatory)

1. Request the production URL — expect 200 and real content, not just exit code 0 from the CLI.
2. Exercise the critical path once (signup/login/core action) via curl or playwright.
3. Check platform logs for fresh errors (`vercel logs`, supabase MCP `get_logs`).
4. If broken: roll back FIRST (`vercel rollback` / redeploy previous), debug second. Lead the report with the rollback.

## Step 4 — Report

URL, what shipped, verification evidence, and any follow-ups (warnings triaged as non-blocking, advisors to revisit, gates the user explicitly waived).
