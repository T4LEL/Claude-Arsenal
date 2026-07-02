---
name: monetize
description: Use when turning a project into a money-making product - choosing the monetization model and pricing, planning Stripe integration, writing the landing page, and building the launch checklist. Run it early; pricing shapes scope.
---

# Monetize

Turn a product into revenue. Run BEFORE building most features — what people pay for defines the MVP.

## Step 1 — Foundation (answer honestly before anything else)

Delegate to the **biz-strategist** agent with the product idea and target user:

- Who exactly is the customer, and what painful problem does this solve?
- What do they use today (including "nothing"), and why switch?
- Competitor scan with real current prices.

If the answers are weak, stop here and report that — integrating Stripe into a product nobody pays for is wasted work.

## Step 2 — Model & pricing

From the biz-strategist output, lock in: ONE monetization model, 2-3 price tiers max with concrete numbers, and the "needed to charge the first customer" feature list. Everything not on that list is deferred.

## Step 3 — Payment integration (when there's something to sell)

Default: **Stripe**. Standard shape for a SaaS webapp:

1. Stripe Checkout (hosted) for purchase — do not build custom card forms.
2. Webhook endpoint (`checkout.session.completed`, `customer.subscription.updated/deleted`) that updates the user's plan in the database; verify webhook signatures; make handlers idempotent.
3. Stripe Customer Portal for self-serve cancel/upgrade — don't build billing UI.
4. Gate features by the plan column in the database (server-side checks, not client-only).
5. Test end-to-end in Stripe test mode with test cards before going live. Check context7 for current Stripe API docs — API versions change.

Implementation goes to backend-builder; keys are env vars, never in code.

## Step 4 — Landing page

biz-strategist writes the copy (headline = customer outcome, pain, 3-step how, proof, one CTA); frontend-builder ships it. Include: pricing table matching Step 2, and analytics (choose a simple one, e.g. platform analytics or a lightweight script — no heavyweight suites for v1).

## Step 5 — Launch checklist

- Payments verified live with one real transaction (refund it after).
- Legal minimums: terms + privacy pages (templates fine), refund policy stated.
- Launch channels from biz-strategist's plan, first 3 concrete actions scheduled.
- Metric to watch weekly: visitors → signups → paid conversion. One number per stage, tracked from day one.

## Report

Model + prices chosen, MVP-to-charge feature list, integration status, launch actions with dates.
