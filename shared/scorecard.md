# Research Scorecard

## Candidate Directions

| Rank | Direction | Novelty | Feasibility | Impact | Data | Eval Clarity | Publication Potential | Total | Decision |
|------|-----------|---------|-------------|--------|------|--------------|-----------------------|-------|----------|
| 1 | Budgeted Reasoning with Retrieval Escalation | 8.0 | 8.0 | 8.5 | 8.0 | 8.5 | 8.0 | 8.2 | Proceed |
| 2 | Query-Adaptive Retrieval Planner | 8.0 | 8.0 | 8.0 | 7.5 | 8.0 | 7.5 | 7.8 | Proceed |
| 3 | Hierarchical Summary Controller | 7.5 | 7.0 | 8.0 | 7.5 | 7.0 | 7.5 | 7.4 | Proceed |
| 4 | Failure-Aware Compression Training | 7.5 | 6.5 | 7.5 | 7.0 | 7.0 | 7.0 | 7.1 | Revise |
| 5 | Memory-as-Argument Graph | 7.5 | 5.5 | 7.0 | 6.5 | 6.5 | 7.0 | 6.7 | Revise |

## Lead Recommendations
- **Top 2 to deepen:** **Budgeted Reasoning with Retrieval Escalation** and **Query-Adaptive Retrieval Planner**. Both have strong impact stories, clean ablations, and plausible near-term baselines for small-model long-context reasoning.
- **Kill immediately:** none yet by gate; however, **Memory-as-Argument Graph** should be treated as the first cut if scope tightens because its structure-building overhead is high relative to current evidence.
- **Most likely novelty illusion:** **Hierarchical Summary Controller**. If the “controller” reduces to another summarization stack with heuristics, the contribution may collapse into pipeline tuning rather than a publishable reasoning advance.

## Mandatory Gate
- Total < 6.5 → Kill
- 6.5 to 7.2 → Revise
- > 7.2 → Proceed
- No brief unless a direction is marked Proceed.
- No baseline unless reviewer verdict is at least promising.
