# Baseline smoke-test notes

- Read baseline agent spec and shared research draft.
- Selected project name: `summary-retrieval-small-lm`.
- Implemented a runnable mock baseline rather than a full model download to keep the skill smoke test fast and dependency-light.
- Scaffold mirrors the brief experiments: raw chunk baseline, flat summaries, hierarchical summaries, noisy stress test, faithfulness audit.
- Evaluation writes `artifacts/results.json` with metrics, comparisons, and pass/fail flags.
- Data path is synthetic by default; README documents how to swap in HotpotQA / MuSiQue / 2WikiMultihopQA later.
