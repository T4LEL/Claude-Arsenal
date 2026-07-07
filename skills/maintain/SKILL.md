---
name: maintain
description: Use when doing periodic upkeep of a live product - or when the user says maintenance, update dependencies, check errors, housekeeping, is prod healthy. Run it monthly per live product.
---

# Maintain

Keep a live product healthy with a repeatable monthly sweep — don't wait for it to break.

Copy this checklist and check off items as you complete them:

```
Maintain Progress:
- [ ] Step 1: Health snapshot
- [ ] Step 2: Dependencies
- [ ] Step 3: Verify after updates (mandatory)
- [ ] Step 4: Data safety
- [ ] Step 5: Sweep
- [ ] Report
```

## Step 1 — Health snapshot

Pull platform logs for fresh errors (`vercel logs`, supabase MCP `get_logs`). Note the current error rate and compare hosting/API costs (Vercel, Supabase, any metered LLM usage) against last period — real numbers or stop and say the dashboard wasn't checked. Any figure not pulled from a live source this run is an unverified assumption; label it as such in the report.

## Step 2 — Dependencies

Run security advisories first — `npm audit` / `pip-audit`. Critical vulnerabilities get fixed now, no exceptions. Apply patch and minor updates in the same pass. List major updates as candidates only — never auto-apply one. Delegate to the **refactor-engineer** agent with the current version, target version, and changelog/migration notes (fetched via the context7 MCP tools) as its own task; a major upgrade needs its own plan and test pass, not a slot in a routine sweep.

## Step 3 — Verify after updates (mandatory)

Run tests, typecheck, and a production build after any dependency change. Paste the real output — not "should be fine." A failure rolls the update back immediately; debug on a branch rather than leaving a broken bump sitting on top of a working product.

## Step 4 — Data safety

Confirm backups exist, then restore-test one thing on a branch or staging — never against production. Supabase: use PITR or a branch restore. An untested backup is a hope, not a backup; if the restore-test fails, or hasn't been run this cycle, say so plainly instead of assuming it would work.

## Step 5 — Sweep

Triage the error log from Step 1 into fix-now vs backlog. Flag any cost anomaly (spike vs last period, a metered API creeping toward a plan limit) even without a diagnosis yet — flagging it is the job for this pass, not root-causing it on the spot.

Nothing in this skill commits, pushes, deploys, or publishes on its own — patch/minor updates and restore-tests stay local or on a branch/staging; ask before anything lands on production or main. Secrets stay in env vars and are never printed, logged, or pasted into the report.

## Report

- **Prod health:** error rate and fresh errors from Step 1, with the log source checked.
- **Updates applied:** patch/minor updates applied, with verification output from Step 3.
- **Deferred majors:** major versions available, queued for the refactor-engineer agent, not applied.
- **Backup status:** backup confirmed plus restore-test result — pass, fail, or not run.
- **Cost trend:** current period vs last period, any anomaly flagged.
- **Backlog additions:** errors triaged to backlog rather than fixed this cycle.
