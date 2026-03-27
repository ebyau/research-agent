#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

export PYTHONPATH="$ROOT_DIR:${PYTHONPATH:-}"

python3 src/train.py --config configs/baseline.yaml
python3 src/evaluate.py --config configs/baseline.yaml

echo "Baseline run completed. See artifacts/results.json"
