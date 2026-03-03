# Skill Authoring

Guide content creation for skill artifacts: multi-phase workflow files composed of `SKILL.md` and a `references/` subdirectory.

---

## File Structure

```
src/{platform}/skills/{name}/
  SKILL.md
  references/
    {phase-name}.md
    ...
```

<!-- TODO: Define complete directory structure requirements, naming conventions, and mandatory files -->

---

## Frontmatter Fields

```yaml
---
name: {name}
description: {description}
disable-model-invocation: true|false
release:
  publish: true|false
  platforms: [{platforms}]
  validation:
    - {rule}
---
```

<!-- TODO: Define which fields are required vs optional, allowed values, and validation rules for each field -->

---

## SKILL.md Content Requirements

<!-- TODO: Define required sections in SKILL.md (e.g. Workflow Overview, Important Notes) -->
<!-- TODO: Define how phases should be listed and linked to references/ files -->
<!-- TODO: Define MUST/MUST NOT constraints specific to SKILL.md structure -->

---

## Reference Files

<!-- TODO: Define structure requirements for per-phase reference files -->
<!-- TODO: Define how steps should be numbered and formatted -->
<!-- TODO: Define output/precondition/postcondition conventions -->

---

## AI-Targeted Language Enforcement

<!-- TODO: Define skill-specific language patterns to enforce or forbid -->
<!-- TODO: Define examples of correct and incorrect language for skill files -->

---

## Commit Checklist

<!-- TODO: Define files to stage and commit message format for a skill -->
