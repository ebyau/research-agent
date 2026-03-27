from __future__ import annotations

import argparse
import json
import os
from statistics import mean
from typing import Dict, List

import yaml

from src.data import Example, load_dataset
from src.model import MockSummaryRetrievalModel


METHODS = ["raw_chunk", "flat_summary", "hierarchical_summary"]


def aggregate(examples: List[Example], model: MockSummaryRetrievalModel, method: str) -> Dict[str, float]:
    scores = [model.score(ex, method) for ex in examples]
    return {
        "em": round(mean(s["em"] for s in scores), 3),
        "f1": round(mean(s["f1"] for s in scores), 3),
        "retrieval_recall": round(mean(s["retrieval_recall"] for s in scores), 3),
        "latency": round(mean(s["latency"] for s in scores), 3),
        "support_score": round(mean(s["support_score"] for s in scores), 3),
    }


def main() -> None:
    parser = argparse.ArgumentParser(description="Evaluate mock baseline experiments")
    parser.add_argument("--config", default="configs/baseline.yaml")
    args = parser.parse_args()

    with open(args.config, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    artifacts_dir = config["paths"]["artifacts_dir"]
    dataset_path = os.path.join(artifacts_dir, "synthetic_dataset.json")
    model_path = os.path.join(artifacts_dir, "model_state.json")
    results_path = os.path.join(artifacts_dir, "results.json")

    examples = load_dataset(dataset_path)
    model = MockSummaryRetrievalModel.load(model_path)

    experiment_map = {
        "Raw Chunk RAG Baseline": "raw_chunk",
        "Flat Intermediate Summary Retrieval": "flat_summary",
        "Hierarchical Summary Retrieval": "hierarchical_summary",
    }

    experiments: Dict[str, Dict[str, object]] = {}
    aggregate_scores = {method: aggregate(examples, model, method) for method in METHODS}

    for experiment_name, method in experiment_map.items():
        metrics = aggregate_scores[method]
        baseline_name = "Standard chunk retrieval" if method == "raw_chunk" else ("Raw Chunk RAG Baseline" if method == "flat_summary" else "Flat Intermediate Summary Retrieval")
        baseline_metrics = aggregate_scores["raw_chunk" if method == "flat_summary" else ("flat_summary" if method == "hierarchical_summary" else "raw_chunk")]
        experiments[experiment_name] = {
            "method": method,
            "metrics": metrics,
            "baseline_to_beat": baseline_name,
            "comparison": {
                "delta_em": round(metrics["em"] - baseline_metrics["em"], 3),
                "delta_f1": round(metrics["f1"] - baseline_metrics["f1"], 3),
                "delta_latency": round(metrics["latency"] - baseline_metrics["latency"], 3),
            },
            "success_criteria": {
                "pass_em": metrics["em"] >= config["thresholds"]["min_em"],
                "pass_f1": metrics["f1"] >= config["thresholds"]["min_f1"],
                "pass_recall": metrics["retrieval_recall"] >= config["thresholds"]["min_retrieval_recall"],
            },
        }

    noisy_examples = [ex for ex in examples if ex.noise_level >= 0.5]
    stress_test = {
        method: aggregate(noisy_examples, model, method) for method in METHODS
    }

    faithfulness_audit = {
        method: {
            "support_score": aggregate_scores[method]["support_score"],
            "estimated_omission_rate": round(1.0 - aggregate_scores[method]["support_score"], 3),
        }
        for method in ["flat_summary", "hierarchical_summary"]
    }

    results = {
        "project": config["project_name"],
        "status": "mock_baseline_complete",
        "dataset": {
            "name": config["data"]["dataset_name"],
            "num_examples": len(examples),
            "mode": "synthetic_smoke_test",
        },
        "experiments": experiments,
        "noisy_context_stress_test": stress_test,
        "faithfulness_audit": faithfulness_audit,
        "overall_success": {
            "hierarchical_beats_flat_f1": aggregate_scores["hierarchical_summary"]["f1"] > aggregate_scores["flat_summary"]["f1"],
            "flat_beats_raw_f1": aggregate_scores["flat_summary"]["f1"] > aggregate_scores["raw_chunk"]["f1"],
            "hierarchical_more_robust_under_noise": stress_test["hierarchical_summary"]["f1"] >= stress_test["flat_summary"]["f1"],
        },
    }

    os.makedirs(artifacts_dir, exist_ok=True)
    with open(results_path, "w", encoding="utf-8") as f:
        json.dump(results, f, indent=2)

    print(json.dumps(results["overall_success"], indent=2))
    print(f"Saved results to {results_path}")


if __name__ == "__main__":
    main()
