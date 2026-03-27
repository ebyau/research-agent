from __future__ import annotations

import argparse
import os

import yaml

from src.data import load_dataset, save_dataset
from src.model import MockSummaryRetrievalModel


DEFAULT_MODEL = MockSummaryRetrievalModel(
    name="mock-small-lm-summary-retriever",
    base_accuracy=0.46,
    flat_gain=0.08,
    hierarchy_gain=0.14,
    noise_penalty=0.18,
    faithfulness_bias=0.03,
)


def main() -> None:
    parser = argparse.ArgumentParser(description="Train mock baseline model")
    parser.add_argument("--config", default="configs/baseline.yaml")
    args = parser.parse_args()

    with open(args.config, "r", encoding="utf-8") as f:
        config = yaml.safe_load(f)

    artifacts_dir = config["paths"]["artifacts_dir"]
    dataset_path = os.path.join(artifacts_dir, "synthetic_dataset.json")
    model_path = os.path.join(artifacts_dir, "model_state.json")

    examples = load_dataset()
    save_dataset(examples, dataset_path)
    DEFAULT_MODEL.save(model_path)

    print(f"Saved {len(examples)} synthetic examples to {dataset_path}")
    print(f"Saved mock model state to {model_path}")


if __name__ == "__main__":
    main()
