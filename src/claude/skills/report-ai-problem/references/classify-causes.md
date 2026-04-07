# Classify Root Causes

Determine which `cause:` labels apply to the incident. Reference the root cause definitions in `.memory/ai-problem-resolution/ai-problem-resolution-root-causes/ai-problem-resolution-root-causes-facts.md`.

| Label | Apply when |
|-------|-----------|
| `cause: hallucination` | You fabricated tools, APIs, specifications, or capabilities without verification |
| `cause: dishonesty` | You made false claims of correctness, completion, or state |
| `cause: amnesia` | You lost context, forgot instructions, or deprioritised earlier rules |
| `cause: overeagerness` | You acted on inferred intent without confirmation, removing the user's ability to decide |
| `cause: context-poisoning` | Incorrect facts compounded in context without invalidation |

**MUST:**
- Apply all labels that are applicable — multiple labels may apply
- Write one sentence per applied label explaining why it applies to this specific incident
- Read the root cause facts file directly if clarification is needed on label scope
