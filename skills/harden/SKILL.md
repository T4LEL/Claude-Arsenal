---
name: harden
description: Use when doing a security pass on a product - before real users, payments, or sensitive data - or when the user says security check, is this secure, audit, lock it down.
---

# Harden

A defensive security pass, deeper than the /ship-it deploy gate. Run before real users, payments, or sensitive data.

Copy this checklist and check off items as you complete them:

```
Harden Progress:
- [ ] Step 1: Audit
- [ ] Step 2: Triage
- [ ] Step 3: Fix
- [ ] Step 4: Verify (mandatory)
- [ ] Step 5: Record
- [ ] Report
```

## Step 1 — Audit

Delegate to the **security-auditor** agent with a full pass over: auth flows, RLS/access control, input validation, secret handling, security headers, rate limiting, dependency audit. On Supabase, also run the supabase MCP `get_advisors` tool and fold its output into the same findings list. If any current-library security guidance is needed (auth library config, header middleware, CSP syntax), fetch it via the context7 MCP tools rather than relying on memory. Secrets encountered during the audit stay in env vars and are never printed into chat, code, logs, or commits.

## Step 2 — Triage

Every finding gets a severity — Critical / High / Medium / Low — and a concrete exploit scenario: who, what request, what they get. A finding without an exploit scenario is not triaged yet; send it back to the security-auditor agent for specifics rather than guessing at a severity. Any severity or count you can't verify from real output is an unverified assumption — label it, don't state it as fact.

## Step 3 — Fix

Criticals and Highs get fixed now. Route each to the right builder agent as one bounded task per fix: schema/RLS/policy issues to the **db-designer** agent, application-level issues (auth checks, input validation, headers, rate limiting) to the **backend-builder** agent, and dependency vulnerabilities to the **backend-builder** agent for patch/minor bumps or the **refactor-engineer** agent when the fix requires a major upgrade. Don't batch unrelated fixes into one task — each fix needs its own verification in Step 4. Never commit, push, deploy, or publish fixes without the user's explicit ask.

## Step 4 — Verify (mandatory)

Re-audit the changed surface, then attempt the original exploit for real where safe — for example, an unauthenticated request against RLS-protected data must now fail; a bypassed rate limit must now trip. Paste the real output (request, response, status code). A fix without a repeated-exploit-attempt is not verified — report it as unverified rather than claiming it's fixed.

## Step 5 — Record

Any Medium or Low deliberately left unfixed is an accepted risk, not a forgotten one: write down what it is, why it's acceptable for now, and the concrete trigger that means revisit it (a launch milestone, a user count, a new data type touching that surface).

## Report

- **Findings by severity:** every Critical/High/Medium/Low finding with its exploit scenario.
- **Fixed & verified:** what changed, which agent did it, and the real re-exploit-attempt evidence.
- **Accepted risks:** Medium/Low items deliberately deferred, with reason.
- **Next audit trigger:** the concrete event that should bring this skill back (new payment flow, new PII field, next real-user milestone).
