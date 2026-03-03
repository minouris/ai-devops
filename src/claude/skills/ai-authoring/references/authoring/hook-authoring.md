# Hook Authoring

Guide content creation for hook artifacts: shell commands that execute automatically in response to AI tool events (e.g. pre/post tool calls).

---

## File Structure

```
src/{platform}/hooks/{name}.hook.md
```

<!-- TODO: Confirm file path convention for hook artifacts -->
<!-- TODO: Define naming conventions for hooks (e.g. event-based names like pre-bash, post-edit) -->

---

## Frontmatter Fields

```yaml
---
name: {name}
description: {description}
event: {event-name}
release:
  publish: true|false
  platforms: [{platforms}]
  validation:
    - {rule}
---
```

<!-- TODO: Define the complete list of supported hook events and their triggers -->
<!-- TODO: Define which frontmatter fields are required vs optional for hooks -->

---

## Hook Events

<!-- TODO: Document each supported event type (e.g. PreToolUse, PostToolUse, Stop, etc.) -->
<!-- TODO: Define what context is available to the hook shell command at each event -->

---

## Content Requirements

<!-- TODO: Define required sections in a hook file -->
<!-- TODO: Define how the hook shell command should be specified -->
<!-- TODO: Define how hook exit code semantics should be documented (e.g. non-zero blocks execution) -->

---

## Security Considerations

<!-- TODO: Define security requirements for hook commands -->
<!-- TODO: Define what inputs must be validated or sanitised -->
<!-- TODO: Define forbidden shell patterns -->

---

## AI-Targeted Language Enforcement

<!-- TODO: Define hook-specific language patterns to enforce or forbid -->
<!-- TODO: Define examples of correct hook documentation language -->

---

## Commit Checklist

<!-- TODO: Define files to stage and commit message format for a hook -->
