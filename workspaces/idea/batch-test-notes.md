# Batch Ideation Test Notes

- Source raw idea: use small language models for long-context reasoning with retrieval and summaries.
- Coverage goal: keep the 5 candidates meaningfully diverse across summary control, retrieval planning, structured memory, training objective, and adaptive compute.
- Most promising quick follow-up: Budgeted Reasoning with Retrieval Escalation, because it offers a concrete efficiency story and a clean baseline comparison.
- Most distinctive nonstandard angle: Memory-as-Argument Graph, because it changes the memory substrate rather than just tuning prompts or retrieval.
- Main recurring risk across the batch: compression/retrieval errors can hide critical evidence before the reasoner sees it.
