# Traffic datasets for monocular-simulation research

- **nuPlan:** best for planner-facing evaluation, weak as a cheap-video benchmark.
- **Waymo Open Motion Dataset:** best for large-scale interaction sensitivity, not ideal for direct monocular evaluation.
- **INTERACTION:** best for conflict-heavy interaction analysis and metric design.
- **nuScenes / KITTI / Argoverse-like subsets:** best for prototype monocular-vs-reference comparisons.

## Durable lesson
The project likely needs a two-dataset strategy: one family for planner sensitivity, another for monocular reconstruction benchmarking.