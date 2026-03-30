# Monocular Simulation Validity Pilot

Pilot baseline for the winning research direction:

**Error-Budget Cartography for Simulation Validity** + **Utility-Calibrated Monocular Reconstruction**

## Goal
Test whether a constrained monocular reconstruction pipeline preserves enough interaction structure to support downstream simulation validity judgments.

## Pipeline
1. ingest tracks / detections
2. estimate simplified world trajectories
3. inject controlled reconstruction error
4. compute interaction-aware metrics
5. compare planner-facing outcome sensitivity

## Run
```bash
bash scripts/run_pilot.sh
```

## Outputs
- `artifacts/synthetic_scene.json`
- `artifacts/pilot_results.json`

## Scope
This is a pilot scaffold for validating the workflow and shaping the first real experiment. It is not a full AV simulator integration.
