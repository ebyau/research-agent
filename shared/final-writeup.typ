= Monocular Traffic Reconstruction for Simulation Utility: Toward an Error-Budget View of Downstream Validity

== Abstract
This proposal investigates whether low-cost monocular video can support downstream autonomous driving (AV) and advanced driver-assistance system (ADAS) simulation by recovering traffic trajectories that are not perfectly accurate in 3D, but sufficiently faithful for evaluation and stress testing. The central thesis is that the key scientific question is not whether monocular reconstruction can match high-fidelity sensing in absolute geometric terms, but whether it can preserve the aspects of multi-agent interaction that materially influence downstream simulation outcomes. We therefore frame the problem as one of *simulation-validity error budgeting*: identifying which trajectory errors alter planner-relevant conclusions, and whether a constrained monocular reconstruction pipeline can remain within acceptable bounds often enough to be practically useful.

An initial perturbation study on a 100-scenario subset of the Argoverse 2 motion-forecasting dataset provides early support for this framing. As perturbation strength increases, planner-facing interaction proxies such as near-miss count, conflict count, and time-to-collision risk change measurably, indicating that trajectory fidelity errors can indeed alter downstream behavioral structure. These results do not yet constitute planner-in-the-loop validation, but they justify a focused research program centered on error sensitivity, interaction preservation, and utility-aware reconstruction rather than generic monocular 3D accuracy.

== Introduction
Simulation is now central to AV and ADAS development because it offers scalability, reproducibility, and safety that real-world testing alone cannot match. However, simulation quality depends critically on the realism of the underlying traffic trajectories and interactions used to seed or evaluate it. In practice, high-fidelity trajectory collection often relies on LiDAR-equipped fleets or expensive multi-sensor platforms, which limits scalability across geographies and operating conditions.

Monocular video presents an appealing alternative. It is cheap, widespread, and already available in many traffic and vehicle-facing contexts. Yet monocular reconstruction is inherently noisy and often underconstrained. Existing monocular trajectory recovery methods are typically evaluated as perception systems, using geometric fidelity metrics such as positional error or 3D tracking accuracy. For downstream AV/ADAS simulation, however, geometric fidelity alone may be insufficient. A trajectory estimate may be imperfect in 3D while still preserving the key interaction patterns that determine planner behavior. Conversely, a trajectory estimate with modest average geometric error may still distort conflict timing, gap acceptance, or near-miss structure enough to invalidate simulation conclusions.

This observation motivates a shift in framing. Rather than asking whether monocular reconstruction is accurate, we ask whether it is useful enough for downstream simulation-based evaluation. Concretely, the proposed research seeks to characterize the error budget for simulation validity: which forms of trajectory error materially change downstream planner-relevant outcomes, which forms are tolerable, and whether a constrained monocular pipeline can stay within the useful regime for a meaningful class of scenes.

== Problem Statement
The problem addressed in this proposal is the following:

Can low-cost monocular video be used to reconstruct sufficiently faithful multi-agent traffic trajectories for downstream AV/ADAS simulation and stress testing, and what trajectory error levels remain acceptable before simulation conclusions become unreliable?

This problem has two coupled components. First, there is the sensitivity problem: not all reconstruction errors matter equally. Some deviations may have little downstream consequence, while others may materially alter interaction structure, conflict timing, or planner ranking. Before investing heavily in monocular reconstruction engineering, one must understand which error dimensions matter.

Second, there is the utility problem: even if monocular reconstruction is noisy, it may still be useful if it preserves the interaction structure relevant to downstream simulation. The research contribution is therefore not best framed as a new monocular 3D estimator, but rather as a utility-aware characterization of when imperfect reconstruction remains valid for simulation use.

== Research Questions
- Which trajectory error dimensions most strongly perturb downstream planner-relevant interaction structure?
- Do interaction-aware metrics explain simulation-validity drift better than conventional geometric metrics such as ADE/FDE-style trajectory error?
- Can a constrained monocular reconstruction pipeline remain within the acceptable error budget on a meaningful subset of dense traffic scenes?
- How stable are these findings across scenario families and, eventually, across different planner or policy stacks?

== Proposed Framing and Hypothesis
The project hypothesis is that a constrained monocular reconstruction pipeline—combining 2D detection and tracking, calibration and ego-motion estimates, road-plane assumptions, object-size priors, and temporal smoothing—may not recover perfect 3D trajectories, but can nevertheless preserve enough interaction structure to remain useful for simulation-driven AV/ADAS evaluation in some settings.

The strongest framing emerging from the current work is a hybrid of two linked ideas:
- *Error-Budget Cartography for Simulation Validity*: map which trajectory errors actually change downstream simulation-relevant outcomes.
- *Utility-Calibrated Monocular Reconstruction*: evaluate whether a constrained monocular pipeline falls within those tolerable error bounds often enough to matter in practice.

== Initial Empirical Signal
To test whether this framing is viable, an initial perturbation study was conducted on a 100-scenario subset of the Argoverse 2 motion-forecasting dataset. Rather than running a full planner-in-the-loop evaluation at this stage, the study used planner-facing interaction proxies derived from multi-agent trajectory structure.

=== Experimental Setup
A subset of 100 validation scenarios was selected. Synthetic perturbations were injected at three levels: mild, medium, and severe. The perturbations altered position, velocity, and track continuity to simulate degraded reconstruction quality.

=== Metrics
The pilot measured:
- near-miss count
- TTC-risk count
- conflict count (pairwise distance under 5 m)
- minimum observed pairwise distance
- active pair count (pairwise distance under 20 m)

=== Results
Baseline interaction structure across the 100 scenarios was:
- near-miss count: 1101
- TTC-risk count: 44945
- conflict count: 25124

Under perturbation:
- mild perturbation: near-miss 1225 (+124), TTC-risk 44611 (-334), conflict 25312 (+188)
- medium perturbation: near-miss 1902 (+801), TTC-risk 42910 (-2035), conflict 25994 (+870)
- severe perturbation: near-miss 3050 (+1949), TTC-risk 40087 (-4858), conflict 25450 (+326)

=== Interpretation
These results provide an initial empirical signal that perturbation strength materially changes planner-facing interaction structure. In particular, near-miss inflation grows sharply with stronger perturbation, TTC-risk structure degrades as noise increases, and conflict statistics shift measurably under medium and severe perturbations. This is not yet evidence of full simulation validity failure, but it is enough to justify the next stage of research: systematically mapping which trajectory errors distort downstream conclusions and by how much.

== Proposed Methodology
The project should proceed in stages.

=== Stage 1: Error-Budget Characterization
Using high-quality trajectory data, inject controlled perturbations along interpretable axes such as position noise, velocity noise, temporal lag, track fragmentation, missed detections, and ordering disruption in conflict regions. Measure how these changes alter planner-facing interaction proxies and, later, planner outcomes directly. The goal is to construct an empirical error budget separating tolerable errors from simulation-invalidating errors.

=== Stage 2: Metric Study
Compare conventional geometric trajectory metrics against interaction-aware metrics in terms of their ability to predict downstream drift. The working hypothesis is that interaction-aware measures—such as TTC-profile shifts, conflict timing distortion, ordering preservation, and gap-acceptance changes—will be more informative than average geometric error alone.

=== Stage 3: Monocular Reconstruction Evaluation
Only after the error budget is established should the monocular pipeline be evaluated. The pipeline need not be state of the art. A constrained baseline is sufficient if it can test whether cheap monocular reconstruction enters the useful-fidelity regime.

=== Stage 4: Planner-Facing Validation
The final stage should test whether the conclusions survive under at least one planner stack, and ideally more than one, to avoid overfitting the findings to a single evaluation setup.

== Expected Contributions
If successful, the project would contribute:
- a planner-facing error budget for reconstructed traffic trajectories
- evidence that interaction-aware metrics are better suited than purely geometric metrics for judging simulation usefulness
- a practical assessment of when monocular reconstruction is useful enough for downstream AV/ADAS stress testing
- a low-cost pathway from real traffic video to simulation seeding

== Risks and Limitations
- The current empirical results are based on perturbation proxies, not full planner-in-the-loop simulation.
- Interaction proxy metrics may not perfectly predict downstream planner behavior.
- Real monocular failure modes may differ from synthetic perturbations.
- Findings may become stack-specific if only one planner or simulator is used.
- Public datasets may not align cleanly with both trajectory sensitivity analysis and monocular benchmarking.

== Recommended Project Direction
Based on the initial ideation, ranking, and first perturbation study, the strongest research direction is the combination of *Error-Budget Cartography for Simulation Validity* and *Utility-Calibrated Monocular Reconstruction*. This framing keeps the project focused on the scientifically strongest question: not whether monocular reconstruction is perfect, but whether it is sufficient for preserving simulation-relevant interaction structure.

== Next Steps
- Extend the perturbation study with stronger interaction metrics such as PET and ordering preservation.
- Add a planner-in-the-loop or stronger planner proxy.
- Compare interaction-aware metrics against conventional geometry metrics.
- Introduce one constrained monocular reconstruction baseline.
- Keep the scope narrow around utility and error budgeting, not universal monocular scene recovery.
