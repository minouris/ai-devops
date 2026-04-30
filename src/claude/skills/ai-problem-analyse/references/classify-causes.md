# Classify Root Causes

Determine which `cause:` labels apply to the incident.

**IMPORTANT:** All label formats must follow the [ai-problem-taxonomy](../../ai-problem-taxonomy/SKILL.md) specification. Use the exact label syntax and formats defined there.

Reference the root cause definitions in [root_cause_definitions.md](root_cause_definitions.md) for detailed explanation of each cause.

## Root Cause Classification

Apply the `cause:` labels identified below using the format `cause: <label>` (with a space after the colon):

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
- Quote relevant passages from the root cause facts file verbatim — do not cite by finding ID or reference only
