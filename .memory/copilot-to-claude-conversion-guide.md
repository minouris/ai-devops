# Copilot to Claude Code Conversion Guide

**Purpose:** Instructions for converting GitHub Copilot prompts and agents to Claude Code format.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Copilot to Claude Code, you MUST transform ALL platform-specific elements to match Claude Code conventions, not preserve Copilot patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.github/agents/*.agent.md` → `.claude/agents/*.agent.md`
- Convert `.github/prompts/*.prompt.md` → `.claude/prompts/*.prompt.md`
- Convert `.github/instructions/*.md` → `.claude/rules/*.md`
- Preserve filename conventions (`.agent.md`, `.prompt.md` extensions)
- Create target directories if they do not exist

**MUST NOT:**
- Place Claude Code files in `.github/` directory
- Change file extensions during conversion
- Merge multiple source files into one target file without explicit instruction

---

### 2. Frontmatter Conversion

**Copilot Frontmatter Properties:**
```yaml
---
name: agent-name
description: "Brief description"
tools: [execute, read, edit, search, web, fetch_webpage]
argument-hint: "param=value"
---
```

**Claude Code Frontmatter Properties:**
```yaml
---
name: agent-name
description: "Brief description"
# Note: Claude Code does not use 'tools' property in frontmatter
# Tools are referenced implicitly through task descriptions
---
```

**MUST:**
- Preserve `name` field exactly
- Preserve `description` field exactly
- Remove `tools` property (Claude Code does not use this in frontmatter)
- Remove `argument-hint` property (Claude Code uses different parameter passing)
- Add `paths` property if this is a rule file that should apply to specific files

**MUST NOT:**
- Copy Copilot frontmatter properties blindly
- Include tool lists in Claude Code frontmatter
- Omit required `name` and `description` fields

---

### 3. Tool Name Mapping

**When converting tool references in content, map Copilot tools to Claude Code tools:**

| Copilot Tool | Claude Code Tool | Notes |
|---|---|---|
| `execute` | `Bash` | Command execution |
| `read_file` | `Read` | File reading |
| `edit` / `replace_string_in_file` | `Edit` | File editing with exact string replacement |
| `create_file` | `Write` | File creation/writing |
| `search` | `Grep` or `Glob` | Use `Grep` for content search, `Glob` for file pattern matching |
| `web` | `WebSearch` | Web search |
| `fetch_webpage` | `WebFetch` | Fetch webpage content |
| `ms-vscode.vscode-websearchforcopilot/websearch` | `WebSearch` | VSCode web search extension |

**MUST:**
- Replace ALL Copilot tool names with Claude Code equivalents in content
- Update tool usage examples to match Claude Code syntax
- Verify tool parameter names match Claude Code requirements
- Update any embedded instructions that reference specific tools

**MUST NOT:**
- Leave Copilot tool names in converted content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Claude Code

---

### 4. Tool Usage Syntax Conversion

#### Command Execution

**Copilot:**
```markdown
**Execute:**
1. Run command: `mkdir -p /path/to/directory`
2. Check result: `ls -la /path/to/`
```

**Claude Code:**
```markdown
**Execute:**
1. Create directory: Use `Bash` tool with command `mkdir -p /path/to/directory`
2. Verify creation: Use `Bash` tool with command `ls -la /path/to/`
```

#### File Reading

**Copilot:**
```markdown
Use the `read_file` tool to read `.memory/facts.md`
```

**Claude Code:**
```markdown
Use the `Read` tool with `file_path` parameter: `/workspaces/project/.memory/facts.md`
```

#### File Editing

**Copilot:**
```markdown
Use `replace_string_in_file` to update the content
```

**Claude Code:**
```markdown
Use the `Edit` tool with `old_string` and `new_string` parameters for exact string replacement
```

#### Search Operations

**Copilot:**
```markdown
Use `search` to find references to "function_name"
```

**Claude Code:**
```markdown
Use `Grep` tool with pattern "function_name" to search file contents, or use `Glob` tool with pattern "**/*function_name*" to search filenames
```

**MUST:**
- Convert ALL tool usage examples to Claude Code syntax
- Update parameter names to match Claude Code requirements
- Use absolute paths for file operations in Claude Code
- Specify tool names explicitly in instructions

**MUST NOT:**
- Mix Copilot and Claude Code syntax in converted files
- Omit required parameters for Claude Code tools
- Use Copilot-specific parameter names

---

### 5. Rule Embedding Conversion

**Copilot Pattern:**
```markdown
## Embedded Rules

## Documentation-First Response Requirements (from copilot-instructions.md)

[Content from copilot-instructions.md]
```

**Claude Code Pattern:**
```markdown
# Embedded Rules

Rules embedded directly in this agent for self-contained execution.

[Content from .claude/rules/*.md files]
```

**MUST:**
- Update embedded rule references to point to `.claude/rules/*.md` files
- Maintain embedded rule content structure
- Preserve all MUST/MUST NOT requirements exactly
- Update section headers to use proper markdown levels (no bold-as-heading)

**MUST NOT:**
- Remove embedded rules during conversion
- Change rule content or requirements
- Reference `.github/instructions/` paths in converted files

---

### 6. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.github/` to `.claude/`
- Update relative paths to match new directory structure
- Verify all cross-references resolve correctly after conversion
- Use absolute paths from workspace root for Claude Code

**Examples:**

| Copilot Path | Claude Code Path |
|---|---|
| `../instructions/ai-targeted-language.md` | `../.claude/rules/ai-targeted-language.md` |
| `.github/agents/analysis.agent.md` | `.claude/agents/analysis.agent.md` |
| `../prompts/verify-facts.prompt.md` | `../.claude/prompts/verify-facts.prompt.md` |

**MUST NOT:**
- Leave `.github/` paths in converted Claude Code files
- Use broken or incorrect relative paths
- Reference files that do not exist in Claude Code structure

---

### 7. Frontmatter Paths Property (Rules Only)

**For rule files (`.md` in `.claude/rules/`)**, add `paths` property to specify which files the rule applies to:

**Example:**
```yaml
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
  - "**/*.prompt.md"
---
```

**MUST:**
- Add `paths` property to rule files when converting from `.github/instructions/`
- Use glob patterns to specify file applicability
- Include all relevant file patterns

**MUST NOT:**
- Add `paths` property to agent or prompt files
- Use overly broad patterns that apply rules inappropriately

---

### 8. Language and Style Preservation

**MUST:**
- Preserve AI-targeted language (second person "you", imperative mood)
- Maintain all MUST/MUST NOT sections exactly
- Keep consistent imperative commands: "MUST", "MUST NOT", "When you...", "Do not..."
- Preserve all examples, checklists, and verification sections
- Maintain UK English spelling
- Preserve cultural neutrality and avoid hyperbole

**MUST NOT:**
- Convert AI-targeted language to human-targeted documentation
- Remove or weaken MUST/MUST NOT requirements
- Change tone or style during conversion
- Introduce US English spellings or culturally-specific idioms

---

### 9. Verification Checklist Format

**Both platforms use verification checklists. Preserve format:**

```markdown
**Before completing [task]:**

Ask yourself:
- [ ] Criterion 1?
- [ ] Criterion 2?
- [ ] Criterion 3?

**If ANY answer is "No":**
- Corrective action 1
- Corrective action 2
- These are mandatory standards
```

**MUST:**
- Preserve all checklist items exactly
- Maintain "If ANY answer is 'No'" consequence section
- Keep checkbox format: `- [ ]`

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing

---

### 10. Example Conversion Process

#### Step 1: Identify Source Files

**Execute:**
```bash
# List all Copilot agents, prompts, and instructions
find .github -name "*.agent.md" -o -name "*.prompt.md" -o -name "*.md"
```

#### Step 2: Create Target Directory Structure

**Execute:**
```bash
mkdir -p .claude/agents
mkdir -p .claude/prompts
mkdir -p .claude/rules
```

#### Step 3: Convert Individual File

**For each source file:**

1. **Read source file**
2. **Identify file type** (agent, prompt, or instruction/rule)
3. **Determine target path:**
   - Agent: `.claude/agents/{filename}.agent.md`
   - Prompt: `.claude/prompts/{filename}.prompt.md`
   - Instruction: `.claude/rules/{filename}.md`
4. **Convert frontmatter:**
   - Remove `tools` property
   - Remove `argument-hint` property
   - Add `paths` property if rule file
5. **Convert tool references:**
   - Replace Copilot tool names with Claude Code equivalents
   - Update syntax and parameter names
6. **Update file path references:**
   - Change `.github/` to `.claude/` throughout content
7. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
8. **Write target file** with converted content

#### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .github references
grep -r "\.github" .claude/
```

**MUST:**
- Fix any remaining `.github/` references found
- Verify all relative paths resolve correctly
- Test that embedded rule references are valid

---

## Conversion Example

### Source (Copilot): `.github/prompts/verify-facts.prompt.md`

```yaml
---
description: "Verify facts in memory files"
name: "verify-facts"
argument-hint: "memoryFilePath=.memory/facts.md"
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file"]
---

# Verify Facts

Use `read_file` to read the memory file.

**Execute:**
1. Read file with `read_file` tool
2. Use `fetch_webpage` to verify sources
3. Use `replace_string_in_file` to update facts

See also: [../instructions/documentation-first.md](../instructions/documentation-first.md)
```

### Target (Claude Code): `.claude/prompts/verify-facts.prompt.md`

```yaml
---
description: "Verify facts in memory files"
name: "verify-facts"
---

# Verify Facts

Use the `Read` tool to read the memory file at the specified path.

**Execute:**
1. Use `Read` tool with `file_path` parameter to read the file
2. Use `WebFetch` tool to verify sources by fetching source URLs
3. Use `Edit` tool with `old_string` and `new_string` parameters to update facts

See also: [../.claude/rules/documentation-first.md](../.claude/rules/documentation-first.md)
```

**Changes Made:**
- Removed `tools` property from frontmatter
- Removed `argument-hint` property from frontmatter
- Replaced `read_file` with `Read` tool and specified parameter
- Replaced `fetch_webpage` with `WebFetch` tool
- Replaced `replace_string_in_file` with `Edit` tool and specified parameters
- Updated relative path from `../instructions/` to `../.claude/rules/`

---

## Post-Conversion Validation

**MUST:**
- Verify all converted files exist in correct `.claude/` directories
- Check that no Copilot tool names remain in content
- Confirm all path references resolve correctly
- Validate frontmatter structure matches Claude Code requirements
- Test that embedded rules are intact
- Verify AI-targeted language compliance

**MUST NOT:**
- Leave source files in `.github/` if they have been fully converted (unless maintaining dual-platform support)
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings

---

## Compliance Verification

**Before completing ANY conversion:**

Ask yourself:
- [ ] All files moved from `.github/` to `.claude/` directory structure?
- [ ] Frontmatter properties converted (removed `tools`, `argument-hint`)?
- [ ] All Copilot tool names replaced with Claude Code equivalents?
- [ ] Tool usage syntax updated to Claude Code format?
- [ ] All path references updated from `.github/` to `.claude/`?
- [ ] Embedded rules preserved with updated references?
- [ ] AI-targeted language maintained (second person, imperative mood)?
- [ ] All cross-references validated and working?
- [ ] Verification checklists preserved exactly?
- [ ] UK English spelling and cultural neutrality maintained?

**If ANY answer is "No":**
- Complete the missing conversion step
- Verify the specific file again
- These are mandatory standards
