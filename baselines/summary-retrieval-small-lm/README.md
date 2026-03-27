# Summary Retrieval Small LM

Baseline implementation for: hierarchical intermediate summaries improve long-context reasoning for small language models compared with flat summaries and raw-chunk RAG under equal token budgets.

This scaffold is intentionally compact and runnable. It uses a small synthetic evaluation set plus a deterministic mock model so the baseline pipeline can execute end-to-end even without external datasets or model downloads.

## Setup

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Data

See `data/README.md` for real dataset options and expected preprocessing flow.

The default baseline run uses an in-repo synthetic sample generator so the workflow smoke test can run without downloading HotpotQA or MuSiQue.

## Run

```bash
bash scripts/run_baseline.sh
```

Artifacts are written to `artifacts/`:
- `synthetic_dataset.json`
- `model_state.json`
- `results.json`

## Expected Results

This mock baseline is expected to show:
- raw-chunk RAG as the weakest condition under cluttered contexts
- flat-summary retrieval improving token efficiency and modestly improving EM/F1
- hierarchical summaries performing best on compositional and noisy examples
- faithfulness audit remaining close between flat and hierarchical summaries, with omission risk still present

The numbers are simulated but structured so the evaluation harness mirrors the real experiment plan from the research brief.
