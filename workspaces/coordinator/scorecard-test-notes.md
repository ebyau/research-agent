# Scorecard Test Notes

Date: 2026-03-27
Task: Test scorecard-manager upgrade by converting current ideation output into a populated scorecard.

## Inputs reviewed
- `agents/scorecard-manager.md`
- `shared/research-draft.md`
- `shared/registries/ideas.md`
- Existing `shared/scorecard.md`

## Scoring approach
Used six 1–10 dimensions requested by the scorecard manager:
- novelty
- feasibility
- impact
- data availability
- evaluation clarity
- publication potential

Computed **Total** as the arithmetic mean of the six dimensions so it matches the decision thresholds:
- < 6.5 = Kill
- 6.5 to 7.2 = Revise
- > 7.2 = Proceed

## Candidate scoring rationale

### Budgeted Reasoning with Retrieval Escalation
- Strongest overall because it has a clean systems story: adaptive compute, cost-quality tradeoff, and likely straightforward baselines.
- Main weakness: uncertainty calibration may be noisy, but that is itself testable.
- Marked as top lead.

### Query-Adaptive Retrieval Planner
- Strong and practical; the planning step is a crisp intervention and easy ablation target.
- Slight novelty risk because retrieval planning is adjacent to known tool-use / agentic retrieval ideas.
- Still a solid lead.

### Hierarchical Summary Controller
- Interesting, but summary drift is a serious failure mode and novelty could collapse into “better summarization pipeline” unless the controller is genuinely policy-driven.
- Most likely novelty illusion among the stronger candidates.

### Failure-Aware Compression Training
- Potentially useful, but weakest immediate traction because transfer from synthetic curricula is uncertain and training adds setup cost.
- Better as a follow-on if inference-time approaches fail.

### Memory-as-Argument Graph
- Structured-memory angle is appealing, but implementation overhead and noisy graph induction make it the riskiest practical bet at this stage.
- Killed for now due to complexity-to-evidence ratio.

## Recommended ranking
1. Budgeted Reasoning with Retrieval Escalation
2. Query-Adaptive Retrieval Planner
3. Hierarchical Summary Controller
4. Failure-Aware Compression Training
5. Memory-as-Argument Graph

## Notes for upgrade test
- The current upstream docs only contain shallow ideation, so this test exercises scorecard population under sparse evidence.
- Output was rewritten into a fully ranked scorecard plus concise lead recommendations, matching the manager spec.
