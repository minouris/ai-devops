# Command Structure Standards

Defines the required structure for command artifacts (slash commands invoked by users via `/command-name`). Use this file both to guide creation of new commands and to validate existing commands against required standards.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required frontmatter fields for commands, e.g.:
- Include `name` field matching filename (without .md)
- Include `description` field (one sentence) — shown to user in slash command list
- Include `release` block if publishing
-->

**MUST NOT:**
<!-- TODO: List forbidden frontmatter patterns -->

**Example:**
```yaml
---
name: example-command
description: Brief one-sentence description shown in the slash command list.
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - command-structure
---
```

---

## File Structure Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required file structure, e.g.:
- Place command file in `src/{platform}/commands/`
- Name file as `{name}.md`
- Use a single file (commands do not use a references/ subdirectory)
-->

**MUST NOT:**
<!-- TODO: Define forbidden structural patterns, e.g.:
- Create subdirectories for a command
- Use `.command.md` or other non-standard extension
-->

---

## Content Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required sections in a command file, e.g.:
- Include a purpose/description of what the command does
- Include any argument or parameter documentation
- Include the workflow steps the command follows
- Include expected output or result description
-->

**MUST NOT:**
<!-- TODO: Define forbidden content patterns -->

---

## Argument and Parameter Documentation (MANDATORY when arguments exist)

**MUST:**
<!-- TODO: Define how arguments should be documented, e.g.:
- Document each argument name, type, and whether required or optional
- Provide examples of invocation with arguments
-->

**MUST NOT:**
<!-- TODO: Forbidden argument documentation patterns -->

---

## Naming Conventions (MANDATORY)

**MUST:**
<!-- TODO: Define naming rules, e.g.:
- Use lowercase with hyphens for command name
- Name reflects the action performed (verb-noun format preferred)
- Use `.md` extension
-->

**MUST NOT:**
<!-- TODO: Forbidden naming patterns, e.g.:
- Use uppercase letters
- Use spaces or underscores
-->

---

## Compliance Verification

**Before completing any command artifact:**

Ask yourself:
<!-- TODO: Add checklist items matching the MUST requirements above -->
- [ ] Does frontmatter include `name` and `description` fields?
- [ ] Is the description a single sentence suitable for display in command lists?
- [ ] Is the file in `src/{platform}/commands/` with a `.md` extension?
- [ ] Are arguments and parameters documented (if any)?
- [ ] Are all instructions written in second-person imperative?

**If ANY answer is "No":**
- Fix the issue before declaring the command complete
- These are mandatory standards
