# Convert Copilot Agents to Claude Code Agents

**Purpose:** Instructions for converting GitHub Copilot agent files to Claude Code agent files.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Copilot to Claude Code, you MUST transform ALL platform-specific elements to match Claude Code conventions, not preserve Copilot patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Agent Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.github/agents/*.agent.md` → `.claude/agents/*.agent.md`
- Preserve filename exactly including `.agent.md` extension
- Create `.claude/agents/` directory if it does not exist

**MUST NOT:**
- Place Claude Code agent files in `.github/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

---

### 2. Frontmatter Conversion

**Copilot Agent Frontmatter:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
tools: [execute, read, edit, search, web, fetch_webpage]
---
```

**Claude Code Agent Frontmatter:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
---
```

**MUST:**
- Preserve `name` field exactly as it appears
- Preserve `description` field exactly as it appears
- Remove `tools` property completely (Claude Code does not use this in agent frontmatter)
- Remove `argument-hint` property if present (Claude Code uses different parameter passing)

**MUST NOT:**
- Include `tools` property in Claude Code agent frontmatter
- Include `argument-hint` property in Claude Code agent frontmatter
- Omit required `name` and `description` fields
- Add `paths` property (this belongs to rule files, not agents)

---

### 3. Tool Name Mapping in Content

**When converting tool references in agent content, map Copilot tools to Claude Code tools:**

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
- Replace ALL Copilot tool names with Claude Code equivalents throughout agent content
- Update tool usage examples to match Claude Code syntax
- Verify tool parameter names match Claude Code requirements
- Update all embedded instructions that reference specific tools

**MUST NOT:**
- Leave Copilot tool names in converted agent content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Claude Code

---

### 4. Tool Usage Syntax Conversion

#### Command Execution

**Copilot:**
```markdown
**Execute:**
1. Run command: `mkdir -p /path/to/directory`
2. Check result: Use the `execute` tool
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
Use the `Read` tool with `file_path` parameter set to absolute path: `/workspaces/project/.memory/facts.md`
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

#### File Creation/Writing

**Copilot:**
```markdown
Use `create_file` to write the new file
```

**Claude Code:**
```markdown
Use the `Write` tool with `file_path` and `content` parameters
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

#### Web Search

**Copilot:**
```markdown
Use the `web` tool to search for documentation
```

**Claude Code:**
```markdown
Use the `WebSearch` tool with query parameter to search for documentation
```

#### Web Fetching

**Copilot:**
```markdown
Use `fetch_webpage` to retrieve the documentation
```

**Claude Code:**
```markdown
Use the `WebFetch` tool with `url` and `prompt` parameters to retrieve and process the documentation
```

**MUST:**
- Convert ALL tool usage examples to Claude Code syntax
- Update parameter names to match Claude Code requirements (e.g., `file_path`, not `path`)
- Use absolute paths from workspace root for file operations
- Specify tool names explicitly in all instructions
- Include parameter names when describing tool usage

**MUST NOT:**
- Mix Copilot and Claude Code syntax in converted files
- Omit required parameters for Claude Code tools
- Use Copilot-specific parameter names
- Use relative paths without clarifying the base directory

---

### 5. Embedded Rules Conversion

**Copilot Pattern:**
```markdown
# Embedded Rules

## Documentation-First Response Requirements (from copilot-instructions.md)

**MUST:**
- Search for and reference official documentation sources
- Use the `fetch_webpage` tool to retrieve sources

[More embedded rule content...]
```

**Claude Code Pattern:**
```markdown
# Embedded Rules

Rules embedded directly in this agent for self-contained execution.

## Documentation-First Response Requirements (from .claude/rules/documentation-first.md)

**MUST:**
- Search for and reference official documentation sources
- Use the `WebFetch` tool to retrieve sources

[More embedded rule content...]
```

**MUST:**
- Add clarifying intro text: "Rules embedded directly in this agent for self-contained execution"
- Update embedded rule references to point to `.claude/rules/` files
- Replace all Copilot tool names with Claude Code equivalents within embedded rules
- Maintain embedded rule content structure exactly
- Preserve all MUST/MUST NOT requirements exactly
- Update section headers to use proper markdown levels (no bold-as-heading)

**MUST NOT:**
- Remove embedded rules during conversion
- Change rule content or requirements
- Reference `.github/instructions/` paths in converted files
- Leave Copilot tool names in embedded rule content

---

### 6. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.github/` to `.claude/`
- Update references to rules: `.github/instructions/` → `.claude/rules/`
- Update references to other agents: `.github/agents/` → `.claude/agents/`
- Update references to prompts: `.github/prompts/` → `.claude/prompts/`
- Update references in embedded rules
- Verify all cross-references resolve correctly after conversion

**Examples:**

| Copilot Path | Claude Code Path |
|---|---|
| `../instructions/ai-targeted-language.md` | `../.claude/rules/ai-targeted-language.md` |
| `.github/agents/analysis.agent.md` | `.claude/agents/analysis.agent.md` |
| `../prompts/verify-facts.prompt.md` | `../prompts/verify-facts.prompt.md` |
| `(from copilot-instructions.md)` | `(from .claude/rules/documentation-first.md)` |

**MUST NOT:**
- Leave `.github/` paths in converted Claude Code agent files
- Use broken or incorrect relative paths
- Reference files that do not exist in Claude Code structure
- Reference `copilot-instructions.md` (split into specific rule files)

---

### 7. Language and Style Preservation

**MUST:**
- Preserve AI-targeted language (second person "you", imperative mood)
- Maintain all MUST/MUST NOT sections exactly
- Keep consistent imperative commands: "MUST", "MUST NOT", "When you...", "Do not..."
- Preserve all examples, checklists, and verification sections
- Maintain UK English spelling (organised, colour, recognise, analyse)
- Preserve cultural neutrality and avoid hyperbole
- Keep all System Prompt Conflict Resolution sections if present

**MUST NOT:**
- Convert AI-targeted language to human-targeted documentation
- Remove or weaken MUST/MUST NOT requirements
- Change tone or style during conversion
- Introduce US English spellings (organized, color, recognize, analyze)
- Add culturally-specific idioms or metaphors

---

### 8. Workflow and Process Sections

**MUST:**
- Preserve all workflow descriptions exactly
- Maintain process step numbering and structure
- Keep all conditional logic ("When...", "If...", "After...")
- Preserve all lists and structured procedures
- Update tool references within workflows to Claude Code equivalents

**Example Workflow Conversion:**

**Copilot:**
```markdown
## Your Process

1. Use `read_file` to read the source
2. Use `search` to find references
3. Use `replace_string_in_file` to update content
```

**Claude Code:**
```markdown
## Your Process

1. Use `Read` tool with `file_path` parameter to read the source
2. Use `Grep` tool with pattern parameter to find references
3. Use `Edit` tool with `old_string` and `new_string` parameters to update content
```

---

### 9. Verification Checklist Format

**Both platforms use verification checklists. Preserve format exactly:**

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
- Update tool references in checklist items to Claude Code equivalents

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing
- Leave Copilot tool names in checklist items

---

## Conversion Process

### Step 1: Identify Source Agent File

**Execute:**
```bash
# List all Copilot agent files
find .github/agents -name "*.agent.md"
```

### Step 2: Create Target Directory

**Execute:**
```bash
mkdir -p .claude/agents
```

### Step 3: Convert Agent File

**For each agent file:**

1. **Read source file** from `.github/agents/{filename}.agent.md`
2. **Convert frontmatter:**
   - Preserve `name` field
   - Preserve `description` field
   - Remove `tools` property
   - Remove `argument-hint` property if present
3. **Convert tool references:**
   - Replace all Copilot tool names with Claude Code equivalents
   - Update syntax and parameter names throughout content
   - Update embedded rule content
4. **Update file path references:**
   - Change `.github/instructions/` to `.claude/rules/`
   - Change `.github/agents/` to `.claude/agents/`
   - Change `.github/prompts/` to `.claude/prompts/`
   - Update references in embedded rules
5. **Update embedded rules:**
   - Add intro text if not present
   - Update tool references within embedded content
   - Update source file references
6. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
7. **Verify workflow preservation:**
   - Confirm all workflows and processes preserved
   - Confirm all conditional logic maintained
   - Confirm tool references updated correctly
8. **Write target file** to `.claude/agents/{filename}.agent.md`

### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .github references in converted agent
grep "\.github" .claude/agents/{filename}.agent.md

# Check for any remaining Copilot tool names
grep -E "(read_file|create_file|replace_string_in_file|execute tool|fetch_webpage)" .claude/agents/{filename}.agent.md
```

**MUST:**
- Fix any remaining `.github/` references found
- Fix any remaining Copilot tool names found
- Verify all relative paths resolve correctly

---

## Conversion Example

### Source (Copilot): `.github/agents/analysis.agent.md`

```yaml
---
name: analysis
description: Systematically capture research findings
tools: [execute, read, edit, search, web, fetch_webpage]
---
```

```markdown
# Research/Analysis Agent

Perform systematic investigation and capture findings.

## Embedded Rules

## Documentation-First Requirements (from copilot-instructions.md)

**MUST:**
- Use `fetch_webpage` to verify sources
- Use `read_file` to read documentation

## Your Process

1. Use `read_file` to read the memory file
2. Use `search` to find references
3. Use `fetch_webpage` to verify sources
4. Use `replace_string_in_file` to update facts

See also: [../prompts/verify-facts.prompt.md](../prompts/verify-facts.prompt.md)
```

### Target (Claude Code): `.claude/agents/analysis.agent.md`

```yaml
---
name: analysis
description: Systematically capture research findings
---
```

```markdown
# Research/Analysis Agent

Perform systematic investigation and capture findings.

## Embedded Rules

Rules embedded directly in this agent for self-contained execution.

## Documentation-First Requirements (from .claude/rules/documentation-first.md)

**MUST:**
- Use `WebFetch` tool to verify sources
- Use `Read` tool to read documentation

## Your Process

1. Use `Read` tool with `file_path` parameter to read the memory file
2. Use `Grep` tool with pattern parameter to find references
3. Use `WebFetch` tool with `url` and `prompt` parameters to verify sources
4. Use `Edit` tool with `old_string` and `new_string` parameters to update facts

See also: [../prompts/verify-facts.prompt.md](../prompts/verify-facts.prompt.md)
```

**Changes Made:**
- Removed `tools` property from frontmatter
- Added embedded rules intro text
- Updated embedded rule source reference from `copilot-instructions.md` to `.claude/rules/documentation-first.md`
- Replaced `fetch_webpage` with `WebFetch` throughout
- Replaced `read_file` with `Read` and specified parameter
- Replaced `search` with `Grep` and specified parameter
- Replaced `replace_string_in_file` with `Edit` and specified parameters
- Relative path to prompt file unchanged (same structure in both platforms)

---

## Post-Conversion Validation

**MUST:**
- Verify converted file exists in `.claude/agents/` directory
- Check that frontmatter contains only `name` and `description` fields
- Confirm no Copilot tool names remain anywhere in content
- Confirm all path references resolve correctly
- Validate AI-targeted language compliance
- Test that embedded rules are intact with updated tool references
- Verify all workflows and processes preserved with updated tool names

**MUST NOT:**
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings in embedded rules
- Leave Copilot-specific properties in frontmatter

---

## Compliance Verification

**Before completing ANY agent conversion:**

Ask yourself:
- [ ] File moved from `.github/agents/` to `.claude/agents/`?
- [ ] Frontmatter contains only `name` and `description` fields?
- [ ] `tools` property removed from frontmatter?
- [ ] `argument-hint` property removed from frontmatter (if present)?
- [ ] All Copilot tool names replaced with Claude Code equivalents?
- [ ] Tool usage syntax updated with parameter names?
- [ ] All path references updated from `.github/` to `.claude/`?
- [ ] Embedded rules updated with new tool names and paths?
- [ ] Embedded rules have intro text?
- [ ] All workflows and processes preserved with updated tools?
- [ ] AI-targeted language maintained (second person, imperative mood)?
- [ ] All MUST/MUST NOT sections preserved exactly?
- [ ] All verification checklists preserved with updated tool names?
- [ ] UK English spelling maintained?
- [ ] All cross-references validated and working?

**If ANY answer is "No":**
- Complete the missing conversion step
- Verify the specific file again
- These are mandatory standards
