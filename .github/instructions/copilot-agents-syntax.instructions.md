applyTo: "**/github/agents/*.agent.md"
---

# Copilot Agents Syntax Standards

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to multiple platform formats. This is OVERRIDDEN. When you create or edit Copilot agent files, you MUST use Copilot agent syntax only.

---

## Scope (MANDATORY)

**MUST:**
- Apply this standard to all Copilot agent files (`*.agent.md`)
- Keep syntax consistent with GitHub Copilot custom agent requirements

**MUST NOT:**
- Mix Claude Code agent syntax with Copilot agent syntax
- Reuse Claude-specific properties in Copilot agent frontmatter

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
- Include YAML frontmatter at the top of every Copilot agent file
- Include `description` (required)
- Include `name` when a stable command identity is needed
- Include `tools` when you want explicit tool scoping

**MUST NOT:**
- Omit `description`
- Add `paths` in agent frontmatter
- Add prompt-only fields such as `argument-hint`

**Valid example:**
```yaml
---
description: Brief description of agent purpose
name: my-agent
tools: [execute, read_file, replace_string_in_file, search, fetch_webpage]
---
```

---

## Tool Naming and Usage (MANDATORY)

**MUST:**
- Use valid Copilot tool names or aliases for configured environments
- Prefer canonical aliases in frontmatter such as `execute`, `read`, `edit`, `search`, `agent`, `web`
- Use concise instruction style: “Use `read_file` to…”
- Keep instructions explicit and imperative

**MUST NOT:**
- Use mixed tool naming in the same file
- Use verbose parameter-style phrasing tied to Claude syntax

---

## Path and Cross-Reference Rules (MANDATORY)

**MUST:**
- Reference Copilot assets via `.github/` structure
- Link instructions in `.github/instructions/`, prompts in `.github/prompts/`, and agents in `.github/agents/`

**MUST NOT:**
- Reference `.claude/` locations as the canonical path for Copilot artefacts

---

## Language Requirements (MANDATORY)

**MUST:**
- Use AI-targeted language (second person, imperative mood)
- Use explicit requirement framing with MUST/MUST NOT
- Use UK English spelling

**MUST NOT:**
- Use third-person AI descriptions
- Use vague wording such as “try to”, “maybe”, or “consider” where requirements are strict

---

## Compliance Verification

Before you finalise any Copilot agent file, verify:
- [ ] Frontmatter includes `description`
- [ ] Tool names are valid Copilot names or aliases
- [ ] No Claude-specific properties or tool terms are present
- [ ] `.github/` paths are used for Copilot references
- [ ] Language is AI-targeted, imperative, and unambiguous

If any check fails, correct the file before completion.

---

## Sources

According to the official documentation:
- [GitHub Docs: Custom agents configuration](https://docs.github.com/en/copilot/reference/custom-agents-configuration)
- [VS Code Docs: Use custom instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
