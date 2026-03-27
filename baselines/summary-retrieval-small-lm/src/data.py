from __future__ import annotations

import json
import os
from dataclasses import dataclass, asdict
from typing import List


@dataclass
class Example:
    example_id: str
    question: str
    answer: str
    noise_level: float
    composition_hops: int
    faithfulness_risk: float


def build_synthetic_dataset() -> List[Example]:
    return [
        Example("ex1", "Which city hosted the inventor's university?", "edinburgh", 0.1, 2, 0.15),
        Example("ex2", "What river connects the birthplace and treaty location?", "danube", 0.2, 3, 0.20),
        Example("ex3", "Which scientist mentored the author of the cited report?", "curie", 0.5, 2, 0.35),
        Example("ex4", "Which country governed both events described across the two reports?", "france", 0.6, 3, 0.30),
        Example("ex5", "What organization funded the final mission in the combined timeline?", "esa", 0.8, 4, 0.40),
        Example("ex6", "Which material appears in both the prototype and archival note?", "graphene", 0.7, 2, 0.25),
    ]


def save_dataset(examples: List[Example], path: str) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump([asdict(ex) for ex in examples], f, indent=2)


def load_dataset(path: str | None = None) -> List[Example]:
    if path and os.path.exists(path):
        with open(path, "r", encoding="utf-8") as f:
            raw = json.load(f)
        return [Example(**item) for item in raw]
    return build_synthetic_dataset()
