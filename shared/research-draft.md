# Research Draft

## Raw Idea
Abstract This proposal investigates whether low-cost monocular video can be used to reconstruct sufficiently faithful multi-agent traffic trajectories for downstream autonomous driving and ADAS stress testing. The central hypothesis is that a constrained reconstruction pipeline—combining 2D detection and tracking, ego-motion estimation, camera calibration, object-size priors, road-plane constraints, and temporal smoothing—can recover trajectories that are not perfect in absolute 3D terms but are still useful for replaying dense traffic interactions in simulation. The project is motivated by the gap between the scalability of simulation and the realism of real-world driving data, a gap that has become central in autonomous driving evaluation [1], [2], [3]. The proposed contribution is not framed as a new monocular 3D estimator. Instead, the primary research question is whether imperfect monocular reconstruction is good enough for downstream simulation-based evaluation, and which kinds of error materially change the outcome of AV or ADAS testing. The work therefore sits at the intersection of monocular 3D perception and tracking [4], [5], trajectory-rich driving datasets [1], [6], [7], and simulation-centric AV evaluation [3], [8], [9]. Problem Statement and Motivation Simulation is reproducible, scalable, and safer than real-world testing, but simulated traffic often fails to capture the interaction richness and localized behavior patterns that appear in real urban driving. Recent work argues that open-loop evaluation alone is insufficient because it does not capture compounding errors or realistic recovery behavior [3]. At the same time, collecting rich 3D trajectories with LiDAR-heavy fleets is expensive and difficult to scale across regions.

## Notes & Iteration Log
- Initialized by run_research_cycle.sh on 2026-03-27
- Mode: exploration first, exploitation second
- Compact full-cycle refresh completed on 2026-03-27
- No implementation scaffold added; this pass stays at decision/plan level

## Batch Ideation (reviewed: 2026-03-27)

This first pass widens the search space around the raw idea rather than prematurely converging on a single monocular-3D formulation. The strongest branches treat trajectory reconstruction as a *simulation utility* problem, not a pure geometry problem.

### Candidate 1 — Utility-Calibrated Monocular Reconstruction
- **Hypothesis:** A constrained monocular reconstruction pipeline optimized for preserving simulator-relevant behavioral quantities can be more useful for AV/ADAS stress testing than a pipeline optimized solely for generic 3D trajectory error.
- **Novelty note:** Reframes the target from best monocular 3D tracking to best downstream-valid reconstruction.
- **Main risk:** Utility target may overfit one simulator or planner stack.
- **Worth shallow review?** Yes.

### Candidate 2 — Error-Budget Cartography for Simulation Validity
- **Hypothesis:** Some reconstruction errors materially flip AV/ADAS evaluation outcomes while others are mostly harmless; this structure can be mapped explicitly.
- **Novelty note:** Turns fidelity into a sensitivity-analysis problem instead of a generic accuracy race.
- **Main risk:** Can look descriptive rather than algorithmic if evaluation is weak.
- **Worth shallow review?** Yes.

### Candidate 3 — Interaction-Faithful Scene Reconstruction
- **Hypothesis:** Preserving yielding order, merge timing, gap acceptance, and car-following response matters more than minimizing average displacement error.
- **Novelty note:** Centers interaction topology rather than object-wise geometry.
- **Main risk:** Interaction quality is harder to benchmark cleanly.
- **Worth shallow review?** Yes.

### Candidate 4 — Monocular Near-Miss Scenario Mining
- **Hypothesis:** Cheap video can recover enough from conflict-heavy scenes to mine rare, high-value stress tests.
- **Novelty note:** Makes long-tail scenario acquisition the story.
- **Main risk:** Rare-event noise may dominate exactly where safety claims matter most.
- **Worth shallow review?** Yes.

### Candidate 5 — Counterfactual Stress Amplification from Reconstructed Seeds
- **Hypothesis:** Reconstructed real scenes can seed realistic perturbation families for more plausible stress tests than purely synthetic generation.
- **Novelty note:** Bridges passive reconstruction and active scenario generation.
- **Main risk:** Perturbations may leave the manifold of realistic driving.
- **Worth shallow review?** Yes, secondary.

### Candidate 6 — Self-Calibrating Reconstruction with Minimal Map Priors
- **Hypothesis:** Jointly inferring scale, camera pose, and road geometry from traffic plus light priors may remove expensive calibration requirements.
- **Novelty note:** Strong deployability angle.
- **Main risk:** Underdetermined in generic scenes.
- **Worth shallow review?** Yes, enabling angle.

### Candidate 7 — Regional Traffic Style Transfer from Cheap Video
- **Hypothesis:** Imperfect reconstructions may still capture local interaction style well enough to improve geographically specific simulation realism.
- **Novelty note:** Pushes from scene recovery toward behavioral realism.
- **Main risk:** Style may be confounded by geometry, signalization, and sampling bias.
- **Worth shallow review?** Maybe.

### Early ranking
1. Utility-Calibrated Monocular Reconstruction
2. Error-Budget Cartography for Simulation Validity
3. Interaction-Faithful Scene Reconstruction
4. Monocular Near-Miss Scenario Mining
5. Counterfactual Stress Amplification from Reconstructed Seeds
6. Self-Calibrating Reconstruction with Minimal Map Priors
7. Regional Traffic Style Transfer from Cheap Video

## Hypotheses
1. **Lead framing:** Monocular reconstruction is publishably useful if it preserves *decision-critical interaction structure* well enough that downstream closed-loop AV/ADAS evaluation outcomes stay stable relative to stronger trajectory sources.
2. **Sensitivity framing:** There exists a compact error budget in which interaction timing, lateral placement near conflict zones, and gap acceptance errors dominate downstream evaluation drift more than average global trajectory error.
3. **Systems framing:** A constraint-heavy, low-cost monocular pipeline can hit the useful-fidelity regime without requiring full fleet-grade calibration or LiDAR supervision at deployment time.

## Literature Review (reviewed: 2026-03-27)

### Candidate 1 — Utility-Calibrated Monocular Reconstruction
- **Related work:**
  - **Hu et al., “Joint Monocular 3D Vehicle Detection and Tracking” (ICCV 2019):** strong baseline showing monocular video can recover 3D boxes and trajectories, but evaluates mainly tracking quality rather than simulation utility.
  - **Bartl et al., “3D Vehicle Trajectory Reconstruction in Monocular Video Data Using Environment Structure Constraints” (2018):** close in spirit on constrained reconstruction, useful for geometry assumptions and limits.
  - **Caesar et al., “nuPlan: A closed-loop ML-based planning benchmark for autonomous vehicles” (2022):** establishes why open-loop L2 metrics are insufficient for planning evaluation.
  - **Ettinger et al., “Waymo Open Motion Dataset” (ICCV 2021):** shows the value of dense interaction-rich trajectories and joint metrics for downstream driving tasks.
- **Gap(s) identified:** Existing monocular work optimizes perception/tracking metrics; existing planning benchmarks assume high-quality trajectories. The bridge question—how much reconstruction fidelity is enough for downstream simulation validity—remains weakly addressed.
- **Opportunity:** Define and test *utility-calibrated fidelity* instead of generic trajectory accuracy.

### Candidate 2 — Error-Budget Cartography for Simulation Validity
- **Related work:**
  - **nuPlan (2022):** motivates closed-loop evaluation and scenario-specific metrics.
  - **Waymo Open Motion Dataset (2021):** provides interaction-rich trajectory data and joint prediction metrics.
  - **INTERACTION Dataset (2020/2021):** highlights dense, adversarial/cooperative scenarios with semantic maps.
  - **Safety-critical scenario generation papers such as AdvSim (CVPR 2021):** show downstream failures can be sensitive to targeted perturbations.
- **Gap(s) identified:** The field lacks a clear mapping from upstream reconstruction errors to downstream planner-test outcome drift. Current work either measures trajectory error directly or perturbs scenarios adversarially without grounding the perturbation taxonomy in realistic monocular reconstruction errors.
- **Opportunity:** Produce an actionable error taxonomy with practical thresholds tied to simulator outcomes.

### Candidate 3 — Interaction-Faithful Scene Reconstruction
- **Related work:**
  - **Waymo Open Motion Dataset:** emphasizes joint interaction and metrics beyond single-agent forecasting.
  - **INTERACTION Dataset:** built specifically around highly interactive scenarios and diverse driving cultures.
  - **Monocular tracking papers:** generally preserve per-object trajectories but underemphasize negotiation structure and conflict ordering.
- **Gap(s) identified:** Interaction-faithfulness is central to simulation realism but poorly operationalized in monocular reconstruction evaluation.
- **Opportunity:** Define interaction-centric metrics such as merge order, TTC profile preservation, and gap acceptance preservation.

### Candidate 4 — Monocular Near-Miss Scenario Mining
- **Related work:**
  - **Critical scenario identification and scenario extraction work:** shows value in mining realistic rare events for testing.
  - **Scenario generation methods like AdvSim / CRISCO-style pipelines:** create stress cases but often start from richer sources than cheap roadside/ego video.
- **Gap(s) identified:** Low-cost scenario mining from monocular video is attractive, but the validation burden is especially high because rare-event errors can invalidate safety claims.
- **Opportunity:** Use as a second-stage application once fidelity thresholds are known.

### Cross-Hypothesis Synthesis
- Common theme: the real gap is not “another monocular 3D tracker,” but “how reconstruction fidelity should be judged when the end use is closed-loop evaluation.”
- Strongest gap/opportunity match: a combined **utility-calibrated + error-budget** direction.
- Recommended ordering: (1) error-budget mapping, (2) utility-calibrated evaluation, (3) interaction-faithful metrics, (4) near-miss mining as follow-on.

## Gap Map (generated: 2026-03-27)

### Utility-Calibrated Monocular Reconstruction
- **Current state:** monocular 3D tracking exists; closed-loop AV evaluation exists; they are rarely tied together rigorously.
- **What is saturated:** chasing incremental monocular box/trajectory gains on standard perception benchmarks.
- **What is missing:** downstream-validity criteria, planner-aware fidelity metrics, and evidence that imperfect reconstruction can still preserve failure-trigger structure.
- **Opportunity quality:** High.
- **Why this gap matters:** If it works, it creates a cheap path from real traffic video to realistic test scenarios.

### Error-Budget Cartography for Simulation Validity
- **Current state:** many metrics exist, but they are not organized by decision relevance.
- **What is saturated:** reporting ADE/FDE-style errors without connecting them to planning consequences.
- **What is missing:** causal sensitivity analysis over realistic perturbation axes tied to reconstruction pipelines.
- **Opportunity quality:** High.
- **Why this gap matters:** Gives the field a way to know which fidelity defects actually matter.

### Interaction-Faithful Scene Reconstruction
- **Current state:** interaction datasets exist, but reconstruction papers still optimize mostly object-centric metrics.
- **What is saturated:** generic tracking metrics.
- **What is missing:** reviewer-credible interaction-preservation metrics and benchmark protocol.
- **Opportunity quality:** Medium-high.
- **Why this gap matters:** Interaction errors are exactly what can flip safety outcomes.

### Near-Miss Scenario Mining
- **Current state:** scenario mining and synthesis exist, but monocular rare-event extraction is fragile.
- **What is saturated:** simulator-side stress generation detached from raw cheap video.
- **What is missing:** evidence that monocular reconstructions remain trustworthy in the long tail.
- **Opportunity quality:** Medium.
- **Why this gap matters:** High practical value, but only after core fidelity is validated.

### Best lead direction
A hybrid lead: **map the reconstruction error budget for closed-loop validity, then show a constraint-heavy monocular pipeline can land inside the acceptable region often enough to be practically useful.**

### Fastest dead-end to reject early
Claiming full simulation usefulness from monocular reconstructions using only average trajectory error and no planner-facing evaluation.

### What top reviewers would challenge
- Is the contribution algorithmic enough, or just an evaluation study?
- Are the downstream findings tied to one planner/simulator stack?
- Are error perturbations realistic proxies for actual monocular failure modes?
- Is monocular reconstruction good enough in dense occlusion and intersection settings?

## Skeptic Report (generated: 2026-03-27)

### Utility-Calibrated Monocular Reconstruction
- **Claim under attack:** downstream-valid utility can substitute for metric 3D accuracy.
- **Strongest objection:** utility may be stack-specific and collapse under another planner or simulator.
- **Likely failure mode:** results hold only for one policy family or one scenario class.
- **Cheapest falsification test:** compare outcome stability across two planner classes on a small set of reconstructed vs. GT-seeded scenarios.
- **Keep / Kill / Revise:** Keep, but constrain claims.

### Error-Budget Cartography for Simulation Validity
- **Claim under attack:** there is a compact, interpretable error budget.
- **Strongest objection:** interactions are too nonlinear for a neat budget; conclusions may be scenario-specific.
- **Likely failure mode:** no stable ranking of error importance across scenario families.
- **Cheapest falsification test:** perturb one clean multi-agent dataset along 4-5 axes and test whether importance ordering is stable across scenario classes.
- **Keep / Kill / Revise:** Keep.

### Interaction-Faithful Scene Reconstruction
- **Claim under attack:** interaction preservation matters more than pointwise geometry.
- **Strongest objection:** “interaction faithfulness” can become vague rhetoric.
- **Likely failure mode:** proposed metrics correlate too strongly with existing trajectory metrics to add insight.
- **Cheapest falsification test:** test whether interaction metrics explain planner outcome drift better than ADE/FDE.
- **Keep / Kill / Revise:** Revise into the lead direction rather than stand alone.

### Near-Miss Scenario Mining
- **Claim under attack:** monocular video is good enough for rare safety-critical recovery.
- **Strongest objection:** precisely the scenes that matter most are the least reliable to reconstruct.
- **Likely failure mode:** safety claims depend on mislabeled or geometrically unstable near misses.
- **Cheapest falsification test:** manual audit of a small rare-event subset with high-quality reference trajectories.
- **Keep / Kill / Revise:** Revise; do later, not as the first paper.

## Critique
- **Top surviving direction:** Error-budget cartography + utility-calibrated monocular reconstruction.
- **Why it survives:** It is sharper than “new monocular 3D,” scientifically cleaner than near-miss mining as a first paper, and easier to validate than a broad deployability story.
- **Main weakness:** novelty depends on showing planner-relevant findings, not just renaming existing metrics.
- **Quality score:** 8.1/10.
- **Decision:** Proceed.

## Research Brief (generated: 2026-03-27)

### Selected Hypothesis
Monocular reconstruction is publishably useful if it preserves decision-critical interaction structure well enough that downstream closed-loop AV/ADAS evaluation outcomes stay stable relative to stronger trajectory sources, and this useful regime can be characterized by an explicit error budget.

### Problem Statement
High-quality closed-loop driving evaluation needs realistic multi-agent trajectories, but collecting them at scale with fleet-grade sensor stacks is expensive. Cheap monocular video is abundant, yet its reconstructed 3D trajectories are noisy, partially ambiguous, and usually judged by perception metrics rather than planning consequences.

That mismatch is the opening. The useful question is not whether monocular reconstruction is metrically perfect; it is whether it is *good enough for the downstream task of simulation-based AV/ADAS stress testing*. If the answer is yes within an identifiable error budget, monocular video becomes a scalable source of realistic traffic interactions for evaluation. If the answer is no, the project still contributes a negative but actionable boundary on what cheap-video reconstruction cannot support.

### Research Questions
1. Which trajectory error dimensions most strongly change closed-loop planner evaluation outcomes?
2. Do interaction-centric errors explain downstream drift better than aggregate displacement metrics?
3. Can a constrained monocular reconstruction pipeline stay within the acceptable error budget often enough on interaction-rich scenarios to be practically useful?
4. How sensitive are the conclusions to planner class and scenario family?

### Literature Review Summary
Recent monocular 3D detection/tracking work shows that moving-camera video can recover 3D boxes and trajectories surprisingly well, especially when geometry and motion cues are coupled. But these papers are usually optimized and judged as perception systems, not as sources of downstream-valid simulation inputs.

In parallel, modern planning benchmarks such as nuPlan have made the case that open-loop trajectory metrics are inadequate for evaluating autonomous-driving behavior. Closed-loop simulation with reactive agents and scenario-specific metrics captures failure cascades that open-loop matching misses.

Interaction-rich datasets such as Waymo Open Motion Dataset and INTERACTION reinforce the core point: driving quality depends on negotiation structure, not just single-agent track accuracy. Still, the field lacks a clear bridge from imperfect reconstructed trajectories to planner-facing validity.

That gap suggests a tractable first paper: characterize the error budget that matters for closed-loop evaluation, then test whether a cheap monocular pipeline crosses that threshold often enough to matter.

### Proposed Experiments
1. **Error-axis sensitivity sweep**
   - **Method:** perturb high-quality trajectory scenes along lateral offset, longitudinal timing, velocity smoothing, conflict-zone ordering, and occlusion-dropout axes.
   - **Hypothesis tested:** RQ1, RQ2.
   - **Success metrics:** stable ranking of error importance by closed-loop outcome drift.
   - **Baseline to beat:** ADE/FDE-only explanatory power.
2. **Interaction-metric validation**
   - **Method:** compare interaction-centric metrics against planner outcome drift on perturbed scenes.
   - **Hypothesis tested:** RQ2.
   - **Success metrics:** better correlation with downstream failures than aggregate geometry metrics.
   - **Baseline to beat:** conventional displacement metrics.
3. **Monocular-pipeline usefulness test**
   - **Method:** run a constraint-heavy monocular reconstruction pipeline on scenes with reference trajectories; inject both GT and reconstructed scenes into simulation.
   - **Hypothesis tested:** RQ3.
   - **Success metrics:** bounded drift in planner ranking / safety signals on a meaningful fraction of scenarios.
   - **Baseline to beat:** naive monocular or 2D-only lifting heuristics.
4. **Cross-planner robustness check**
   - **Method:** repeat key comparisons on two planner styles or two AV/ADAS evaluation policies.
   - **Hypothesis tested:** RQ4.
   - **Success metrics:** conclusions remain directionally stable.
   - **Baseline to beat:** single-stack-only findings.

### Dataset Options
- **nuPlan** — large closed-loop planning benchmark; strong for planner evaluation; weak for cheap-video realism because source data is fleet-grade and ego-centric.
- **Waymo Open Motion Dataset** — rich interaction labels and large scale; good for sensitivity studies; weaker for direct monocular reconstruction because source monocular streams are not the public focal format.
- **INTERACTION** — strong on negotiation-heavy scenarios and semantic maps; useful for interaction metrics; not a monocular-video benchmark by itself.
- **KITTI Tracking / Argoverse / nuScenes subsets** — practical for prototyping monocular reconstruction against reference 3D trajectories; less interaction-rich than ideal planning benchmarks.

### Timeline (indicative)
1. Sensitivity study + metric design: 2-3 weeks
2. Monocular reconstruction benchmark + usefulness test: 3-4 weeks
3. Cross-planner robustness + analysis + writeup: 2 weeks

### Open questions
- Which simulator/planner pair gives enough realism without blowing up engineering scope?
- Which public dataset best supports both reference trajectories and monocular reconstruction evaluation?
- How to define “useful enough” in a reviewer-proof way: outcome stability, ranking stability, or thresholded safety metrics?

## Kill Test
- **Core kill condition:** If planner outcome drift is not meaningfully better explained by interaction-aware error measures than by plain ADE/FDE, the framing weakens hard.
- **Cheapest kill test:** On a small curated set of interaction-heavy scenarios, perturb trajectories along a few realistic axes and test whether planner ranking or safety-event rates change predictably. If no compact sensitivity pattern emerges, kill the main claim.
- **Secondary kill condition:** If realistic monocular reconstructions almost never land inside the acceptable error budget on merges/intersections, the pipeline is not useful enough as a primary paper.

## Experiment Plan Summary
The minimum convincing study is: (1) derive a planner-facing error budget from controlled perturbations of high-quality trajectory scenes, (2) validate interaction-centric metrics against downstream closed-loop outcome drift, and (3) test whether a constrained monocular pipeline falls within that budget often enough to preserve planner-facing conclusions on a nontrivial subset of scenarios.

## Baseline Results
- No code baseline run in this compact pass.
- Practical baseline recommendation: start with a simple constrained monocular tracker + road-plane prior, then compare against GT-seeded simulation and naive lifted-2D heuristics.

## Analyst Summary
This direction is worth pursuing because it has a clean falsification path and a stronger scientific shape than “let’s make monocular 3D slightly better.” The paper should lead with sensitivity and validity, not with a giant reconstruction method claim.

## Reviewer Summary
Promising but not submission-ready. The story becomes publishable only if the paper proves that planner-relevant outcome drift can be predicted by a compact, realistic error budget and that conclusions transfer beyond one planner/simulator stack.