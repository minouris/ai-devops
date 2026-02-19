# Enforce Copilot Agents Syntax

**Applies to:** `src/github/agents/*.agent.md`

**Purpose:** Ensure all agent files in `src/github/agents/` follow GitHub Copilot agent syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to different platform conventions flexibly. This is OVERRIDDEN. When working with files in `src/github/agents/`, you MUST follow Copilot agent syntax exclusively, not Claude Code agent syntax.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/github/agents/` directory
- Apply these requirements to ALL files ending in `.agent.md` in `src/github/agents/`

**MUST NOT:**
- Apply Copilot agent syntax to files outside `src/github/agents/`
- Mix Claude Code agent syntax with Copilot agent syntax in these files

---

## Copilot Agent Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Include frontmatter at the top of every agent file
- Include `name` field with agent name
- Include `description` field with agent purpose
- Include `tools` property with array of tool names used in the agent

**Example:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
tools: [execute, read, edit, search, web, fetch_webpage]
---
```

**MUST NOT:**
- Omit frontmatter from agent files
- Omit `tools` property (Copilot requires this)
- Include `paths` property (belongs to Claude Code rules, not Copilot agents)
- Include incorrect tools in the tools array

---

### 2. Tools Property

**MUST:**
- List ALL tools used in the agent content
- Use Copilot tool names in the array
- Common tools: `execute`, `read`, `edit`, `search`, `web`, `web_search`, `fetch_webpage`, `create_file`, `replace_string_in_file`

**Example:**
```yaml
tools: [execute, read, edit, search, web, fetch_webpage]
```

**MUST NOT:**
- Use Claude Code tool names in tools array (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`)
- Omit tools that are used in the agent content
- Include tools that are not used in the agent content

---

### 3. Tool References in Content

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
Use `read_file` to read the file.
Use the `execute` tool to run commands.
Use `replace_string_in_file` to update content.
```

❌ **Incorrect (Claude Code syntax):**
```markdown
Use the `Read` tool with `file_path` parameter to read the file.
Use the `Bash` tool with command parameter.
Use the `Edit` tool with `old_string` and `new_string` parameters.
```

---

### 4. Tool Usage Syntax

**MUST:**
- Use simplified tool references: "Use `read_file` to read..."
- Omit explicit parameter names (Copilot uses simpler syntax)
- Keep instructions concise

**Example:**
```markdown
1. Use `read_file` to read the source file
2. Use `search` to find references
3. Use `execute` to run: `mkdir -p /path/to/directory`
4. Use `replace_string_in_file` to update content
5. Use `fetch_webpage` to retrieve documentation
```

**MUST NOT:**
- Use Claude Code verbose syntax with parameter names
- Specify parameters like `file_path`, `old_string`, `new_string`, `pattern`
- Use capitalized tool names

---

### 5. Embedded Rules

**MUST:**
- Reference Copilot instruction files: `.github/instructions/` or `copilot-instructions.md`
- Use Copilot tool names in embedded rule content
- Keep embedded rules simple

**Example:**
```markdown
# Embedded Rules

## Documentation-First Requirements (from copilot-instructions.md)

**MUST:**
- Use `fetch_webpage` to verify sources
- Use `read_file` to read documentation files

**MUST NOT:**
- Use Claude Code tool names like `WebFetch` or `Read`
```

**MUST NOT:**
- Reference `.claude/rules/` files
- Use Claude Code tool names in embedded rules
- Use verbose embedded rules intro text from Claude Code

---

### 6. Path References

**MUST:**
- Reference other Copilot files using `.github/` paths:
  - `.github/instructions/` for instructions
  - `.github/agents/` for other agents
  - `.github/prompts/` for prompts
- Reference `copilot-instructions.md` for general embedded rules

**MUST NOT:**
- Reference `.claude/` paths when referring to Copilot files

**Example:**

✅ **Correct:**
```markdown
See also: [verify-facts.prompt.md](../prompts/verify-facts.prompt.md)

## Embedded Rules (from copilot-instructions.md)
```

❌ **Incorrect:**
```markdown
See also: [verify-facts.prompt.md](.claude/prompts/verify-facts.prompt.md)

## Embedded Rules (from .claude/rules/documentation-first.md)
```

---

### 7. Workflows and Processes

**MUST:**
- Use Copilot tool names in all workflow steps
- Use simplified syntax without parameter names
- Preserve AI-targeted language (second person "you")

**Example:**
```markdown
## Your Process

1. Use `read_file` to read the memory file
2. Use `search` to find references
3. Use `replace_string_in_file` to update facts
```

**MUST NOT:**
- Use Claude Code tool names in workflows
- Use verbose syntax with parameters

---

### 8. Language and Style

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

**When creating or editing files in `src/github/agents/`:**

**MUST:**
- Verify frontmatter includes `name`, `description`, and `tools` fields
- Verify `tools` array lists all tools used in content
- Verify `tools` array uses Copilot tool names
- Verify all tool references in content use Copilot tool names
- Verify all path references use `.github/` paths
- Verify tool usage uses simplified Copilot syntax
- Verify embedded rules reference Copilot files
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files without `tools` property in frontmatter
- Save files with Claude Code tool names in tools array or content
- Save files with `.claude/` path references for Copilot files
- Save files with verbose Claude Code tool syntax
- Save files with Claude Code rule references in embedded rules

---

## Example Copilot Agent File

```markdown
---
name: analysis
description: Systematically capture research findings and create curated outputs
tools: [read, edit, search, fetch_webpage]
---

# Research/Analysis Agent

Perform systematic investigation and capture findings.

---

# Embedded Rules

## Documentation-First Requirements (from copilot-instructions.md)

**MUST:**
- Use `fetch_webpage` to verify sources
- Use `read_file` to read documentation

**MUST NOT:**
- Use Claude Code tool names like `WebFetch` or `Read`

---

## Your Process

### Step 1: Read and Parse

**Execute:**
1. Use `read_file` to read the memory file
2. Extract all relevant information

**MUST:**
- Verify file exists before processing

### Step 2: Search and Verify

**Execute:**
1. Use `search` to find references
2. Use `fetch_webpage` to verify sources

### Step 3: Update Content

**Execute:**
1. Use `replace_string_in_file` to update facts

**MUST NOT:**
- Use `Edit` tool (Claude Code tool name)

---

## Related Files

See also:
- [verify-facts.prompt.md](../prompts/verify-facts.prompt.md)
- [documentation-first.md](../instructions/documentation-first.md)
```

---

## Compliance Verification

**Before saving ANY file in `src/github/agents/`:**

Ask yourself:
- [ ] File includes frontmatter with `name`, `description`, and `tools`?
- [ ] `tools` array lists all tools used in the content?
- [ ] `tools` array uses Copilot tool names (not Claude Code)?
- [ ] All tool references in content use Copilot tool names?
- [ ] All path references use `.github/` paths for Copilot files?
- [ ] Tool usage uses simplified Copilot syntax (no verbose parameters)?
- [ ] Embedded rules reference Copilot files (`copilot-instructions.md` or `.github/instructions/`)?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/github/agents/` files
