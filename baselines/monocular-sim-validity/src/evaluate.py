import json
from itertools import combinations
from pathlib import Path


def near_miss_count(scene, threshold=2.0):
    count = 0
    num_steps = len(scene[0]["trajectory"])
    for t in range(num_steps):
        positions = [(a["agent_id"], a["trajectory"][t]["x"], a["trajectory"][t]["y"]) for a in scene]
        for (_, x1, y1), (_, x2, y2) in combinations(positions, 2):
            d = ((x1-x2)**2 + (y1-y2)**2) ** 0.5
            if d < threshold:
                count += 1
    return count


def summarize(gt_scene, recon_scene):
    gt_near = near_miss_count(gt_scene)
    recon_near = near_miss_count(recon_scene)
    return {
        "gt_near_miss_count": gt_near,
        "reconstructed_near_miss_count": recon_near,
        "delta_near_miss_count": recon_near - gt_near,
        "validity_note": "Small deltas suggest planner-facing utility may survive reconstruction error."
    }


def save_results(path, results):
    Path(path).write_text(json.dumps(results, indent=2))
