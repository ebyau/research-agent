# Idea Registry

Track exploration candidates before deep work.

| Idea | Theme | Quick novelty note | Risk | Score | Status |
|------|-------|--------------------|------|-------|--------|
| Error-Budget Cartography for Simulation Validity | downstream sensitivity | Connects reconstruction error dimensions to closed-loop planner outcome drift | Can look descriptive unless error taxonomy and transfer are strong | 8.2/10 | lead |
| Utility-Calibrated Monocular Reconstruction | downstream-valid trajectory recovery | Judges monocular reconstruction by planner-facing usefulness rather than generic 3D error | Can become stack-specific | 7.6/10 | co-lead |
| Interaction-Faithful Scene Reconstruction | interaction metrics | Pushes interaction topology over object-wise accuracy | Risks collapsing into renamed geometry metrics | 7.2/10 | revise into lead |
| Counterfactual Stress Amplification from Reconstructed Seeds | scenario generation | Uses recovered real scenes as seeds for controlled stress families | Perturbations may become unrealistic | 6.8/10 | hold |
| Monocular Near-Miss Scenario Mining | long-tail scenario mining | Cheap video for rare conflict-heavy stress tests | Trustworthiness weakest on rare events | 6.4/10 | kill for now |
| Self-Calibrating Reconstruction with Minimal Map Priors | deployability | Removes heavy calibration burden | Identifiability is weak | 6.4/10 | kill for now |
| Regional Traffic Style Transfer from Cheap Video | geographic realism | Captures local behavior priors from cheap video | Style is badly confounded | 5.7/10 | kill |

## Selected thesis
Lead with a hybrid claim: derive the planner-facing error budget first, then test whether a constrained monocular pipeline falls inside it often enough to be useful.