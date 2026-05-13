# Classify Root Causes

Determine which `cause:` labels apply to the incident. Reference the root cause definitions in [root_cause_definitions.md](root_cause_definitions.md).

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
- Read the root cause facts file directly when clarification is needed on label scope
- Quote relevant passages verbatim — do not cite by finding ID or reference only

**MUST NOT:**
- Name `root_cause_definitions.md` or any internal file path in produced output — inline quoted text directly without file attribution
