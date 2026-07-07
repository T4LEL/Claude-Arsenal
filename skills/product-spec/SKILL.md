---
name: product-spec
description: Use when a feature or product needs a spec before building - or when the user says PRD, spec this out, requirements, user stories, what should v1 include.
---

# Product Spec

Turn an idea into a build-ready spec. Decisions get made on paper, not discovered mid-implementation.

Copy this checklist and check off items as you complete them:

```
Product-Spec Progress:
- [ ] Step 1: PRD — problem, user stories, out-of-scope, riskiest assumption
- [ ] Step 2: Flows — user flows, screens, edge states
- [ ] Step 3: Feasibility gate (skip for trivial features)
- [ ] Step 4: Save spec + hand off
```

## Step 1 — PRD

Delegate to the **product-manager** agent with the idea and target user: problem statement, user stories with verifiable acceptance criteria (not "user can log in" but "user can log in with email+password and sees an error on wrong credentials"), an explicit out-of-scope list, and the single riskiest assumption the whole idea rests on.

## Step 2 — Flows

Delegate to the **ux-designer** agent with the PRD: user flows for each user story, a screen inventory, and empty/loading/error states for every screen. A screen with no error state isn't designed yet.

## Step 3 — Feasibility gate (skip for trivial features)

Delegate to the **architect** agent with the PRD and flows: data model implications (new tables, migrations against the existing Supabase schema), integration points (Stripe, third-party APIs, FastAPI services), and anything that forces the spec to change. Fetch current docs via the context7 MCP tools before ruling an integration in or out — don't reason about API limits from memory. Loop material conflicts back to product-manager/ux-designer once; don't iterate past that without the user's input.

Trivial feature (a single new field, a copy change, a UI-only tweak) — skip this step and say so in the report.

## Step 4 — Save + hand off

Write the spec into the project at `docs/specs/<date>-<name>.md`, merging the PRD, flows, and feasibility findings into one document. Writing the file is not committing it — never commit, push, or deploy without the user's explicit ask.

Hand off to superpowers:writing-plans for implementation planning. This skill ends at "what to build and why," not "how to build it."

## Report

- **Spec:** path to the saved file + a 3-line summary.
- **V1 scope:** the user stories that ship in v1.
- **Deferred:** everything explicitly out-of-scope, and why.
- **Assumptions to validate:** the riskiest assumption plus any figure pulled from memory (market size, competitor pricing, API limits) — label these unverified until checked against real numbers or stop and flag them before the user commits engineering time.
