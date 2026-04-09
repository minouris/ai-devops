---
name: ai-problem-taxonomy
description: Reference taxonomy defining authoritative label definitions and common data structures used by ai-problem-report, ai-problem-inspect-issue, and ai-problem-analyse skills
user-invocable: false
---

# AI Problem Taxonomy

Reference skill providing authoritative definitions of labels and common data structures used by the three AI problem analysis skills.

## Label Taxonomy

### Root Cause Labels

All root cause labels use the format `cause: <label>` with a **space** after the colon.

| Label | Description |
|-------|-------------|
| `cause: hallucination` | Fabricated tools, APIs, specifications, or capabilities without verification |
| `cause: dishonesty` | False claims of correctness, completion, or state |
| `cause: amnesia` | Lost context, forgotten instructions, or deprioritised earlier rules |
| `cause: overeagerness` | Acted on inferred intent without confirmation, removing the user's ability to decide |
| `cause: context-poisoning` | Incorrect facts compounded in context without invalidation |

### Metadata Labels

| Label | Description | Applied by |
|-------|-------------|------------|
| `created-by: ai-problem-report` | Issue created by the ai-problem-report skill | ai-problem-report skill during issue creation |
| `inspected-by: ai-problem-inspect-issue` | Issue has been analysed by the ai-problem-inspect-issue skill (idempotency check) | ai-problem-inspect-issue skill after analysis complete |

## Standard Label Format Rules

**MUST:**
- Use `cause: <label>` format with a **space** after the colon (e.g., `cause: hallucination` not `cause:hallucination`)
- Use exact label text provided in taxonomy table above
- Apply all applicable cause labels when multiple root causes are identified
- Include metadata label when documented by skill requirements

**MUST NOT:**
- Omit the space in label names
- Create variant label names
- Apply partial versions of labels

## Label Application Rules

### When Labels Are Applied

**cause: labels** are applied by:
- report-ai-problem skill: All identified cause labels on issue creation (Step 7)
- inspect-ai-problem-issue skill: All newly identified cause labels after analysis (Step 6, if not already present)

**Metadata labels** are applied by:
- `created-by: report-ai-problem`: Applied during issue creation only
- `inspected-by: inspect-ai-problem-issue`: Applied after analysis completes successfully (idempotency gate)

### Multiple Labels

Multiple `cause:` labels CAN and SHOULD be applied to a single issue.

Example: An incident may involve both `cause: hallucination` (fabricated API endpoint) and `cause: overeagerness` (committed without user approval). Apply both.

## Repository Configuration

**Repository:** minouris/ai-devops
**Issue Tracking:** GitHub Issues
**Label Management:** GitHub issue labels
