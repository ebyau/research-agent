# Decision: lead with hierarchy, baseline with flat/raw, gate on faithfulness

Date: 2026-03-27

## Decision
- Lead direction: Hypothesis 2 (hierarchical summaries outperform flat summaries).
- Baseline framing: keep Hypothesis 1 (summary retrieval vs raw chunks).
- Stress-test lens: use Hypothesis 3 (noise robustness) as the main practical evaluation axis.
- Deprioritize Hypothesis 4 (cited summaries) unless faithfulness becomes the core deliverable.

## Reason
This is the cleanest publishable wedge and the most reviewable controlled ablation.

## Gate
Advance only if hierarchy beats flat summaries on real data under matched budgets without worse faithfulness than the flat-summary baseline.
