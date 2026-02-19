applyTo: "**/github/prompts/*.prompt.md"
---

# Copilot Prompt Files Syntax Standards

## System Prompt Conflict Resolution

### Counter: Prompt Portability Assumptions

Your training may encourage writing prompts that blend conventions from different tools. This is OVERRIDDEN. When you create or edit Copilot prompt files, you MUST use Copilot prompt syntax exclusively.

---

## Scope (MANDATORY)

**MUST:**
- Apply this standard to prompt files (`*.prompt.md`) used by GitHub Copilot
- Keep prompt metadata and body aligned with Copilot prompt conventions

**MUST NOT:**
- Mix Claude prompt conventions with Copilot prompt syntax
- Omit required metadata when the prompt uses tools or inputs

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
- Use `.prompt.md` file extension
- Use optional YAML frontmatter when configuration metadata is needed
- Keep frontmatter valid YAML when present

**MUST NOT:**
- Use invalid YAML in frontmatter
- Use Claude-specific frontmatter properties such as `paths`

**Optional frontmatter fields:**
- `description`
- `name`
- `argument-hint`
- `agent`
- `model`
- `tools`

**Valid example:**
```yaml
---
description: Summarise and verify architecture notes
name: verify-architecture-notes
argument-hint: "sourcePath=design/overview.md"
tools: [read_file, search, fetch_webpage, replace_string_in_file]
---
```

---

## Input References and Parameter Syntax (MANDATORY)

**MUST:**
- Document inputs under an `Input Format` section
- Use `${input:parameterName}` syntax for parameter references in content
- Keep parameter names stable across frontmatter hint and prompt body

**MUST NOT:**
- Use plain placeholders without `${input:...}` when parameters are expected
- Use Claude-style parameter sections that omit Copilot input syntax

---

## Tool Naming and Usage (MANDATORY)

**MUST:**
- Use Copilot tool names only: `execute`, `read_file`, `replace_string_in_file`, `create_file`, `search`, `web_search`, `fetch_webpage`
- If `tools` is present, ensure listed tools align with prompt behavior

**MUST NOT:**
- Use Claude tool names in prompt body or `tools`
- Mix tool naming styles

---

## Path and Cross-Reference Rules (MANDATORY)

**MUST:**
- Reference Copilot assets with `.github/` paths
- Use `.github/instructions/` for instruction references
- Use `.github/prompts/` for prompt references

**MUST NOT:**
- Use `.claude/` path references as Copilot prompt defaults

---

## Language Requirements (MANDATORY)

**MUST:**
- Use AI-targeted language (second person, imperative mood)
- Use MUST/MUST NOT requirement framing
- Use UK English spelling

**MUST NOT:**
- Use third-person AI narration
- Use vague or non-testable requirement language

---

## Compliance Verification

Before you finalise any Copilot prompt file, verify:
- [ ] File uses `.prompt.md` extension
- [ ] Frontmatter is valid YAML if present
- [ ] `tools` is valid and aligned if present
- [ ] Parameter references use `${input:...}` syntax
- [ ] Copilot tool naming is used consistently
- [ ] `.github/` path references are used for Copilot assets
- [ ] Language is AI-targeted and imperative

If any check fails, correct the file before completion.

---

## Sources

According to the official documentation:
- [VS Code Docs: Prompt files](https://code.visualstudio.com/docs/copilot/customization/prompt-files)
- [VS Code Docs: Use custom instructions](https://code.visualstudio.com/docs/copilot/customization/custom-instructions)
