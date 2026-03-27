# Literature scratch notes

Date: 2026-03-27

Target draft: shared/research-draft.md

Working references / anchors:
- Liu et al., "Lost in the Middle: How Language Models Use Long Contexts" (TACL 2024) — long-context access degrades when evidence is buried in the middle.
- "Retrieval Meets Long Context Large Language Models" (OpenReview 2023) — retrieval can still beat naive long-context stuffing.
- Microsoft, "From Local to Global: A Graph RAG Approach to Query-Focused Summarization" (GraphRAG, 2024/2025) — hierarchical community summaries help global questions.
- ReSP / "Retrieve, Summarize, Plan" (WWW 2025 companion) — iterative summarization/planning for multi-hop QA.
- "On Context Utilization in Summarization with Large Language Models" (2024) — long context alone does not guarantee effective use.
- "Lost in the Noise: How Reasoning Models Fail with Contextual Distractors" (2026) — distractors sharply hurt reasoning.
- FactCC (EMNLP 2020) — faithfulness verification for summaries.
- Cite-While-You-Generate (2026) — sentence/span-level citation improves interpretability and verification.

Likely synthesis:
- Strongest gap is not "summaries help" in general; that is already partly explored.
- More credible gap: retrieval over generated reasoning artifacts for small models, with explicit comparisons under fixed token budgets and noisy contexts.
- Hierarchical + cited summaries seem strongest as specific, testable interventions.
