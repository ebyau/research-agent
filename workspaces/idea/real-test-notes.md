# Real Test Notes — Batch Ideation

Date: 2026-03-27
Task: First-pass batch ideation for monocular-video traffic reconstruction for downstream AV/ADAS stress testing.

## Core framing extracted from raw idea
- Input modality: low-cost monocular roadside / dashcam-like video.
- Target output: sufficiently faithful multi-agent trajectories, not necessarily metrically perfect 3D.
- End use: replay dense traffic interactions in simulation for AV / ADAS evaluation.
- Key thesis: downstream utility may be robust to some reconstruction error classes and highly sensitive to others.

## Important axes to diversify across
1. Utility-first vs geometry-first objective.
2. Explicit physics / road-plane constraints vs learned latent trajectory completion.
3. Scenario extraction fidelity vs evaluator sensitivity mapping.
4. Passive reconstruction only vs counterfactual stress-test augmentation.
5. Absolute trajectory accuracy vs interaction topology preservation.
6. Full-scene benchmark construction vs targeted near-miss / safety-critical slice.

## Promising candidate shapes
- Utility-calibrated reconstruction: optimize for simulator-relevant fidelity, not generic 3D error.
- Error sensitivity cartography: which monocular errors actually matter for AV stack outcomes?
- Interaction graph reconstruction: preserve yielding / cut-in / following structure.
- Near-miss mining from cheap video: safety-critical scenario reconstruction from monocular footage.
- Counterfactual stress generation from reconstructed seeds: bridge real data and scalable simulation.
- Self-calibrating cross-camera or map-lite constraints: reduce infrastructure burden.
- Domain transfer / locality study: can low-cost regional footage produce locally realistic traffic priors?

## Likely evaluation ingredients
- Trajectory metrics: ADE/FDE, speed/heading error, TTC/PET error, lane assignment consistency.
- Interaction metrics: gap acceptance, ordering at merges, conflict-zone occupancy, cut-in timing.
- Downstream metrics: AV planner collision rate, hard braking, policy disengagements, safety envelope violations.
- Simulator usefulness: ranking consistency of system variants under reconstructed vs ground-truth scenarios.

## Biggest cross-cutting risks
- Hard to get paired ground-truth 3D + monocular video at useful scale.
- Simulator-policy results may be too stack-specific.
- Reconstruction may look plausible but break causal interaction structure.
- Novelty risk if framed as “just another monocular 3D tracking paper”.

## Best first-pass directions
Top tier for shallow review:
1. Utility-Calibrated Monocular Reconstruction
2. Error-Budget Cartography for Simulation Validity
3. Interaction-Faithful Scene Reconstruction
4. Monocular Near-Miss Scenario Mining

Lower-priority but still useful:
5. Counterfactual Stress Amplification from Reconstructed Seeds
6. Self-Calibration with Minimal Map Priors
7. Regional Traffic Style Transfer from Cheap Video
