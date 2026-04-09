# Check Sub-Issues

For each `cause:` label identified in the classify-ai-problem-causes skill, check for an existing open issue that already covers this cause in the context of the current incident, then compose a body for any that require a new sub-issue.

**IMPORTANT:** Use the label format `cause: <label>` (with a space after the colon) as defined in the [ai-problem-taxonomy](../../ai-problem-taxonomy/SKILL.md).

## Duplicate Check

For each cause label:

```
gh issue list \
  --repo minouris/ai-devops \
  --state open \
  --label "cause: <label>" \
  --search "<incident description keyword>"
```

An existing sub-issue matches if it concerns the **same root cause label** and the **same class of violation** — i.e., the same rule, the same training trigger, or the same mechanism. A pre-existing issue for the same cause but a different mechanism does not match.

Record for each cause label:
- Whether an existing issue was found, and if so its number, title, and URL
- If no existing issue was found, that a new sub-issue will be created

## Sub-Issue Body Template

For each cause that requires a new sub-issue, compose its body:

````markdown
## Root Cause

**Label:** `cause: <label>`

<Verbatim excerpt defining this cause — the full definition section, not a summary>

## How This Cause Manifested in the Incident

<One paragraph: how this specific cause contributed to the incident, referencing the incident context passed by the calling skill>

## Contributing Factors Specific to This Cause

<The subset of contributing factors attributable to this cause — verbatim quotes where applicable>

## Parent Issue

Relates to: #<main issue number>
````

## Output

Pass the following to the calling skill's present and submit flows:

| Cause label | Action | Existing issue |
|-------------|--------|----------------|
| `cause: <label>` | Create new sub-issue | — |
| `cause: <label>` | Link existing issue as sub-issue | #N — <title> (<url>) |
