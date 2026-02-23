# Convert Claude Code Agents to Copilot Agents

**Purpose:** Instructions for converting Claude Code agent files to GitHub Copilot agent files.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Claude Code to Copilot, you MUST transform ALL platform-specific elements to match Copilot conventions, not preserve Claude Code patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Agent Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.claude/agents/*.agent.md` → `.github/agents/*.agent.md`
- Preserve filename exactly including `.agent.md` extension
- Create `.github/agents/` directory if it does not exist

**MUST NOT:**
- Place Copilot agent files in `.claude/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

---

### 2. Frontmatter Conversion

**Claude Code Agent Frontmatter:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
---
```

**Copilot Agent Frontmatter:**
```yaml
---
name: agent-name
description: Brief description of agent purpose
tools: [execute, read, edit, search, web, fetch_webpage]
---
```

**MUST:**
- Preserve `name` field exactly as it appears
- Preserve `description` field exactly as it appears
- Add `tools` property listing all tools referenced in the agent content
- Scan agent content to identify which tools are used

**MUST NOT:**
- Omit `tools` property in Copilot agent frontmatter
- Include incorrect tools in the tools list
- Add `paths` property (this belongs to instruction files, not agents)

**Determining Tools List:**

Scan the agent content for tool references and include corresponding Copilot tool names:
- If content mentions file reading → include `read`
- If content mentions command execution → include `execute`
- If content mentions file editing → include `edit`
- If content mentions file creation → include `create_file`
- If content mentions web search → include `web` or `web_search`
- If content mentions fetching webpages → include `fetch_webpage`
- If content mentions searching content → include `search`

---

### 3. Tool Name Mapping in Content

**When converting tool references in agent content, map Claude Code tools to Copilot tools:**

| Claude Code Tool | Copilot Tool | Notes |
|---|---|---|
| `Bash` | `execute` | Command execution |
| `Read` | `read_file` | File reading |
| `Edit` | `edit` or `replace_string_in_file` | File editing with exact string replacement |
| `Write` | `create_file` | File creation/writing |
| `Grep` | `search` | Content search |
| `Glob` | `search` | File pattern matching |
| `WebSearch` | `web` or `web_search` | Web search |
| `WebFetch` | `fetch_webpage` | Fetch webpage content |

**MUST:**
- Replace ALL Claude Code tool names with Copilot equivalents throughout agent content
- Update tool usage examples to match Copilot syntax
- Simplify parameter descriptions (remove explicit parameter names where appropriate)
- Update all embedded instructions that reference specific tools

**MUST NOT:**
- Leave Claude Code tool names in converted agent content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Copilot

---

### 4. Tool Usage Syntax Conversion

#### Command Execution

**Claude Code:**
```markdown
**Execute:**
1. Create directory: Use `Bash` tool with command `mkdir -p /path/to/directory`
2. Verify creation: Use `Bash` tool with command `ls -la /path/to/`
```

**Copilot:**
```markdown
**Execute:**
1. Run command: `mkdir -p /path/to/directory`
2. Check result: Use the `execute` tool with `ls -la /path/to/`
```

#### File Reading

**Claude Code:**
```markdown
Use the `Read` tool with `file_path` parameter set to absolute path: `/workspaces/project/.memory/facts.md`
```

**Copilot:**
```markdown
Use the `read_file` tool to read `.memory/facts.md`
```

#### File Editing

**Claude Code:**
```markdown
Use the `Edit` tool with `old_string` and `new_string` parameters for exact string replacement
```

**Copilot:**
```markdown
Use `replace_string_in_file` to update the content
```

#### File Creation/Writing

**Claude Code:**
```markdown
Use the `Write` tool with `file_path` and `content` parameters
```

**Copilot:**
```markdown
Use `create_file` to write the new file
```

#### Search Operations

**Claude Code:**
```markdown
Use `Grep` tool with pattern "function_name" to search file contents, or use `Glob` tool with pattern "**/*function_name*" to search filenames
```

**Copilot:**
```markdown
Use `search` to find references to "function_name"
```

#### Web Search

**Claude Code:**
```markdown
Use the `WebSearch` tool with query parameter to search for documentation
```

**Copilot:**
```markdown
Use the `web` tool to search for documentation
```

#### Web Fetching

**Claude Code:**
```markdown
Use the `WebFetch` tool with `url` and `prompt` parameters to retrieve and process the documentation
```

**Copilot:**
```markdown
Use `fetch_webpage` to retrieve the documentation
```

**MUST:**
- Convert ALL tool usage examples to Copilot syntax
- Simplify parameter references (Copilot uses simpler syntax)
- Remove explicit parameter names like `file_path`, `old_string`, `new_string`
- Specify tool names explicitly in all instructions

**MUST NOT:**
- Mix Claude Code and Copilot syntax in converted files
- Use Claude Code-specific parameter names
- Over-specify parameters where Copilot uses simpler syntax

---

### 5. Embedded Rules Conversion

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

**Copilot Pattern:**
```markdown
# Embedded Rules

## Documentation-First Response Requirements (from copilot-instructions.md)

**MUST:**
- Search for and reference official documentation sources
- Use `fetch_webpage` to retrieve sources

[More embedded rule content...]
```

**MUST:**
- Remove "Rules embedded directly..." intro text (can be simplified for Copilot)
- Update embedded rule references to point to `copilot-instructions.md` or `.github/instructions/` files
- Replace all Claude Code tool names with Copilot equivalents within embedded rules
- Maintain embedded rule content structure exactly
- Preserve all MUST/MUST NOT requirements exactly

**MUST NOT:**
- Remove embedded rules during conversion
- Change rule content or requirements
- Reference `.claude/rules/` paths in converted files
- Leave Claude Code tool names in embedded rule content

---

### 6. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.claude/` to `.github/`
- Update references to rules: `.claude/rules/` → `.github/instructions/`
- Update references to other agents: `.claude/agents/` → `.github/agents/`
- Update references to prompts: `.claude/prompts/` → `.github/prompts/`
- Update references in embedded rules
- Reference `copilot-instructions.md` where appropriate for embedded rules
- Verify all cross-references resolve correctly after conversion

**Examples:**

| Claude Code Path | Copilot Path |
|---|---|
| `../.claude/rules/ai-targeted-language.md` | `../instructions/ai-targeted-language.md` |
| `.claude/agents/analysis.agent.md` | `.github/agents/analysis.agent.md` |
| `../prompts/verify-facts.prompt.md` | `../prompts/verify-facts.prompt.md` |
| `(from .claude/rules/documentation-first.md)` | `(from copilot-instructions.md)` |

**MUST NOT:**
- Leave `.claude/` paths in converted Copilot agent files
- Use broken or incorrect relative paths
- Reference files that do not exist in Copilot structure

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
- Update tool references within workflows to Copilot equivalents

**Example Workflow Conversion:**

**Claude Code:**
```markdown
## Your Process

1. Use `Read` tool with `file_path` parameter to read the source
2. Use `Grep` tool with pattern parameter to find references
3. Use `Edit` tool with `old_string` and `new_string` parameters to update content
```

**Copilot:**
```markdown
## Your Process

1. Use `read_file` to read the source
2. Use `search` to find references
3. Use `replace_string_in_file` to update content
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
- Update tool references in checklist items to Copilot equivalents

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing
- Leave Claude Code tool names in checklist items

---

## Conversion Process

### Step 1: Identify Source Agent File

**Execute:**
```bash
# List all Claude Code agent files
find .claude/agents -name "*.agent.md"
```

### Step 2: Create Target Directory

**Execute:**
```bash
mkdir -p .github/agents
```

### Step 3: Convert Agent File

**For each agent file:**

1. **Read source file** from `.claude/agents/{filename}.agent.md`
2. **Scan content for tool usage** to determine tools list
3. **Convert frontmatter:**
   - Preserve `name` field
   - Preserve `description` field
   - Add `tools` property with list of Copilot tools used
4. **Convert tool references:**
   - Replace all Claude Code tool names with Copilot equivalents
   - Simplify syntax throughout content
   - Update embedded rule content
5. **Update file path references:**
   - Change `.claude/rules/` to `.github/instructions/`
   - Change `.claude/agents/` to `.github/agents/`
   - Change `.claude/prompts/` to `.github/prompts/`
   - Update references in embedded rules to `copilot-instructions.md` where appropriate
6. **Update embedded rules:**
   - Simplify intro text if present
   - Update tool references within embedded content
   - Update source file references
7. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
8. **Verify workflow preservation:**
   - Confirm all workflows and processes preserved
   - Confirm all conditional logic maintained
   - Confirm tool references updated correctly
9. **Write target file** to `.github/agents/{filename}.agent.md`

### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .claude references in converted agent
grep "\.claude" .github/agents/{filename}.agent.md

# Check for any remaining Claude Code tool names
grep -E "(Bash|Read tool|Edit tool|Write tool|Grep|Glob|WebSearch|WebFetch)" .github/agents/{filename}.agent.md
```

**MUST:**
- Fix any remaining `.claude/` references found
- Fix any remaining Claude Code tool names found
- Verify all relative paths resolve correctly

---

## Conversion Example

### Source (Claude Code): `.claude/agents/analysis.agent.md`

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

### Target (Copilot): `.github/agents/analysis.agent.md`

```yaml
---
name: analysis
description: Systematically capture research findings
tools: [read, edit, search, fetch_webpage]
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

**Changes Made:**
- Added `tools` property to frontmatter with list: `[read, edit, search, fetch_webpage]`
- Simplified embedded rules intro text
- Updated embedded rule source reference from `.claude/rules/documentation-first.md` to `copilot-instructions.md`
- Replaced `WebFetch` with `fetch_webpage` throughout
- Replaced `Read` with `read_file` and removed parameter specification
- Replaced `Grep` with `search` and removed parameter specification
- Replaced `Edit` with `replace_string_in_file` and removed parameter specification
- Relative path to prompt file unchanged (same structure in both platforms)

---

## Post-Conversion Validation

**MUST:**
- Verify converted file exists in `.github/agents/` directory
- Check that frontmatter contains `name`, `description`, and `tools` fields
- Confirm `tools` list is accurate and complete
- Confirm no Claude Code tool names remain anywhere in content
- Confirm all path references resolve correctly
- Validate AI-targeted language compliance
- Test that embedded rules are intact with updated tool references
- Verify all workflows and processes preserved with updated tool names

**MUST NOT:**
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings in embedded rules
- Include incorrect tools in the tools list

---

## Compliance Verification

**Before completing ANY agent conversion:**

Ask yourself:
- [ ] File moved from `.claude/agents/` to `.github/agents/`?
- [ ] Frontmatter contains `name`, `description`, and `tools` fields?
- [ ] `tools` list accurately reflects tools used in content?
- [ ] All Claude Code tool names replaced with Copilot equivalents?
- [ ] Tool usage syntax simplified to Copilot format?
- [ ] All path references updated from `.claude/` to `.github/`?
- [ ] Embedded rules updated with new tool names and paths?
- [ ] Embedded rules reference `copilot-instructions.md` where appropriate?
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
