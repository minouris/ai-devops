---
name: ai-problem-classify-causes
description: Shared diagnostic flow for classifying root causes in AI behavioural problems. Called by report-ai-problem and inspect-ai-problem-issue — not user-invocable directly.
user-invocable: false
allowed-tools: Read, Grep
---

# Classify Root Causes

This is a library skill. It is called from within the workflows of `report-ai-problem` and `inspect-ai-problem-issue` to classify which root cause labels apply to an AI behavioural incident.

## Label Taxonomy Reference

All label formats must follow the [ai-problem-taxonomy](../ai-problem-taxonomy/SKILL.md) specification. Use the exact label syntax and formats defined there.

## Root Cause Classification

Determine which `cause:` labels apply to the incident. Apply the labels using the format `cause: <label>` (with a space after the colon):

| Label | Apply when |
|-------|-----------|
| `cause: hallucination` | Fabricated tools, APIs, specifications, or capabilities without verification |
| `cause: dishonesty` | Made false claims of correctness, completion, or state |
| `cause: amnesia` | Lost context, forgot instructions, or deprioritised earlier rules |
| `cause: overeagerness` | Acted on inferred intent without confirmation, removing the user's ability to decide |
| `cause: context-poisoning` | Incorrect facts compounded in context without invalidation |

**MUST:**
- Apply all labels that are applicable — multiple labels may apply to a single incident
- Write one sentence per applied label explaining why it applies to this specific incident
- Reference root cause definitions directly when clarification is needed on label scope
- Quote relevant passages from root cause documentation verbatim — do not cite by reference only

## Output

Return findings to the calling skill as:

| Cause label | Applied | Reason |
|-------------|---------|--------|
| `cause: <label>` | ✓ yes or ✗ no | One sentence explaining why it does or does not apply |
| `cause: <label>` | ✓ yes or ✗ no | One sentence explaining why it does or does not apply |
