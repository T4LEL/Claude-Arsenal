---
name: validate-idea
description: Use when deciding whether an idea is worth building - before any scaffolding or code - or when the user says validate, is this worth it, would anyone pay, market check, should I build this.
---

# Validate Idea

Kill or confirm an idea cheaply before /new-project scaffolds anything. No code, no scaffolding — this skill produces a verdict, not a repo.

Copy this checklist and check off items as you complete them:

```
Validate-Idea Progress:
- [ ] Step 1: Frame — customer, problem, current alternative
- [ ] Step 2: Evidence — competitor scan + demand signals
- [ ] Step 3: Verdict — would they pay, differentiation
- [ ] Step 4: Cheapest real-world test
- [ ] Report
```

## Step 1 — Frame

State each in one sentence. Use what the user gave; where they left gaps, state an assumption explicitly and label it unverified.

- Who exactly is the customer?
- What painful problem are they having?
- What do they use today instead (including "nothing" or "a spreadsheet")?

Vague answers here (e.g. "everyone," "it'd just be useful") are the first sign the idea isn't ready — say so instead of pushing forward.

## Step 2 — Evidence

Delegate to the **researcher** agent with the framing from Step 1:

- Competitor scan: real products, real URLs, current prices — not "probably around $X."
- Demand signals: actual search results, community complaints and threads (Reddit, forums, X, App Store reviews) showing people describing this exact pain.

No evidence found is itself a finding — report it, don't paper over it with assumptions.

For a deeper pass — market sizing (TAM/SAM/SOM) or a full competitive landscape — delegate to the **market-analyst** agent with the same Step 1 framing.

## Step 3 — Verdict

Delegate to the **biz-strategist** agent with the Step 2 evidence:

- Would the target customer actually pay for this, and roughly how much?
- What's the differentiation from what they use today — why switch?
- A verdict — go / no-go / pivot — with the reasoning that drove it, not just the label.

Numbers the agent can't source from real evidence get labeled unverified assumptions, not stated as fact.

## Step 4 — Cheapest real-world test

Pick exactly ONE, matched to how fast/cheap it is to run for this idea:

- **5 target-customer conversations** — real people who fit the customer profile, scheduled this week.
- **Landing-page smoke test** — one page, one CTA, traffic driven to it.
- **Community post** — pitch the problem/solution where the target customer already hangs out.

Spell out the concrete next actions (who does what, by when) and a numeric success threshold up front — e.g. "10 signups in a week," "3 of 5 conversations confirm the pain unprompted." No threshold means no test.

If the Step 3 verdict is go, point the user at /new-project to scaffold and /monetize to lock pricing before building features.

## Report

- **Verdict:** go / no-go / pivot, one-line reason.
- **Evidence:** competitor and demand findings, with sources.
- **Riskiest assumption:** the single belief that, if wrong, breaks the idea.
- **Cheapest next test:** the chosen test, concrete actions, and the numeric success threshold.
