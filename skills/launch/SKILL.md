---
name: launch
description: Use when taking a shipped product to the public - or when the user says launch, announce, Product Hunt, go public, get first users. Deploying is /ship-it; this is getting humans to show up.
---

# Launch

Get humans to show up — everything gets drafted, the user posts it; never auto-publish anywhere.

Copy this checklist and check off items as you complete them:

```
Launch Progress:
- [ ] Step 1: Gate — production live, signup verified
- [ ] Step 2: Assets — copy, legal, analytics, OG tags
- [ ] Step 3: Channel plan
- [ ] Step 4: Posts drafted
- [ ] Step 5: Day-of runbook
- [ ] Report
```

## Step 1 — Gate (paste real output)

Request the production URL and confirm it loads with real content. Run signup end to end and confirm it actually completes — not "looks right," an observed result. If it's not live or signup is broken, stop here and run /ship-it first; launching an unshipped product wastes the channel goodwill.

## Step 2 — Assets

- Delegate to the **copywriter** agent with the product and audience: a landing copy pass where the headline states the customer outcome and there is exactly one CTA.
- Delegate to the **legal-advisor** agent with what tracking is actually implemented: privacy policy and any other legal pages, written to match the real tracking in place — not boilerplate claiming data collection that doesn't exist.
- Delegate to the **data-analyst** agent with the funnel: minimal events for visit, signup, activation, instrumented and confirmed firing (real event in a real dashboard, not "should work"). Any analytics or tracking keys stay in env vars, never printed in chat, code, or docs.
- Check OG/meta tags render correctly when the link is shared — paste a real preview (link debugger or equivalent), not an assumption. Fetch current docs via the context7 MCP tools for any tracking or meta-tag SDK involved.

## Step 3 — Channel plan

Delegate to the **growth-marketer** agent with the product, audience, and Step 2 assets: channels ranked by fit and effort, the first 3 concrete actions for each, and a launch-day sequence with rough timing. Any market or conversion benchmarks the agent cites from general knowledge rather than this product's real data get labeled unverified assumptions in the report.

## Step 4 — Posts

Delegate to the **copywriter** agent with the channel plan: draft one launch post per channel, written in that channel's native tone — never one blob cross-posted everywhere. Every draft stays a draft. The user reads it and posts it themselves; nothing here publishes on its own, and nothing gets scheduled or sent without the user's explicit go-ahead.

## Step 5 — Day-of runbook

Posting order and times taken from the Step 3 sequence, what to monitor during the window (errors, signup counts — real numbers pulled from logs/dashboards, or say plainly they're not available yet), and the week-one follow-up actions (replying to comments, second-wave channels, a follow-up post).

## Report

- **Launch readiness:** asset checklist status — what's built and verified vs. still open.
- **Channel plan:** ranked channels, effort, first 3 actions each.
- **Posts drafted:** which channels have drafts ready for the user to post.
- **Metrics to watch:** the funnel events and where to watch them.
- **Week-one plan:** the follow-up actions and rough timing.
