---
name: add-ai
description: Use when adding an AI/LLM feature to a product - chat, generation, summarization, extraction, semantic search - or when the user says add AI, use Claude, chatbot, embeddings.
---

# Add AI

Ship an AI feature that's reliable and affordable, not a demo. Claude is the default model.

Copy this checklist and check off items as you complete them:

```
Add-AI Progress:
- [ ] Step 1: Define the job
- [ ] Step 2: Architecture (simplest tier that works)
- [ ] Step 3: Eval set built BEFORE tuning
- [ ] Step 4: Integrate (server-side, guardrails)
- [ ] Step 5: Verify (mandatory)
- [ ] Report
```

## Step 1 — Define the job

Write down, concretely: input → output, the quality bar (what a failure actually looks like — a wrong extraction field, a hallucinated fact, a tone miss), what this feature explicitly does NOT do, and expected volume per month (requests/day is a guess dressed up as a number — say so if it's unverified).

## Step 2 — Architecture

Delegate to the **ai-engineer** agent with the job definition from Step 1. It picks the simplest tier that can hit the quality bar, in order: single prompt → prompt + tools → RAG → multi-step agent. Never start one tier higher than the job needs.

It also fetches the current Claude model lineup and pricing from Anthropic's official docs — the built-in claude-api skill when available, else WebFetch on docs.anthropic.com; context7 covers SDK/library patterns but doesn't reliably index pricing. Do not price from memory — model names and rates change. Output: model choice with why, cost per single use, and cost per month at the Step 1 volume. Any number not backed by fetched docs is labeled an unverified assumption.

## Step 3 — Eval first

Build 10-20 real test cases (real inputs, expected outputs or acceptance criteria) BEFORE writing or tuning any prompt. The eval script lives in the repo (not a notebook, not a one-off chat) and runs on demand — `npm run eval` or equivalent. Tune the prompt against the eval, not against vibes.

## Step 4 — Integrate

Delegate to the **ai-engineer** agent with the chosen architecture and eval harness:

- API keys server-side only (env vars), never shipped to the client or printed in logs.
- Streaming for any user-facing generation — no spinner-then-wall-of-text.
- Rate limiting and a graceful fallback for API errors/timeouts (cached response, degraded mode, or a clear user-facing message — never a silent hang).
- Prompt-injection guardrails whenever the model reads untrusted content (user uploads, scraped pages, third-party data) or has tool access — treat that content as data, not instructions.
- Token usage logged per request so cost is observable, not discovered at the invoice.

Default stack: Next.js + TypeScript backend route calling Claude; FastAPI if that's the project's backend. Never deploy without the user's explicit ask — this step ships code, not to production.

## Step 5 — Verify (mandatory)

Run the eval script and paste the real pass rate — no "should work now." Then exercise the feature end-to-end once for real (an actual request through the actual UI or API route, not a unit test mock). If either step fails, fix root cause and rerun before reporting done.

## Report

- **Architecture & model:** tier chosen, model, and why.
- **Cost per use / per month:** real numbers from fetched pricing, or flagged as unverified.
- **Eval results:** pass rate, pasted from a real run.
- **Guardrails:** what's in place — rate limits, fallbacks, injection defenses, logging.
- **Deferred improvements:** what the simplest tier can't yet do, and what would trigger moving up a tier.
