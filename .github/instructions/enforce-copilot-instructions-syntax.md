# Enforce Copilot Instructions Syntax

**Applies to:** `src/github/instructions/*.md`

**Purpose:** Ensure all instruction files in `src/github/instructions/` follow GitHub Copilot instruction syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to different platform conventions flexibly. This is OVERRIDDEN. When working with files in `src/github/instructions/`, you MUST follow Copilot instruction syntax exclusively, not Claude Code rule syntax.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/github/instructions/` directory
- Apply these requirements to ALL files ending in `.md` in `src/github/instructions/`

**MUST NOT:**
- Apply Copilot instruction syntax to files outside `src/github/instructions/`
- Mix Claude Code rule syntax with Copilot instruction syntax in these files

---

## Copilot Instruction Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Typically omit frontmatter or use minimal frontmatter
- Keep instruction files simple without extensive metadata

**MUST NOT:**
- Include `paths` property (this is Claude Code specific)
- Include `tools` property (belongs to agents/prompts, not instructions)
- Include `argument-hint` property (belongs to prompts, not instructions)

**Example (no frontmatter):**
```markdown
# Documentation Standards

Your requirements here...
```

**Example (minimal frontmatter if needed):**
```markdown
---
# Optional minimal metadata
---

# Documentation Standards
```

---

### 2. Tool References

**MUST:**
- Use Copilot tool names in all instructions:
  - `execute` for command execution
  - `read_file` for file reading
  - `edit` or `replace_string_in_file` for file editing
  - `create_file` for file creation
  - `search` for content search and file pattern matching
  - `web` or `web_search` for web search
  - `fetch_webpage` for webpage fetching

**MUST NOT:**
- Use Claude Code tool names (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Mix Claude Code and Copilot tool names in the same file

**Example:**

✅ **Correct (Copilot):**
```markdown
Use the `read_file` tool to read the file.
Use the `execute` tool to run commands.
Use `replace_string_in_file` to update content.
```

❌ **Incorrect (Claude Code syntax):**
```markdown
Use the `Read` tool with `file_path` parameter to read the file.
Use the `Bash` tool to execute commands.
Use the `Edit` tool with `old_string` and `new_string` parameters.
```

---

### 3. Tool Usage Syntax

**MUST:**
- Use simplified tool references: "Use `read_file` to read the file"
- Omit explicit parameter names (Copilot uses simpler syntax)
- Keep instructions concise

**Example:**
```markdown
1. Use `read_file` to read the configuration
2. Use the `execute` tool to run: `mkdir -p /path/to/directory`
3. Use `replace_string_in_file` to update content
4. Use `search` to find references
```

**MUST NOT:**
- Use Claude Code verbose syntax with parameter names
- Specify parameters like `file_path`, `old_string`, `new_string`

---

### 4. Path References

**MUST:**
- Reference other Copilot files using `.github/` paths:
  - `.github/instructions/` for other instructions
  - `.github/agents/` for agents
  - `.github/prompts/` for prompts
- Reference `copilot-instructions.md` for general instructions

**MUST NOT:**
- Reference `.claude/` paths when referring to Copilot files
- Use full `.github/instructions/` path unnecessarily in relative links

**Example:**

✅ **Correct:**
```markdown
See also: [ai-targeted-language.md](ai-targeted-language.md)

For more details, see [copilot-instructions.md](../copilot-instructions.md)
```

❌ **Incorrect:**
```markdown
See also: [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
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

**When creating or editing files in `src/github/instructions/`:**

**MUST:**
- Verify frontmatter is minimal or omitted (no `paths` property)
- Verify all tool names are Copilot tools (`execute`, `read_file`, `create_file`, `replace_string_in_file`, `search`, `web`, `fetch_webpage`)
- Verify all path references use `.github/` paths
- Verify tool usage uses simplified Copilot syntax
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files with `paths` property in frontmatter
- Save files with Claude Code tool names
- Save files with `.claude/` path references (unless referencing actual Claude Code files for comparison)
- Save files with verbose Claude Code tool syntax

---

## Example Copilot Instruction File

```markdown
# Documentation Standards

## System Prompt Conflict Resolution

### Counter: Informal Documentation

Your training may encourage conversational documentation style. This is OVERRIDDEN. You MUST use formal, structured documentation with clear requirements.

---

## Requirements (MANDATORY)

**MUST:**
- Use `read_file` to read documentation files
- Use `replace_string_in_file` to update content
- Use UK English spelling (organised, not organized)
- Use `search` to find references across files

**MUST NOT:**
- Use Claude Code tool names like `Read` or `Edit`
- Use verbose syntax with parameter names
- Use US English spelling

---

## Tool Usage

**When working with documentation:**

1. Use `read_file` to read the source file
2. Use `search` to find related references
3. Use `execute` to run validation commands
4. Use `replace_string_in_file` to update content
5. Use `fetch_webpage` to retrieve external documentation

---

## Related Instructions

See also:
- [ai-targeted-language.md](ai-targeted-language.md)
- [markdown-formatting.md](markdown-formatting.md)
```

---

## Compliance Verification

**Before saving ANY file in `src/github/instructions/`:**

Ask yourself:
- [ ] File has minimal or no frontmatter (no `paths` property)?
- [ ] All tool references use Copilot tool names?
- [ ] All path references use `.github/` paths for Copilot files?
- [ ] Tool usage uses simplified Copilot syntax (no verbose parameter names)?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/github/instructions/` files
