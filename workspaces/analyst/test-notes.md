# Analyst test notes

## Files reviewed
- agents/analyst.md
- shared/research-draft.md
- shared/experiment-plan.md
- baselines/summary-retrieval-small-lm/artifacts/results.json
- baselines/summary-retrieval-small-lm/artifacts/model_state.json
- baselines/summary-retrieval-small-lm/artifacts/synthetic_dataset.json
- shared/review-report.md

## Key observations
- Pipeline outputs are coherent and aligned with the brief: raw < flat < hierarchical on EM/F1/recall.
- Noise test preserves the same ordering, which is a good smoke-test sign.
- Hierarchical F1 gain over flat: +0.088 clean, +0.095 noisy.
- Hierarchical support score is slightly worse than flat (0.625 vs 0.635), with a slightly higher omission estimate (0.375 vs 0.365).
- `model_state.json` confirms this is a scaffolded mock baseline with preset gains, so conclusions must stay modest.

## Suggested interpretation
This validates the upgraded research-agent pipeline and reporting path, not the underlying scientific claim. Next meaningful test should use a real dataset slice and real summarization/retrieval stack under matched budgets.
