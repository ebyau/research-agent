# Monocular reconstruction for simulation utility

## Durable takeaway
Do not pitch this as “better monocular 3D.” The strongest framing is: map the planner-facing error budget first, then test whether cheap monocular reconstruction stays inside it often enough to be useful.

## Why it matters
This creates a falsifiable bridge between perception quality and closed-loop evaluation realism.

## Revisit conditions
Proceed if interaction-aware metrics clearly predict downstream drift better than ADE/FDE and if usefulness is not confined to one planner stack.