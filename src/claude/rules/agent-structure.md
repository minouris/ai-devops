# Agent Structure Standards

Defines the required structure for agent artifacts. Use this file both to guide creation of new agents and to validate existing agents against required standards.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
<!-- TODO: List required frontmatter fields, e.g.:
- Include `name` field matching filename (without .agent.md)
- Include `description` field (one sentence)
- Include `tools` list with only required tools (minimum necessary)
- Include `release` block if publishing
-->

**MUST NOT:**
<!-- TODO: List forbidden frontmatter patterns, e.g.:
- Request tools not needed for the task
- Omit the `name` or `description` fields
- Use multi-sentence descriptions
-->

**Example:**
```yaml
---
name: example-agent
description: Brief one-sentence description of what this agent does.
tools:
  - read
  - grep
  - glob
release:
  publish: true
  platforms: [claude]
  validation:
    - ai-targeted-language
    - agent-structure
---
```

---

## File Structure Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required file structure, e.g.:
- Place agent file in `src/{platform}/agents/`
- Name file as `{name}.agent.md`
-->

**MUST NOT:**
<!-- TODO: Define forbidden structural patterns, e.g.:
- Use a filename that does not end in `.agent.md`
- Create subdirectories for single-file agents
-->

---

## Content Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define required sections in an agent file, e.g.:
- Include a "# {Name} Agent" H1 heading
- Include a purpose/role paragraph
- Include a numbered workflow or step-by-step instructions
- Include output format specification
- Include a MUST/MUST NOT constraints section
-->

**MUST NOT:**
<!-- TODO: Define forbidden content patterns, e.g.:
- Omit output format specification
- Write instructions in third person about the agent
-->

---

## Tool Selection Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define tool selection rules, e.g.:
- Request only tools the agent's task requires
- Justify each tool if more than 3 are requested
-->

**MUST NOT:**
<!-- TODO: Forbidden tool patterns, e.g.:
- Request `bash` unless the agent needs to run shell commands
- Request `write` unless the agent needs to create files
-->

---

## Rule Embedding Requirements (MANDATORY)

**MUST:**
<!-- TODO: Define when/how to embed rules, e.g.:
- Embed rules verbatim using the rule-copying standard
- Include source attribution for embedded rules
- Embed only rules directly applicable to the task
-->

**MUST NOT:**
<!-- TODO: Forbidden embedding patterns, e.g.:
- Abbreviate or summarise embedded rules
- Embed rules not applicable to the agent's task
-->

---

## Naming Conventions (MANDATORY)

**MUST:**
<!-- TODO: Define naming rules, e.g.:
- Use lowercase with hyphens for agent name
- Use `.agent.md` extension
-->

**MUST NOT:**
<!-- TODO: Forbidden naming patterns -->

---

## Compliance Verification

**Before completing any agent artifact:**

Ask yourself:
<!-- TODO: Add checklist items matching the MUST requirements above -->
- [ ] Does the file end in `.agent.md`?
- [ ] Does frontmatter include `name`, `description`, and `tools`?
- [ ] Does the tools list contain only required tools?
- [ ] Does the file include a clear purpose and numbered workflow?
- [ ] Are all instructions written in second-person imperative?

**If ANY answer is "No":**
- Fix the issue before declaring the agent complete
- These are mandatory standards
