---
name: add-auth
description: Use when adding user accounts to an app - signup, login, OAuth, protected routes, sessions - or when the user says auth, login, sign in with Google, user accounts, protect this page.
---

# Add Auth

Add authentication to the default stack correctly the first time — auth bugs are security bugs.

Copy this checklist and check off items as you complete them:

```
Add-Auth Progress:
- [ ] Step 1: Requirements
- [ ] Step 2: Data (db-designer)
- [ ] Step 3: Implementation (backend-builder)
- [ ] Step 4: Verify (mandatory)
- [ ] Step 5: Audit (security-auditor)
- [ ] Report
```

## Step 1 — Requirements

Confirm before building:

- Sign-in methods: email/password, magic link, which OAuth providers.
- Roles: does an admin/staff tier exist, or is every account equal?
- Protected surface: which pages/routes require a session, which stay public.

Defaults when the user doesn't specify: email/password plus Google OAuth, a single user role, every app page protected except marketing pages (home, pricing, blog).

## Step 2 — Data

Delegate to the **db-designer** agent with: a `profiles` table keyed to `auth.users` (1:1 on `id`), deny-by-default RLS policies (no table readable or writable without an explicit policy), and a trigger that creates the profile row on signup (`on auth.users insert`).

## Step 3 — Implementation

Delegate to the **backend-builder** agent with: `@supabase/ssr` client and server helpers plus middleware, built against CURRENT docs fetched via the context7 MCP tools — the cookie/session-refresh pattern changes between package versions and stale patterns silently break sessions. Cover: login, signup, logout, the OAuth callback route, and protected-route handling (middleware redirect, not a client-side check alone). Keys and secrets stay in env vars, never printed or committed.

## Step 4 — Verify (mandatory)

Exercise the real flow, not a mental walkthrough — use the playwright plugin or curl:

1. Sign up a fresh user; confirm the profile row was created.
2. Log in; confirm a session cookie is set.
3. Load a protected page while authenticated; confirm it renders.
4. Log out; confirm the session is cleared.
5. Request a protected resource with no session (curl, no cookie) — it must fail (redirect or 401/403), not leak data.

Paste the real output for each step. A step reported done without evidence is not done.

## Step 5 — Audit

Delegate to the **security-auditor** agent scoped to the auth surface: RLS policies, the OAuth callback, session/cookie handling, and protected-route middleware. Critical findings block done — fix and re-verify before reporting complete.

## Report

- **Enabled methods:** sign-in methods shipped (password, magic link, OAuth providers).
- **Protected surface:** which routes require a session, which are public.
- **RLS summary:** policies per table, deny-by-default confirmed.
- **Verification evidence:** the pasted output from Step 4, all five checks.
- **Follow-ups:** audit findings not fixed (with reason), plus anything deferred — e.g. roles/admin tier if not in scope this round.
