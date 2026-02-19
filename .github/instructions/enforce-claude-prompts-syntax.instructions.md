---
applyTo: "src/claude/prompts/*.prompt.md"
---

# Enforce Claude Code Prompts Syntax

**Applies to:** `src/claude/prompts/*.prompt.md`

**Purpose:** Ensure all prompt files in `src/claude/prompts/` follow Claude Code prompt syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When writing Claude Code prompts, you MUST transform ALL platform-specific elements to match Claude Code conventions, not preserve Copilot patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/claude/prompts/` directory
- Apply these requirements to ALL files ending in `.prompt.md` in `src/claude/prompts/`

**MUST NOT:**
- Apply Claude Code prompt syntax to files outside `src/claude/prompts/`
- Mix Copilot prompt syntax with Claude Code prompt syntax in these files

---

## Claude Code Prompt Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Include frontmatter at the top of every prompt file
- Include `name` field with prompt name
- Include `description` field with prompt purpose

**MUST NOT:**
- Include `tools` property in Claude Code prompt frontmatter
- Include `argument-hint` property in Claude Code prompt frontmatter
- Include `paths` property (belongs to rule files, not prompts)
- Omit required `name` and `description` fields

**Example:**
```yaml
---
name: prompt-name
description: Brief description of prompt purpose
---
```

---

### 2. Parameter Syntax

**MUST:**
- Remove Copilot `${input:paramName}` syntax
- Document expected parameters explicitly in prompt body
- Use an `Input Parameters` section when parameter clarity is required
- Describe parameter names and expected values directly

**MUST NOT:**
- Leave `${input:}` references in Claude Code prompt files
- Use Copilot `argument-hint` syntax
- Assume Copilot parameter passing behavior in Claude Code prompts

**Example (Claude Code style):**
```markdown
## Input Parameters

- `memoryFilePath` - Path to the memory file to process (e.g., `.memory/facts.md`)

Read the memory file at the provided path.
```

---

### 3. Tool References

**MUST:**
- Use Claude Code tool names in all prompt instructions:
  - `Bash` for command execution
  - `Read` for file reading
  - `Edit` for file editing
  - `Write` for file creation
  - `Grep` for content search
  - `Glob` for file pattern matching
  - `WebSearch` for web search
  - `WebFetch` for webpage fetching

**MUST NOT:**
- Use Copilot tool names (`execute`, `read_file`, `edit`, `replace_string_in_file`, `create_file`, `search`, `web_search`, `fetch_webpage`)
- Mix Copilot and Claude Code tool names in the same file

---

### 4. Tool Usage Syntax

**MUST:**
- Use explicit Claude Code tool invocation language
- Include parameter names when describing tool usage
- Use absolute paths from workspace root for file operations

**MUST NOT:**
- Use simplified Copilot syntax without parameter names
- Use Copilot-specific parameter names when Claude Code differs

**Example:**
```markdown
1. Use `Read` tool with `file_path` parameter to read the memory file
2. Use `Grep` tool with pattern parameter to search file contents
3. Use `Edit` tool with `old_string` and `new_string` parameters to update facts
4. Use `WebFetch` tool with `url` and `prompt` parameters to verify sources
```

---

### 5. Path References

**MUST:**
- Reference Claude Code files using `.claude/` paths
- Reference rules via `.claude/rules/`
- Reference agents via `.claude/agents/`
- Reference prompts via `.claude/prompts/`

**MUST NOT:**
- Leave `.github/` path references in Claude Code prompt files
- Reference Copilot-specific files as canonical Claude prompt dependencies

---

### 6. Language and Structure

**MUST:**
- Preserve AI-targeted language (second person "you", imperative mood)
- Maintain all MUST/MUST NOT requirement blocks
- Preserve verification checklist format (`- [ ]`)
- Use UK English spelling (organised, colour, recognise, analyse)

**MUST NOT:**
- Convert AI-targeted language to human-targeted documentation
- Remove or weaken MUST/MUST NOT requirements
- Introduce US English spellings (organized, color, recognize, analyze)

---

## Validation Requirements (MANDATORY)

**When creating or editing files in `src/claude/prompts/`:**

**MUST:**
- Verify frontmatter includes only Claude prompt fields (`name`, `description`)
- Verify frontmatter does NOT include `tools`, `argument-hint`, or `paths`
- Verify tool references use Claude Code tool names
- Verify `${input:}` syntax is not present
- Verify path references use `.claude/` paths
- Verify tool usage includes parameter names
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files with Copilot prompt syntax
- Save files with Copilot tool names
- Save files with `.github/` path references for Claude prompt dependencies
- Save files without required Claude prompt frontmatter

---

## Compliance Verification

**Before saving ANY file in `src/claude/prompts/`:**

Ask yourself:
- [ ] File includes frontmatter with `name` and `description`?
- [ ] Frontmatter excludes `tools`, `argument-hint`, and `paths`?
- [ ] All tool references use Claude Code tool names?
- [ ] No `${input:}` syntax remains?
- [ ] All path references use `.claude/` paths for Claude Code files?
- [ ] Tool usage includes Claude Code parameter names?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/claude/prompts/` files

---

## Sources

This enforcement file is based on verified information from official documentation and repository conversion guidance:

- [Claude Code Create custom commands and prompts](https://code.claude.com/docs/en/commands)
- [Claude Code Settings - Tools](https://code.claude.com/docs/en/settings)
- [.memory/convert-copilot-prompts-to-claude.md](../../.memory/convert-copilot-prompts-to-claude.md)

**Verified:** 2026-02-19
