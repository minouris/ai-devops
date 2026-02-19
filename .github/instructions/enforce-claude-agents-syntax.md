# Enforce Claude Code Agents Syntax

**Applies to:** `src/claude/agents/*.agent.md`

**Purpose:** Ensure all agent files in `src/claude/agents/` follow Claude Code agent syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to different platform conventions flexibly. This is OVERRIDDEN. When working with files in `src/claude/agents/`, you MUST follow Claude Code agent syntax exclusively, not Copilot agent syntax.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/claude/agents/` directory
- Apply these requirements to ALL files ending in `.agent.md` in `src/claude/agents/`

**MUST NOT:**
- Apply Claude Code agent syntax to files outside `src/claude/agents/`
- Mix Copilot agent syntax with Claude Code agent syntax in these files

---

## Claude Code Agent Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Include frontmatter at the top of every agent file
- Include `name` field with agent name
- Include `description` field with agent purpose

**Example:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
---
```

**MUST NOT:**
- Omit frontmatter from agent files
- Include `tools` property (Claude Code does not use this in agent frontmatter)
- Include `argument-hint` property (belongs to Copilot prompts only)
- Include `paths` property (belongs to rules, not agents)

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
  - `Task` for spawning sub-agents

**MUST NOT:**
- Use Copilot tool names (`execute`, `read_file`, `create_file`, `replace_string_in_file`, `search`, `web`, `fetch_webpage`)
- Mix Copilot and Claude Code tool names in the same file

**Example:**

✅ **Correct (Claude Code):**
```markdown
Use the `Read` tool with `file_path` parameter to read the file.
Use the `Bash` tool with command parameter to execute commands.
Use the `Edit` tool with `old_string` and `new_string` parameters.
```

❌ **Incorrect (Copilot syntax):**
```markdown
Use the `read_file` tool to read the file.
Use the `execute` tool to run commands.
Use `replace_string_in_file` to update content.
```

---

### 3. Tool Usage Syntax

**MUST:**
- Specify tool names explicitly with capitalization: "Use the `Bash` tool"
- Include parameter names when describing tool usage
- Use absolute paths from workspace root for file operations
- Specify parameters: `file_path`, `command`, `old_string`, `new_string`, `pattern`, `url`, `prompt`

**Example:**
```markdown
1. Use `Read` tool with `file_path` parameter to read the source file
2. Use `Bash` tool with command `mkdir -p /path/to/directory`
3. Use `Edit` tool with `old_string` and `new_string` parameters to update content
4. Use `Grep` tool with pattern parameter to search file contents
5. Use `WebFetch` tool with `url` and `prompt` parameters to retrieve documentation
```

**MUST NOT:**
- Use simplified Copilot syntax without parameter names
- Omit tool parameter specifications
- Use lowercase tool names

---

### 4. Embedded Rules

**MUST:**
- Include intro text: "Rules embedded directly in this agent for self-contained execution"
- Reference Claude Code rule files: `.claude/rules/`
- Use Claude Code tool names in embedded rule content
- Maintain proper heading structure

**Example:**
```markdown
# Embedded Rules

Rules embedded directly in this agent for self-contained execution.

## Documentation-First Requirements (from .claude/rules/documentation-first.md)

**MUST:**
- Use `WebFetch` tool to verify sources
- Use `Read` tool to read documentation files
```

**MUST NOT:**
- Reference `copilot-instructions.md` or `.github/instructions/` files
- Use Copilot tool names in embedded rules
- Omit embedded rules intro text

---

### 5. Path References

**MUST:**
- Reference other Claude Code files using `.claude/` paths:
  - `.claude/rules/` for rules
  - `.claude/agents/` for other agents
  - `.claude/prompts/` for prompts (if they exist)

**MUST NOT:**
- Reference `.github/` paths when referring to Claude Code files
- Reference `copilot-instructions.md` or other Copilot-specific files

**Example:**

✅ **Correct:**
```markdown
See also: [verify-facts.prompt.md](.claude/prompts/verify-facts.prompt.md)

## Embedded Rules (from .claude/rules/documentation-first.md)
```

❌ **Incorrect:**
```markdown
See also: [verify-facts.prompt.md](.github/prompts/verify-facts.prompt.md)

## Embedded Rules (from copilot-instructions.md)
```

---

### 6. Workflows and Processes

**MUST:**
- Use Claude Code tool names in all workflow steps
- Include parameter names in workflow instructions
- Preserve AI-targeted language (second person "you")

**Example:**
```markdown
## Your Process

1. Use `Read` tool with `file_path` parameter to read the memory file
2. Use `Grep` tool with pattern parameter to find references
3. Use `Edit` tool with `old_string` and `new_string` parameters to update facts
```

**MUST NOT:**
- Use Copilot tool names in workflows
- Use simplified syntax without parameters

---

### 7. Language and Style

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

**When creating or editing files in `src/claude/agents/`:**

**MUST:**
- Verify frontmatter includes only `name` and `description` fields
- Verify frontmatter does NOT include `tools` property
- Verify all tool names are Claude Code tools (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Verify all path references use `.claude/` paths
- Verify tool usage includes parameter names
- Verify embedded rules use Claude Code syntax
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files with `tools` property in frontmatter
- Save files with Copilot tool names
- Save files without frontmatter
- Save files with `.github/` path references for Claude Code files
- Save files with Copilot tool names in embedded rules

---

## Example Claude Code Agent File

```markdown
---
name: analysis
description: Systematically capture research findings and create curated outputs
---

# Research/Analysis Agent

Perform systematic investigation and capture findings.

---

# Embedded Rules

Rules embedded directly in this agent for self-contained execution.

## Documentation-First Requirements (from .claude/rules/documentation-first.md)

**MUST:**
- Use `WebFetch` tool with `url` and `prompt` parameters to verify sources
- Use `Read` tool with `file_path` parameter to read documentation

**MUST NOT:**
- Use Copilot tool names like `fetch_webpage` or `read_file`

---

## Your Process

### Step 1: Read and Parse

**Execute:**
1. Use `Read` tool with `file_path` parameter to read the memory file
2. Extract all relevant information

**MUST:**
- Use absolute paths from workspace root
- Verify file exists before processing

### Step 2: Search and Verify

**Execute:**
1. Use `Grep` tool with pattern parameter to find references
2. Use `WebFetch` tool with `url` and `prompt` parameters to verify sources

### Step 3: Update Content

**Execute:**
1. Use `Edit` tool with `old_string` and `new_string` parameters to update facts

**MUST NOT:**
- Use `replace_string_in_file` (Copilot tool name)

---

## Related Files

See also:
- [verify-facts.prompt.md](.claude/prompts/verify-facts.prompt.md)
- [documentation-first.md](.claude/rules/documentation-first.md)
```

---

## Compliance Verification

**Before saving ANY file in `src/claude/agents/`:**

Ask yourself:
- [ ] File includes frontmatter with `name` and `description` only?
- [ ] Frontmatter does NOT include `tools` property?
- [ ] All tool references use Claude Code tool names?
- [ ] All path references use `.claude/` paths for Claude Code files?
- [ ] Tool usage includes parameter names?
- [ ] Embedded rules use Claude Code syntax?
- [ ] Embedded rules reference `.claude/rules/` files?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/claude/agents/` files

---

## Sources

This enforcement file is based on verified information from official documentation:

- [Claude Code Create custom subagents](https://code.claude.com/docs/en/sub-agents)
- [Claude Code Settings - Tools](https://code.claude.com/docs/en/settings)

**Verified:** 2026-02-19

**Key Requirements from Official Documentation:**
- `name` and `description` fields are REQUIRED in frontmatter
- Optional fields: `tools`, `disallowedTools`, `model`, `permissionMode`, `maxTurns`, `skills`, `mcpServers`, `hooks`, `memory`
- Subagents inherit all tools by default unless restricted via `tools` or `disallowedTools`
- Tool names: Bash, Read, Edit, Write, Grep, Glob, WebSearch, WebFetch, Task
