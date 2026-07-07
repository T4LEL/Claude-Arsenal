---
name: optimize
description: Use when an app is slow, heavy, or expensive to run - or when the user says slow, performance, page speed, Lighthouse, bundle size, optimize, reduce hosting costs.
---

# Optimize

Fast and cheap, with proof — measurement is the entry fee: no measurements, no changes.

Copy this checklist and check off items as you complete them:

```
Optimize Progress:
- [ ] Step 1: Measure — real numbers across the stack
- [ ] Step 2: Rank — top 1-3 bottlenecks by impact
- [ ] Step 3: Fix — one bottleneck at a time
- [ ] Step 4: Re-measure — before/after pasted, revert if no gain
- [ ] Step 5: Lock in — perf budget recorded in CLAUDE.md
```

## Step 1 — Measure (paste real output, no exceptions)

Run every measurement that applies:

- Lighthouse / Web Vitals on the key pages — home, the page the user called slow, the critical conversion path.
- `next build` output for bundle size and per-route weight (or the equivalent build analyzer for the stack).
- `EXPLAIN ANALYZE` on any suspect query.
- Supabase MCP `get_advisors` for index and RLS-performance findings.
- The platform cost dashboard (Vercel usage, Supabase billing) for the actual dollar line items.

Numbers recalled from memory or a past session are unverified assumptions — label them that way and re-measure before acting on them. If nothing here can actually be run — no build, no query plan, no dashboard access — stop and report exactly what instrumentation is missing instead of guessing at fixes.

## Step 2 — Rank

List the bottlenecks found in Step 1 by user impact (what visitors feel) and cost impact (what shows up on the bill). Pick the top 1-3 only. Fixing bottleneck #7 while #1 still stands is wasted work.

## Step 3 — Fix

Delegate to the **performance-engineer** agent with one bottleneck at a time and the measurement that flagged it. Boring wins first: image formats/sizes, HTTP/data caching, N+1 queries, missing indexes, bundle splitting. Reach for anything exotic only after the boring list is exhausted. If the fix touches a library's caching or data-fetching API — Next.js, the Supabase client, anything version-sensitive — pull current usage via the context7 MCP tools first; these APIs shift across versions and a stale pattern is how "optimizations" quietly regress. Secrets stay in env vars and are never printed into chat, code, logs, or commits — a fix that needs a key belongs in an env var, not inline.

## Step 4 — Re-measure (mandatory)

Re-run the exact same measurements from Step 1, on the same pages and queries. Paste before/after numbers side by side. No measured improvement means revert — a change that doesn't move the number isn't a fix, it's churn.

## Step 5 — Lock in

Write the achieved numbers into the project CLAUDE.md as a perf budget — e.g. "LCP < 2.5s on /dashboard", "bundle < 200kb on /app", "$X/month hosting ceiling" — so future work is held to them, not just this pass.

Hard rule throughout: nothing from this skill — code change, CLAUDE.md edit, or budget update — is committed, pushed, or deployed without the user's explicit ask, whether or not Step 4's check passes.

## Report

- **Before/after numbers**: the Step 1 and Step 4 measurements, side by side, per bottleneck.
- **Changes made**: what actually changed and why, mapped to the bottleneck it addressed.
- **Reverted attempts**: anything tried that didn't move the numbers, and why it got rolled back.
- **Remaining known issues**: bottlenecks identified but not tackled this pass, still ranked.
- **Budget set**: the exact perf budget values written into CLAUDE.md.
