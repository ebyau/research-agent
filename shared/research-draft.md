# Research Draft

## Raw Idea
Use small language models for long-context reasoning with retrieval and summaries

## Notes & Iteration Log
- Initialized by run_research_cycle.sh on 2026-03-27
- Mode: exploration first, exploitation second

## Batch Ideation

1. **Hierarchical Summary Controller** — Hypothesis: a small LM can sustain long-context reasoning by iteratively compressing evidence into a rolling hierarchy of summaries that is selectively refreshed instead of re-reading the full context. *Novelty:* treats summarization as an explicit control policy rather than a static preprocessing step. *Risk:* summary drift may silently erase crucial evidence. *Shallow review:* yes.
2. **Query-Adaptive Retrieval Planner** — Hypothesis: long-context reasoning improves when a small LM first predicts what evidence types it needs, then retrieves targeted chunks and summary views rather than consuming a fixed retrieval bundle. *Novelty:* frames retrieval as a lightweight planning problem for small models. *Risk:* planner errors can starve downstream reasoning of key facts. *Shallow review:* yes.
3. **Memory-as-Argument Graph** — Hypothesis: storing retrieved facts and summary nodes as a dynamic argument graph will let a small LM reason over relationships, contradictions, and support chains more reliably than over plain text summaries. *Novelty:* replaces flat memory with structured support/attack links tailored to reasoning. *Risk:* graph construction overhead may outweigh gains on realistic budgets. *Shallow review:* yes.
4. **Failure-Aware Compression Training** — Hypothesis: training or fine-tuning small LMs on synthetic long-context tasks that explicitly reward preservation of rare but decision-critical details will reduce the usual “lost in the summary” failure mode. *Novelty:* targets compression robustness instead of raw answer accuracy. *Risk:* synthetic curricula may not transfer to real-world reasoning tasks. *Shallow review:* yes.
5. **Budgeted Reasoning with Retrieval Escalation** — Hypothesis: a cascaded system where the small LM starts with summaries, then escalates to finer-grained retrieval only when uncertainty is high can match stronger baselines at lower cost. *Novelty:* combines uncertainty-triggered retrieval with adaptive compute budgeting. *Risk:* uncertainty estimates from small LMs may be poorly calibrated. *Shallow review:* yes.

## Hypotheses

## Literature Review

## Gap Map

## Skeptic Report

## Critique

## Research Brief

## Kill Test

## Experiment Plan Summary

## Baseline Results

## Analyst Summary

## Reviewer Summary
