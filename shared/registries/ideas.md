# Idea Registry

Track exploration candidates before deep work.

| Idea | Theme | Quick novelty note | Risk | Score | Status |
|------|-------|--------------------|------|-------|--------|
| Hierarchical Summary Controller | summary policy / memory compression | Makes summarization an adaptive control loop instead of a one-shot preprocessing step | Summary drift can remove crucial evidence | 8/10 | shallow-review |
| Query-Adaptive Retrieval Planner | retrieval planning | Predicts evidence needs before fetching context, giving small LMs a lighter search problem | Retrieval planner can miss key evidence | 8/10 | shallow-review |
| Memory-as-Argument Graph | structured reasoning memory | Stores claims with support/attack structure rather than flat notes or chunks | Graph construction may be too expensive or noisy | 7/10 | shallow-review |
| Failure-Aware Compression Training | robustness / training objective | Optimizes for preserving rare decision-critical details during compression | Synthetic training tasks may transfer poorly | 7/10 | shallow-review |
| Budgeted Reasoning with Retrieval Escalation | efficiency / adaptive compute | Escalates from summaries to raw evidence only when model uncertainty is high | Small-model uncertainty may be miscalibrated | 9/10 | prioritize |
