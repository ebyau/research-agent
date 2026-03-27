# Memory manager test notes

Date: 2026-03-27

Inputs reviewed:
- agents/memory-manager.md
- shared/research-draft.md
- shared/experiment-plan.md
- shared/review-report.md

## Extraction summary
- Lead direction: hierarchical intermediate summaries for small-LM long-context reasoning.
- Core comparison: raw chunks vs flat summaries vs hierarchical summaries under matched token budgets.
- Primary evaluation lens: noisy-context robustness.
- Main confound to track: summary faithfulness / omission.
- Current evidence is only a synthetic 6-example smoke test with mock gains; useful for pipeline validation, not publishable evidence.
- Real next gate: reproduce hierarchy > flat on a real HotpotQA or MuSiQue slice with fixed summarizer/retriever/budget.

## Planned durable memory writes
- ideas: one note on hierarchy as the main research wedge.
- papers: key notes on Lost in the Middle, GraphRAG, and Cite-While-You-Generate/faithfulness-citation line.
- failures: preserve the reason cited summaries are currently deprioritized; also preserve that synthetic smoke-test gains are not scientific evidence.
- datasets: note HotpotQA and MuSiQue roles/limitations.
- decisions: lead with H2, keep H1 baseline framing, use H3 as stress test, gate promotion on faithfulness.
- open-questions: minimal hierarchy template, summary generation mode, scalable faithfulness check.
