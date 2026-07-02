# {{project-name}}

{{One sentence: what this app does and for whom.}}

## Stack

Next.js (App Router) + TypeScript + Tailwind CSS + Supabase (Postgres/Auth/Storage) + Vercel.

## Commands

- Dev server: `npm run dev` (http://localhost:3000)
- Typecheck: `npx tsc --noEmit`
- Lint: `npm run lint`
- Test: `{{npm test — fill in when tests exist}}`
- Build: `npm run build`
- New migration: add SQL file to `supabase/migrations/`, apply via Supabase MCP `apply_migration`

## Structure

- `src/app/` — routes (App Router). Server components by default; `"use client"` only when interaction requires it.
- `src/components/` — shared UI components
- `src/lib/` — utilities, Supabase clients (`src/lib/supabase/`)
- `supabase/migrations/` — all schema changes (never ad-hoc SQL in prod)

## Rules

- All data access respects RLS; new tables get RLS enabled + policies in the same migration. Service-role key server-side only.
- Secrets in env vars only; keep `.env.example` updated (names + comments, no values). Only `NEXT_PUBLIC_*` vars may reach the client.
- Validate all input at API/server-action boundaries.
- Mutations check ownership server-side — never trust client-provided IDs.
- Handle loading/empty/error states in every data-driven component.
- Before claiming done: `npm run build` and typecheck pass — paste output.

## Deploy

Vercel: `{{CI on push to main | vercel --prod — pick one}}`. Migrations pushed to Supabase BEFORE code deploy. Verify the live URL after every deploy.

## Product notes

{{Target customer, pricing model if paid, links to design docs in docs/.}}
