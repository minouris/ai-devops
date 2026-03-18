# Hook Structure Standards

Defines the required structure for hook artifacts (shell commands that execute automatically in response to AI tool events). Use this file both to guide creation of new hooks and to validate existing hooks against required standards.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required frontmatter fields for hooks, e.g.:
- Include `name` field matching filename (without .hook.md)
- Include `description` field (one sentence)
- Include `event` field specifying the trigger event
- Include `release` block if publishing
-->

**MUST NOT:**
<!-- TODO: List forbidden frontmatter patterns, e.g.:
- Omit the `event` field
- Specify an unknown or unsupported event name
-->

**Example:**
```yaml
---
name: example-hook
description: Brief one-sentence description of what this hook does.
event: PreToolUse
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - hook-structure
---
```

---

## File Structure Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required file structure, e.g.:
- Place hook file in `src/{platform}/hooks/`
- Name file as `{name}.hook.md`
-->

**MUST NOT:**
<!-- TODO: Define forbidden structural patterns, e.g.:
- Use a filename that does not end in `.hook.md`
-->

---

## Supported Events (MANDATORY)

**MUST:**
<!-- TODO: Document supported event names and their triggers, e.g.:
- `PreToolUse`: fires before any tool call is executed
- `PostToolUse`: fires after a tool call completes
- `Stop`: fires when the AI session ends
-->

**MUST NOT:**
<!-- TODO: Forbidden event values -->

---

## Shell Command Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define requirements for the hook shell command, e.g.:
- Specify the exact shell command or script to execute
- Document what the command does and why
- Document exit code behaviour: non-zero exit blocks the triggering action
-->

**MUST NOT:**
<!-- TODO: Forbidden shell command patterns, e.g.:
- Include unvalidated external input in shell commands without sanitisation
- Use commands that produce destructive side effects without confirmation
-->

---

## Security Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define security requirements, e.g.:
- Validate and sanitise any inputs used in shell commands
- Document any environment variables or secrets the hook depends on
- Limit hook scope to the minimum required operation
-->

**MUST NOT:**
<!-- TODO: Forbidden security patterns, e.g.:
- Use eval or unquoted variables in shell commands
- Expose secrets in the hook command itself
- Run as root unless explicitly required and documented
-->

---

## Naming Conventions (MANDATORY)

**MUST:**
<!-- TODO: Define naming rules, e.g.:
- Use lowercase with hyphens for hook name
- Name reflects the event and purpose (e.g. `pre-bash-safety`)
- Use `.hook.md` extension
-->

**MUST NOT:**
<!-- TODO: Forbidden naming patterns -->

---

## Compliance Verification

**Before completing any hook artifact:**

Ask yourself:
<!-- TODO: Add checklist items matching the MUST requirements above -->
- [ ] Does frontmatter include `name`, `description`, and `event` fields?
- [ ] Is the `event` value a supported event name?
- [ ] Is the file in `src/{platform}/hooks/` with a `.hook.md` extension?
- [ ] Is the shell command documented with its exit code behaviour?
- [ ] Are security requirements met (sanitised inputs, no exposed secrets)?

**If ANY answer is "No":**
- Fix the issue before declaring the hook complete
- These are mandatory standards
