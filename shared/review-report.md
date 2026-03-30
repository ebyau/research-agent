# Review Report

## Analyst Section
- **Direction assessed:** Error-budget cartography for simulation validity, with utility-calibrated monocular reconstruction as the validation vehicle.
- **Why this is the right lead:** It turns a vague systems idea into a falsifiable scientific claim. Even a negative answer is publishable if the sensitivity analysis is rigorous.
- **Key insight:** The project should not compete head-on with monocular 3D SOTA. Its leverage is showing which errors matter for planner-facing evaluation and which do not.
- **Main operational recommendation:** Start from trajectory perturbation studies before touching heavy reconstruction engineering. If the downstream sensitivity story is weak, stop early.
- **Current status:** promising, scoped, and worth a real first experiment.

## Reviewer Section
- **Verdict:** promising
- **Main strengths:**
  - Clearer than a generic “cheap video for simulation” pitch.
  - Strong motivation from the open-loop vs closed-loop evaluation gap.
  - Good opportunity to produce useful negative or boundary-setting results.
- **Main weaknesses:**
  - Novelty is partly evaluative; reviewers may ask where the technical contribution is.
  - Risk of stack-specific findings if only one simulator/planner pair is used.
  - Current draft has no executed experiments and no evidence yet that the error budget is compact or stable.
- **Missing experiments:**
  - Controlled perturbation study with realistic error axes.
  - Cross-planner robustness check.
  - Monocular-vs-GT replay comparison on interaction-heavy scenes.
- **Missing comparisons:**
  - ADE/FDE-only explanation vs interaction-aware metrics.
  - Naive lifted-2D or standard monocular baseline vs constrained pipeline.
- **What would make this more publishable:**
  - Show that interaction-aware metrics predict downstream outcome drift substantially better than conventional trajectory metrics.
  - Demonstrate at least partial transfer across planners or scenario families.
  - Keep claims narrow: useful for some classes of scenario, not a blanket replacement for high-quality trajectory data.