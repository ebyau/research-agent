# Experiment Plan

## Objective
Determine whether low-cost monocular traffic reconstruction can be useful for downstream AV/ADAS simulation by first identifying which reconstruction errors actually change closed-loop evaluation outcomes.

## Main Hypothesis
Planner-facing outcome drift is driven more by a compact set of interaction-critical reconstruction errors than by aggregate trajectory error, and a constrained monocular pipeline can stay within that useful regime on a meaningful subset of scenarios.

## Experiments
1. **Controlled error-budget sweep**
   - Start from high-quality trajectory scenes.
   - Inject realistic perturbations: lateral offset, temporal lag/lead, speed smoothing, conflict-zone ordering swaps, track dropout/occlusion.
   - Measure closed-loop planner outcome drift and stability of planner ranking.
2. **Metric validation**
   - Compare standard trajectory metrics (ADE/FDE, velocity error) against interaction-aware metrics (TTC profile shift, gap-acceptance timing, merge/yield order preservation, PET conflict timing).
   - Test which family better predicts downstream outcome drift.
3. **Monocular usefulness test**
   - Build/evaluate a simple constrained monocular reconstruction pipeline with tracking, calibration priors, road-plane constraints, size priors, and temporal smoothing.
   - Replay reconstructed scenes in the same simulator and compare against GT-seeded replay.
4. **Cross-stack robustness check**
   - Repeat key comparisons on two policy/planner styles or one AV planner plus one ADAS policy.
   - Check whether the error-budget ordering and usefulness claims remain directionally stable.

## Baselines
- GT-seeded simulation replay
- Naive lifted-2D heuristic reconstruction
- Standard monocular 3D tracking baseline without utility-aware constraints
- ADE/FDE-only explanatory model for downstream outcome drift

## Minimum Gain To Matter
- Interaction-aware metrics should explain downstream drift materially better than ADE/FDE-only metrics.
- Reconstructed scenes should preserve planner ranking or key safety signals on a nontrivial share of scenarios (target: >60% of curated interaction-heavy cases for early feasibility).

## Expected Failure Case
Dense occlusion, ambiguous depth ordering, and unprotected-intersection negotiation may push monocular reconstruction outside the acceptable error budget.

## Ablations
- Remove road-plane constraint
- Remove object-size prior
- Remove temporal smoothing
- Swap interaction-aware metrics for plain displacement metrics
- Evaluate with and without scenario-family stratification

## Datasets
- **Primary sensitivity/evaluation:** nuPlan and/or INTERACTION-like interaction-rich trajectories
- **Primary monocular reconstruction prototyping:** KITTI Tracking, nuScenes camera-plus-reference subsets, Argoverse-style tracked scenes
- **Optional scale-up:** Waymo Open Motion Dataset for larger interaction sensitivity analysis

## Metrics
- Planner outcome drift (collisions, off-route, hard-brake events, TTC violations, goal completion)
- Planner ranking stability across scenario sets
- ADE / FDE / velocity error / heading error
- TTC profile deviation
- Gap-acceptance timing error
- Merge / yield order preservation
- Conflict-zone occupancy timing / PET shift

## Failure Criteria
- No stable error-importance ordering across scenario families
- Interaction-aware metrics fail to outperform simple geometry metrics for predicting downstream drift
- Monocular reconstructions almost never preserve downstream conclusions on interaction-heavy scenes
- Results collapse when moving to a second planner/policy stack

## Risks / Confounds
- Stack-specific utility conclusions
- Perturbation axes may not reflect real monocular errors closely enough
- Public datasets may not align cleanly with both reconstruction and planning evaluation needs
- Simulator agent reactivity may amplify tiny geometric differences unpredictably

## Compute / Time Estimate
- Sensitivity study: modest compute, heavy on careful simulator bookkeeping
- Monocular prototype evaluation: moderate GPU/CPU depending on detector/tracker choice
- Compact first paper-feasibility cycle: roughly 6-9 weeks with one focused researcher