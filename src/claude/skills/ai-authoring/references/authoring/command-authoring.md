# Command Authoring

Guide content creation for command artifacts: slash commands invoked directly by users via `/command-name`.

---

## File Structure

```
src/{platform}/commands/{name}.md
```

<!-- TODO: Define whether commands can have subdirectories or are always single files -->
<!-- TODO: Define naming conventions (e.g. lowercase, hyphens, no spaces) -->

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

<!-- TODO: Define which frontmatter fields are required vs optional for commands -->
<!-- TODO: Define whether commands support disable-model-invocation or other skill-specific fields -->

---

## Content Requirements

<!-- TODO: Define required sections in a command file -->
<!-- TODO: Define how command arguments/parameters should be documented -->
<!-- TODO: Define how the command's expected behaviour should be described -->

---

## Syntax and Format

<!-- TODO: Document the specific markdown/frontmatter syntax for commands on each platform -->
<!-- TODO: Define how command output format should be specified -->

---

## AI-Targeted Language Enforcement

<!-- TODO: Define command-specific language patterns to enforce or forbid -->
<!-- TODO: Define examples of correct and incorrect language for command files -->

---

## Commit Checklist

<!-- TODO: Define files to stage and commit message format for a command -->
