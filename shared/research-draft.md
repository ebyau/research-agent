# Research Draft

## Raw Idea
Test batch triage for small-model long-context reasoning ideas

## Notes & Iteration Log
- Initialized by run_research_cycle.sh on 2026-03-27
- Mode: exploration first, exploitation second

## Hypotheses

## Literature Review

## Gap Map

## Skeptic Report

## Critique

## Research Brief

## Kill Test

## Kill Test (generated: 2026-03-27)
- **Core claim to test:** Hierarchical intermediate summaries give small language models a real reasoning advantage over flat summaries for multi-hop / long-context QA, not just a generic compression or denoising benefit.
- **Cheapest falsification test:** Run a 30-50 example pilot on one real dataset slice (prefer HotpotQA or MuSiQue) with the same small model, summarizer, retriever, and token budget for both conditions. Compare **flat-summary retrieval vs hierarchical-summary retrieval** first; add raw-chunk retrieval only if it is nearly free. Measure answer quality (EM/F1 or exact task metric) and do a small evidence-faithfulness spot check.
- **What result would kill the idea:** If hierarchy fails to beat flat summaries by a clear margin on the pilot (roughly no consistent win or only trivial gain under matched budgets), or if any gain disappears once faithfulness/evidence support is checked, treat the direction as not worth a full baseline yet.
- **What result would justify proceeding:** If hierarchy shows a clear, repeatable pilot win over flat summaries under equal budgets without worse faithfulness, proceed to the full baseline and noisy-context stress test.
- **Expected runtime / cost:** Low. A single pilot should take hours, not days, and modest API/compute cost.

## Experiment Plan Summary

## Baseline Results

## Analyst Summary

## Reviewer Summary
