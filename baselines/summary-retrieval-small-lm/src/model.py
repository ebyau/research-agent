from __future__ import annotations

import json
import os
from dataclasses import dataclass, asdict
from typing import Dict

from .data import Example


@dataclass
class MockSummaryRetrievalModel:
    name: str
    base_accuracy: float
    flat_gain: float
    hierarchy_gain: float
    noise_penalty: float
    faithfulness_bias: float

    def score(self, example: Example, method: str) -> Dict[str, float]:
        method_bonus = {
            "raw_chunk": 0.0,
            "flat_summary": self.flat_gain,
            "hierarchical_summary": self.hierarchy_gain + 0.02 * max(example.composition_hops - 2, 0),
        }[method]

        noise_multiplier = {
            "raw_chunk": 1.00,
            "flat_summary": 0.72,
            "hierarchical_summary": 0.55,
        }[method]

        em = self.base_accuracy + method_bonus - (self.noise_penalty * noise_multiplier * example.noise_level)
        em = max(0.05, min(0.95, em))
        f1 = max(0.10, min(0.97, em + 0.08 - 0.03 * example.faithfulness_risk))
        retrieval_recall = max(0.20, min(0.99, em + 0.12))
        latency = {
            "raw_chunk": 0.85,
            "flat_summary": 0.62,
            "hierarchical_summary": 0.68,
        }[method] + 0.03 * example.composition_hops
        support = max(0.30, min(0.98, 0.88 - example.faithfulness_risk + self.faithfulness_bias - (0.01 if method == "hierarchical_summary" else 0.0)))
        return {
            "em": round(em, 3),
            "f1": round(f1, 3),
            "retrieval_recall": round(retrieval_recall, 3),
            "latency": round(latency, 3),
            "support_score": round(support, 3),
        }

    def save(self, path: str) -> None:
        os.makedirs(os.path.dirname(path), exist_ok=True)
        with open(path, "w", encoding="utf-8") as f:
            json.dump(asdict(self), f, indent=2)

    @classmethod
    def load(cls, path: str) -> "MockSummaryRetrievalModel":
        with open(path, "r", encoding="utf-8") as f:
            return cls(**json.load(f))
