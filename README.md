# Claude Arsenal

Every agent and skill you'll ever need to build, ship, and monetize anything with Claude Code: 25 specialist agents, 14 lifecycle skills, and CLAUDE.md templates. This repo is the **source of truth** — it's portable for life: clone it on any machine, run `sync.ps1`.

## One-time setup (per machine)

1. Clone this repo.
2. Run `.\sync.ps1` — validates every agent/skill frontmatter (fails loudly on broken files), then copies `agents/` and `skills/` into `~/.claude/` and bundles `templates/` into the deployed new-project skill.
3. Install the companion plugins (in Claude Code: `/plugin`): **superpowers**, **frontend-design**, **playwright**, **supabase**, **context7**. They provide the process layer (brainstorming, planning, TDD, debugging, design, browser testing, live docs) — this toolkit deliberately doesn't duplicate them.

After editing any agent/skill here, re-run `.\sync.ps1`.

## The lifecycle: idea → income → company

1. **Validate** → `/validate-idea` — evidence and a go/no-go verdict before any code exists.
2. **Idea** → `/new-project` — brainstorms the design (via superpowers), scaffolds the folder, applies the right CLAUDE.md, git init, verifies it runs.
3. **Money first** → `/monetize` — customer, pricing, MVP-to-charge feature list. Do this before building features on anything meant to earn; pricing shapes scope.
4. **Spec** → `/product-spec` — PRD, flows, and a feasibility pass before building anything non-trivial.
5. **Build** → work in the project with Claude Code. Plans via `superpowers:writing-plans`; delegate bounded tasks to the builder agents; TDD via superpowers. Common features have skills: `/add-auth`, `/add-ai`.
6. **Check** → `/code-review` on the diff; code-reviewer / security-auditor agents for deeper passes; `/harden` before real users or payments; `/optimize` when it's slow or costly.
7. **Ship** → `/ship-it` — pre-flight checklist, deploy (Vercel + Supabase), verify the live URL.
8. **Launch** → `/launch` — assets, channel plan, drafted posts, day-of runbook.
9. **Grow** → `/grow` — numbers-first experiment loop, monthly or when growth stalls.
10. **Run the business** → `/maintain` (monthly upkeep), `/pitch` (fundraising), `/hire` (first contractors/employees).

## Agents (`agents/` → `~/.claude/agents/`)

| Agent | Model | Use for |
|-------|-------|---------|
| architect | sonnet | System/feature design before building; returns design docs |
| backend-builder | sonnet | API routes, business logic, integrations (Stripe, webhooks) |
| frontend-builder | sonnet | Pages, components, forms, styling, accessibility |
| db-designer | sonnet | Schemas, migrations, RLS policies, indexes |
| test-engineer | sonnet | Tests, bug reproductions, edge-case hunting |
| code-reviewer | sonnet | Read-only diff review: bugs, security, complexity |
| security-auditor | sonnet | Read-only defensive audit: auth, RLS, secrets, input |
| devops-engineer | sonnet | Deploys, CI/CD, Dockerfiles, env var management |
| debugger | sonnet | Root-cause investigation with evidence |
| researcher | haiku | Library comparisons, docs research, broad exploration |
| docs-writer | haiku | READMEs, guides, API docs (verified against code) |
| biz-strategist | sonnet | Monetization, pricing, MVP scoping, landing-copy draft, launch |
| product-manager | sonnet | PRDs, user stories, scope cutting, prioritization |
| ux-designer | sonnet | User flows, screen maps, IA, onboarding, usability review |
| mobile-builder | sonnet | React Native/Expo screens, native features, store release |
| data-analyst | sonnet | Metrics/KPIs, analytics SQL, tracking plans, funnels/cohorts |
| ai-engineer | sonnet | Claude API features, prompts, RAG, evals, cost tuning |
| performance-engineer | sonnet | Profiling, Web Vitals, slow queries, caching — numbers first |
| refactor-engineer | sonnet | Behavior-preserving refactors, upgrades, migrations |
| automation-engineer | sonnet | Scripts, scrapers, pipelines, scheduled jobs, API glue |
| growth-marketer | sonnet | SEO, channels, email lifecycle, funnel diagnosis |
| copywriter | sonnet | Landing/email/microcopy, blog, launch posts, store listings |
| finance-analyst | sonnet | Unit economics, SaaS metrics, projections, runway |
| legal-advisor | sonnet | ToS/privacy, GDPR basics, OSS licenses, contractor checklists |
| market-analyst | sonnet | TAM/SAM/SOM sizing, competitive landscape, segments, why-now |

Delegation habits (from global CLAUDE.md): don't spawn an agent for what two Grep/Read calls answer; parallelize independent agent tasks; builders get bounded tasks with acceptance criteria.

## Skills (`skills/` → `~/.claude/skills/`)

Build:

- **/validate-idea** — evidence-based go/no-go before any code.
- **/new-project** — idea to running, git-tracked, Claude-ready skeleton (webapp / api / other presets).
- **/product-spec** — PRD + flows + feasibility gate, saved into the project.
- **/add-auth** — Supabase auth done right: RLS, SSR helpers, verified flow, audit.
- **/add-ai** — LLM features with evals, cost estimates, and injection guardrails.

Ship & harden:

- **/ship-it** — pre-flight, deploy, live verification.
- **/harden** — full security pass: audit → fix → verify → accepted risks.
- **/optimize** — measure → fix top bottlenecks → re-measure → perf budget.
- **/maintain** — monthly upkeep: errors, dep updates, backups, costs.

Earn & grow:

- **/monetize** — model, pricing, Stripe plan, landing page, launch checklist.
- **/launch** — launch assets, channel plan, drafted posts, day-of runbook.
- **/grow** — numbers-first growth loop: funnel → bottleneck → one experiment.
- **/pitch** — investor narrative, sourced numbers, deck outline, objection prep.
- **/hire** — role scorecard, JD, sourcing, structured interview loop, contract checklist.

## Templates (`templates/` — used by /new-project)

`sync.ps1` bundles this folder into `~/.claude/skills/new-project/templates/` so the deployed skill is self-contained. Edit templates here, never the synced copy.

- `CLAUDE.webapp.md` — Next.js + TypeScript + Tailwind + Supabase + Vercel (the default stack)
- `CLAUDE.api.md` — Python + FastAPI
- `CLAUDE.generic.md` — anything else
- `project-structures.md` — reference layouts: CLI, extension, desktop (Tauri), mobile (Expo), static site, monorepo

## Extending the toolkit

- **New agent:** add `agents/<name>.md` (frontmatter: name, description starting "Use this agent...", model, optional tools) — keep haiku for research-shaped work, sonnet for building. Re-sync.
- **New skill:** add `skills/<name>/SKILL.md` (frontmatter: name, description starting "Use when..."). The `superpowers:writing-skills` skill guides good skill design. Re-sync.
- **New stack preset:** add a `templates/CLAUDE.<type>.md` and a scaffold section in `skills/new-project/SKILL.md`.
- Keep everything here versioned — commit after each change so no machine ever holds the only copy.

## Accounts this toolkit assumes (create once)

GitHub (code + CI), Vercel (hosting), Supabase (DB/auth), Stripe (payments), a domain registrar. All have free tiers except the domain.
