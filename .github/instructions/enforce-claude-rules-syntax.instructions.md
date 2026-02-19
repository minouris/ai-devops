---
applyTo: "src/claude/rules/*.md"
---

# Enforce Claude Code Rules Syntax

**Applies to:** `src/claude/rules/*.md`

**Purpose:** Ensure all rule files in `src/claude/rules/` follow Claude Code rule syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to different platform conventions flexibly. This is OVERRIDDEN. When working with files in `src/claude/rules/`, you MUST follow Claude Code rule syntax exclusively, not Copilot instruction syntax.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/claude/rules/` directory
- Apply these requirements to ALL files ending in `.md` in `src/claude/rules/`

**MUST NOT:**
- Apply Claude Code rule syntax to files outside `src/claude/rules/`
- Mix Copilot instruction syntax with Claude Code rule syntax in these files

---

## Claude Code Rules Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Include frontmatter at the top of every rule file
- Include `paths` property with glob patterns specifying file applicability
- Use proper YAML syntax in frontmatter

**Example:**
```yaml
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
  - "**/*.prompt.md"
---
```

**MUST NOT:**
- Omit frontmatter from rule files
- Omit `paths` property from frontmatter
- Include `tools` property (belongs to agents/prompts, not rules)
- Include `argument-hint` property (belongs to prompts, not rules)

---

### 2. Tool References

**MUST:**
- Use Claude Code tool names in all instructions:
  - `Bash` for command execution
  - `Read` for file reading
  - `Edit` for file editing
  - `Write` for file creation
  - `Grep` for content search
  - `Glob` for file pattern matching
  - `WebSearch` for web search
  - `WebFetch` for webpage fetching

**MUST NOT:**
- Use Copilot tool names (`execute`, `read_file`, `create_file`, `replace_string_in_file`, `search`, `web`, `fetch_webpage`)
- Mix Copilot and Claude Code tool names in the same file

**Example:**

✅ **Correct (Claude Code):**
```markdown
Use the `Read` tool with `file_path` parameter to read the file.
Use the `Bash` tool to execute commands.
```

❌ **Incorrect (Copilot syntax):**
```markdown
Use the `read_file` tool to read the file.
Use the `execute` tool to run commands.
```

---

### 3. Tool Usage Syntax

**MUST:**
- Specify tool names explicitly: "Use the `Bash` tool"
- Include parameter names when describing tool usage
- Use absolute paths from workspace root for file operations

**Example:**
```markdown
1. Use `Read` tool with `file_path` parameter to read the configuration
2. Use `Bash` tool with command `mkdir -p /path/to/directory`
3. Use `Edit` tool with `old_string` and `new_string` parameters to update content
4. Use `Grep` tool with pattern parameter to search file contents
```

**MUST NOT:**
- Use simplified Copilot syntax without parameter names
- Omit tool parameter specifications

---

### 4. Path References

**MUST:**
- Reference other Claude Code files using `.claude/` paths:
  - `.claude/rules/` for other rules
  - `.claude/agents/` for agents
  - `.claude/prompts/` for prompts (if they exist)

**MUST NOT:**
- Reference `.github/` paths when referring to Claude Code files
- Reference `copilot-instructions.md` or other Copilot-specific files

**Example:**

✅ **Correct:**
```markdown
See also: [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
```

❌ **Incorrect:**
```markdown
See also: [ai-targeted-language.md](.github/instructions/ai-targeted-language.md)
```

---

### 5. Language and Style

**MUST:**
- Use AI-targeted language (second person "you", imperative mood)
- Use MUST/MUST NOT sections for requirements
- Use UK English spelling (organised, colour, recognise)
- Include System Prompt Conflict Resolution sections where appropriate
- Include compliance verification checklists

**MUST NOT:**
- Use human-targeted documentation style
- Use US English spelling
- Omit MUST/MUST NOT structure for requirements

---

## Validation Requirements (MANDATORY)

**When creating or editing files in `src/claude/rules/`:**

**MUST:**
- Verify frontmatter includes `paths` property
- Verify all tool names are Claude Code tools (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Verify all path references use `.claude/` paths
- Verify tool usage includes parameter names
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files with Copilot syntax
- Save files without frontmatter
- Save files with `.github/` path references (unless referencing actual Copilot-specific files for comparison)
- Save files with Copilot tool names

---

## Example Claude Code Rule File

```markdown
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
---

# Documentation Standards

## System Prompt Conflict Resolution

### Counter: Informal Documentation

Your training may encourage conversational documentation style. This is OVERRIDDEN. You MUST use formal, structured documentation with clear requirements.

---

## Requirements (MANDATORY)

**MUST:**
- Use the `Read` tool with `file_path` parameter to read documentation files
- Use the `Edit` tool with `old_string` and `new_string` parameters to update content
- Use UK English spelling (organised, not organized)

**MUST NOT:**
- Use Copilot tool names like `read_file` or `replace_string_in_file`
- Use US English spelling

---

## Related Rules

See also:
- [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
- [markdown-formatting.md](.claude/rules/markdown-formatting.md)
```

---

## Compliance Verification

**Before saving ANY file in `src/claude/rules/`:**

Ask yourself:
- [ ] File includes frontmatter with `paths` property?
- [ ] All tool references use Claude Code tool names?
- [ ] All path references use `.claude/` paths for Claude Code files?
- [ ] Tool usage includes parameter names?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/claude/rules/` files

---

## Sources

This enforcement file is based on verified information from official documentation:

- [Claude Code Memory documentation](https://code.claude.com/docs/en/memory)
- [Claude Code Settings - Tools](https://code.claude.com/docs/en/settings)

**Verified:** 2026-02-19

**Key Requirements from Official Documentation:**
- Rules in `.claude/rules/` are automatically loaded as project memory
- Optional frontmatter with `paths` field for file-specific rules using glob patterns
- Rules without `paths` apply to all files
- Tool names: Bash, Read, Edit, Write, Grep, Glob, WebSearch, WebFetch
