# Rule Authoring

Guide content creation for rule artifacts: instruction files that define mandatory standards enforced during AI task execution.

---

## File Structure

```
src/{platform}/rules/{name}.md
```

<!-- TODO: Define naming conventions for rules (e.g. lowercase, hyphens, descriptive) -->

---

## Frontmatter Fields

```yaml
---
name: {name}
description: {description}
release:
  publish: true|false
  platforms: [{platforms}]
  validation:
    - {rule}
---
```

<!-- TODO: Define which frontmatter fields are required vs optional for rules -->

---

## Content Requirements

<!-- TODO: Define required top-level sections (e.g. System Prompt Conflict Resolution, MUST/MUST NOT, Compliance Verification) -->
<!-- TODO: Define how conflict resolution counters should be written -->
<!-- TODO: Define how MUST and MUST NOT sections should be structured -->
<!-- TODO: Define when examples are required vs optional -->

---

## System Prompt Conflict Resolution Section

<!-- TODO: Define the standard structure for overriding AI default behaviours -->
<!-- TODO: Define naming convention for counter headings -->

---

## Compliance Verification Section

<!-- TODO: Define the standard checklist format at the end of rules -->
<!-- TODO: Define the "If ANY answer is No" enforcement pattern -->

---

## AI-Targeted Language Enforcement

<!-- TODO: Define rule-specific language patterns: imperative, second-person, unambiguous -->
<!-- TODO: Define examples of correct and incorrect language for rule files -->

---

## Commit Checklist

<!-- TODO: Define files to stage and commit message format for a rule -->
