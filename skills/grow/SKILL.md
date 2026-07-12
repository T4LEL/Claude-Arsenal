---
name: grow
description: Use when working the growth loop on a launched product - or when the user says more users, growth, traffic is flat, improve conversion, improve retention. Run it monthly or when growth stalls.
---

# Grow

Run the growth loop on numbers, not hunches. No real numbers means no growth work yet — go get them first.

Copy this checklist and check off items as you complete them:

```
Grow Progress:
- [ ] Step 1: Numbers first — real funnel + retention pulled
- [ ] Step 2: Bottleneck identified
- [ ] Step 3: Experiments — 3 candidates + 1 recommendation
- [ ] Step 4: Ship it — routed to the right agent
- [ ] Step 5: Close the loop — review date + threshold set
- [ ] Report
```

## Step 1 — Numbers first

Delegate to the **data-analyst** agent with the product's database/analytics access: pull the current funnel (visitors → signup → activation → paid) and retention, from real queries against Supabase or whatever analytics source exists — not dashboards recalled from memory.

No numbers available: stop here and instrument first (events, a funnel view, a retention query). Guessing is not growth. Any figure not backed by a real query — including anything pulled from memory or a prior conversation — gets labeled an unverified assumption, never reported as data.

## Step 2 — Bottleneck

From the real funnel, identify the single weakest stage. Retention leaks outrank acquisition ideas — fixing the bucket beats pouring more water in it. State the bottleneck as a number (e.g. "38% activation → paid, industry-ish baseline is higher"), not a vibe.

## Step 3 — Experiments

Delegate to the **growth-marketer** agent with the funnel numbers and the identified bottleneck: 3 candidate experiments, each with a hypothesis, the metric it moves, an effort estimate, and a timebox. The agent picks ONE recommendation and says why over the other two — recommend by expected impact per unit effort, not novelty.

## Step 4 — Ship it

Route execution to the agent that owns the surface — never do the work in this skill directly:

- Copy changes (landing page, emails, onboarding text) → **copywriter** agent.
- Page/UI changes → **frontend-builder** agent.
- Emails, drip sequences, scheduled jobs → **automation-engineer** agent.
- SEO changes → **growth-marketer** agent for strategy plus **frontend-builder** agent for implementation.

Fetch current docs for any third-party integration (email provider, analytics, Stripe if the experiment touches pricing) via the context7 MCP tools before wiring it up. Keys and tokens stay in env vars, never printed into chat or committed. Nothing here gets committed, pushed, deployed, or published without the user's explicit ask.

Before closing Step 4, verify the change actually works where it runs — load the page, send the test email, hit the endpoint — and capture the evidence. An experiment that never really shipped can't be measured in Step 5.

## Step 5 — Close the loop

Set an explicit review date and a numeric success threshold for the experiment (e.g. "signup→activation from 38% to 45% by Aug 15"). An experiment without a threshold never closes — it just lingers. Suggest /loop or /schedule to automate the check-in so the review actually happens instead of getting forgotten.

## Report

- **Funnel snapshot:** real numbers, with the period they cover.
- **Bottleneck:** the weakest stage and why it was picked over the others.
- **Experiment shipped:** hypothesis, metric, and timebox for the one experiment executed.
- **Review date & threshold:** when it gets checked and the exact number that counts as a win.
