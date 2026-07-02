# Claude Builder Toolkit

Your permanent toolkit for building any app with Claude Code and Anthropic models: 12 specialist agents, 3 lifecycle skills, and CLAUDE.md templates. This repo is the **source of truth** — it's portable for life: push it to a private GitHub repo, clone it on any machine, run `sync.ps1`.

## One-time setup (per machine)

1. Clone this repo.
2. Run `.\sync.ps1` — copies `agents/` and `skills/` into `~/.claude/`.
3. Install the companion plugins (in Claude Code: `/plugin`): **superpowers**, **frontend-design**, **playwright**, **supabase**, **context7**. They provide the process layer (brainstorming, planning, TDD, debugging, design, browser testing, live docs) — this toolkit deliberately doesn't duplicate them.

After editing any agent/skill here, re-run `.\sync.ps1`.

## The lifecycle: idea → income

1. **Idea** → `/new-project` — brainstorms the design (via superpowers), scaffolds the folder, applies the right CLAUDE.md, git init, verifies it runs.
2. **Money first** → `/monetize` — customer, pricing, MVP-to-charge feature list. Do this before building features on anything meant to earn; pricing shapes scope.
3. **Build** → work in the project with Claude Code. Plans via `superpowers:writing-plans`; delegate bounded tasks to the builder agents; TDD via superpowers.
4. **Check** → `/code-review` on the diff; code-reviewer / security-auditor agents for deeper passes.
5. **Ship** → `/ship-it` — pre-flight checklist, deploy (Vercel + Supabase), verify the live URL.
6. **Grow** → biz-strategist agent for launch, landing copy, pricing changes.

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
| biz-strategist | sonnet | Monetization, pricing, MVP scoping, landing copy, launch |

Delegation habits (from global CLAUDE.md): don't spawn an agent for what two Grep/Read calls answer; parallelize independent agent tasks; builders get bounded tasks with acceptance criteria.

## Skills (`skills/` → `~/.claude/skills/`)

- **/new-project** — idea to running, git-tracked, Claude-ready skeleton (webapp / api / other presets).
- **/ship-it** — pre-flight, deploy, live verification.
- **/monetize** — model, pricing, Stripe plan, landing page, launch checklist.

## Templates (`templates/` — used by /new-project)

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
