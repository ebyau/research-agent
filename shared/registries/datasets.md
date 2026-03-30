# Dataset Registry

For each dataset record:
- task type
- scale
- strengths
- weaknesses
- common baselines
- evaluation traps
- fit for current project

## Entries

### nuPlan
- **Task type:** closed-loop planning benchmark
- **Strengths:** strong planner-facing metrics, reactive simulation, large driving corpus
- **Weaknesses:** not a direct monocular-video benchmark; source stack is richer than target cheap-video setting
- **Evaluation traps:** overfitting to one planner stack or scenario metric bundle
- **Fit for current project:** excellent for error-budget and usefulness evaluation

### Waymo Open Motion Dataset
- **Task type:** interaction-rich motion forecasting / joint trajectory dataset
- **Strengths:** large scale, dense interactions, strong joint metrics
- **Weaknesses:** less natural as a direct monocular reconstruction benchmark
- **Evaluation traps:** using it only for ADE/FDE-style analysis and missing planner relevance
- **Fit for current project:** very good for sensitivity studies and interaction metric design

### INTERACTION
- **Task type:** interactive trajectory dataset with semantic maps
- **Strengths:** negotiation-heavy scenarios, diverse traffic cultures, conflict-rich situations
- **Weaknesses:** not itself a monocular-video reconstruction dataset
- **Evaluation traps:** scenario heterogeneity can hide unstable conclusions
- **Fit for current project:** strong for interaction-centric analysis and kill tests

### nuScenes
- **Task type:** multimodal AV dataset with 3D annotations
- **Strengths:** public camera data plus reference 3D state, practical for prototyping
- **Weaknesses:** only moderately interaction-rich relative to dedicated interaction datasets
- **Evaluation traps:** mistaking sensor-rich source quality for cheap monocular deployability
- **Fit for current project:** good prototype benchmark for monocular-vs-reference comparison

### KITTI Tracking
- **Task type:** monocular/stereo tracking benchmark
- **Strengths:** simple and accessible starting point for constrained monocular recovery
- **Weaknesses:** limited diversity and weaker interaction richness
- **Evaluation traps:** success on KITTI may overstate usefulness in dense urban negotiation settings
- **Fit for current project:** useful smoke-test dataset, not sufficient for the full claim