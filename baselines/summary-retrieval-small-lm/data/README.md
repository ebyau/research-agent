# Data Notes

This baseline intentionally ships without raw datasets.

## Recommended real datasets
- HotpotQA for standard multi-hop QA with supporting facts
- MuSiQue for stronger compositional reasoning control
- 2WikiMultihopQA for scale and diverse relations

## Expected preprocessing flow
1. Download the chosen dataset into a local cache outside git.
2. Convert each example into:
   - source documents / passages
   - gold answer
   - supporting evidence spans
   - noise metadata for distractor injection
3. Build three retrieval views:
   - raw chunks
   - flat summaries
   - hierarchical summaries (entity/event notes -> local conclusions -> global synthesis)
4. Save normalized JSONL files and retrieval indices under `artifacts/` or an external data directory.

## Smoke-test behavior
If no dataset is supplied, the scaffold falls back to a tiny synthetic set so training and evaluation can still run end-to-end.
