# Convert Copilot Prompts to Claude Code Prompts

**Purpose:** Instructions for converting GitHub Copilot prompt files to Claude Code prompt files.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Copilot to Claude Code, you MUST transform ALL platform-specific elements to match Claude Code conventions, not preserve Copilot patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Prompt Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.github/prompts/*.prompt.md` → `.claude/prompts/*.prompt.md`
- Preserve filename exactly including `.prompt.md` extension
- Create `.claude/prompts/` directory if it does not exist

**MUST NOT:**
- Place Claude Code prompt files in `.github/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

---

### 2. Frontmatter Conversion

**Copilot Prompt Frontmatter:**
```yaml
---
description: "Brief description of what this prompt does"
name: "prompt-name"
argument-hint: "param1=value param2=value"
tools: ["execute", "read_file", "edit", "fetch_webpage", "web_search"]
---
```

**Claude Code Prompt Frontmatter:**
```yaml
---
description: "Brief description of what this prompt does"
name: "prompt-name"
---
```

**MUST:**
- Preserve `description` field exactly as it appears
- Preserve `name` field exactly as it appears
- Remove `argument-hint` property completely (Claude Code uses different parameter passing mechanism)
- Remove `tools` property completely (Claude Code does not use this in prompt frontmatter)

**MUST NOT:**
- Include `tools` property in Claude Code prompt frontmatter
- Include `argument-hint` property in Claude Code prompt frontmatter
- Omit required `name` and `description` fields
- Add `paths` property (this belongs to rule files, not prompts)

---

### 3. Parameter Passing Conversion

**Copilot uses `argument-hint` and `${input:paramName}` syntax:**
```yaml
---
argument-hint: "memoryFilePath=.memory/facts.md"
---
```

```markdown
Read the file at ${input:memoryFilePath}
```

**Claude Code prompts receive parameters differently:**
- Parameters are passed through the task invocation context
- Reference parameters directly or describe expected inputs in the prompt body
- No special `${input:}` syntax

**MUST:**
- Remove `argument-hint` property from frontmatter
- Document expected parameters in the prompt description or body
- Convert `${input:paramName}` references to clear parameter descriptions
- Specify parameter format and expectations explicitly

**MUST NOT:**
- Leave `${input:}` syntax in Claude Code prompts
- Leave `argument-hint` property in frontmatter
- Assume Claude Code will use identical parameter passing

**Conversion Example:**

**Copilot:**
```markdown
Read the file at ${input:memoryFilePath}
```

**Claude Code:**
```markdown
Read the specified memory file (path will be provided as input parameter)
```

Or more explicitly:
```markdown
**Input Parameter:**
- `memoryFilePath` - Path to the memory file to process (e.g., `.memory/facts.md`)

Read the memory file at the provided path.
```

---

### 4. Tool Name Mapping in Content

**When converting tool references in prompt content, map Copilot tools to Claude Code tools:**

| Copilot Tool | Claude Code Tool | Notes |
|---|---|---|
| `execute` | `Bash` | Command execution |
| `read_file` | `Read` | File reading |
| `edit` / `replace_string_in_file` | `Edit` | File editing with exact string replacement |
| `create_file` | `Write` | File creation/writing |
| `search` | `Grep` or `Glob` | Use `Grep` for content search, `Glob` for file pattern matching |
| `web` / `web_search` | `WebSearch` | Web search |
| `fetch_webpage` | `WebFetch` | Fetch webpage content |

**MUST:**
- Replace ALL Copilot tool names with Claude Code equivalents throughout prompt content
- Update tool usage examples to match Claude Code syntax
- Verify tool parameter names match Claude Code requirements
- Update all instructions that reference specific tools

**MUST NOT:**
- Leave Copilot tool names in converted prompt content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Claude Code

---

### 5. Tool Usage Syntax Conversion

#### Command Execution

**Copilot:**
```markdown
**Execute:**
```
1. Run command: `mkdir -p /path/to/directory`
2. Use the `execute` tool to verify
```

**Claude Code:**
```markdown
**Execute:**
```
1. Create directory: Use `Bash` tool with command `mkdir -p /path/to/directory`
2. Verify creation: Use `Bash` tool with command `ls -la /path/to/`
```

#### File Reading

**Copilot:**
```markdown
1. Use `read_file` to read the memory file
```

**Claude Code:**
```markdown
1. Use `Read` tool with `file_path` parameter to read the memory file
```

#### File Editing

**Copilot:**
```markdown
3. Use `replace_string_in_file` to update facts
```

**Claude Code:**
```markdown
3. Use `Edit` tool with `old_string` and `new_string` parameters to update facts
```

#### File Creation/Writing

**Copilot:**
```markdown
2. Use `create_file` to write the archive file
```

**Claude Code:**
```markdown
2. Use `Write` tool with `file_path` and `content` parameters to create the archive file
```

#### Search Operations

**Copilot:**
```markdown
Use `search` to find all factual claims
```

**Claude Code:**
```markdown
Use `Grep` tool with pattern to search file contents for factual claims
```

#### Web Search

**Copilot:**
```markdown
3. Use `web_search` to find current authoritative source
```

**Claude Code:**
```markdown
3. Use `WebSearch` tool with query parameter to find current authoritative source
```

#### Web Fetching

**Copilot:**
```markdown
2. Use `fetch_webpage` to retrieve source content
```

**Claude Code:**
```markdown
2. Use `WebFetch` tool with `url` and `prompt` parameters to retrieve source content
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

---

### 6. Input/Output Format Sections

**Copilot prompts often include Input Format and Output Format sections with variable references:**

**Copilot:**
```markdown
## Input Format

**Expected input:**
```
memoryFilePath=.memory/facts.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file
```

**Claude Code:**
```markdown
## Input Parameters

**Expected parameters:**
- `memoryFilePath` - Path to the memory file to process (e.g., `.memory/facts.md`)

**Example:**
```
Process memory file: .memory/facts.md
```
```

**MUST:**
- Convert "Input Format" sections to "Input Parameters" sections
- Remove `${input:}` syntax from variable descriptions
- Describe parameters clearly without special syntax
- Preserve parameter descriptions and examples

**MUST NOT:**
- Leave `${input:}` references in converted prompts
- Remove parameter documentation
- Change parameter names without good reason

---

### 7. Execution Steps Conversion

**Prompts often contain detailed execution steps. Convert tool references:**

**Copilot:**
```markdown
### Step 1: Read and Parse Memory File

**Execute:**
```
1. Read file at ${input:memoryFilePath}
2. Extract all factual claims
```

**MUST:**
- Extract EVERY factual claim
- Use `read_file` tool
```

**Claude Code:**
```markdown
### Step 1: Read and Parse Memory File

**Execute:**
```
1. Use `Read` tool to read the memory file at the specified path
2. Extract all factual claims from the file content
```

**MUST:**
- Extract EVERY factual claim
- Use `Read` tool with `file_path` parameter
```

**MUST:**
- Update all tool references in execution steps
- Preserve step structure and numbering
- Maintain all MUST/MUST NOT requirements
- Update variable references to parameter descriptions

**MUST NOT:**
- Remove or alter execution steps beyond tool name updates
- Change the logic or sequence of steps
- Remove requirements or constraints

---

### 8. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.github/` to `.claude/`
- Update references to rules: `.github/instructions/` → `.claude/rules/`
- Update references to agents: `.github/agents/` → `.claude/agents/`
- Update references to other prompts: `.github/prompts/` → `.claude/prompts/`
- Verify all cross-references resolve correctly after conversion

**Examples:**

| Copilot Path | Claude Code Path |
|---|---|
| `../instructions/ai-targeted-language.md` | `../.claude/rules/ai-targeted-language.md` |
| `.github/prompts/consolidate-session.prompt.md` | `.claude/prompts/consolidate-session.prompt.md` |
| `[verify-memory-facts](../prompts/verify-memory-facts.prompt.md)` | `[verify-memory-facts](../prompts/verify-memory-facts.prompt.md)` |

**MUST NOT:**
- Leave `.github/` paths in converted Claude Code prompt files
- Use broken or incorrect relative paths
- Reference files that do not exist in Claude Code structure

---

### 9. Language and Style Preservation

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

### 10. Verification Checklist Format

**Both platforms use verification checklists. Preserve format exactly:**

```markdown
**Before completing [task]:**

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
- Update tool references in checklist items to Claude Code equivalents
- Maintain "If ANY answer is 'No'" consequence section
- Keep checkbox format: `- [ ]`

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing
- Leave Copilot tool names in checklist items

---

## Conversion Process

### Step 1: Identify Source Prompt File

**Execute:**
```bash
# List all Copilot prompt files
find .github/prompts -name "*.prompt.md"
```

### Step 2: Create Target Directory

**Execute:**
```bash
mkdir -p .claude/prompts
```

### Step 3: Convert Prompt File

**For each prompt file:**

1. **Read source file** from `.github/prompts/{filename}.prompt.md`
2. **Convert frontmatter:**
   - Preserve `name` field
   - Preserve `description` field
   - Remove `tools` property
   - Remove `argument-hint` property
3. **Document parameters:**
   - Convert Input Format section to Input Parameters section
   - Remove `${input:}` syntax from parameter references
   - Document expected parameters clearly
4. **Convert tool references:**
   - Replace all Copilot tool names with Claude Code equivalents
   - Update syntax and parameter names throughout all sections
   - Update execution steps with new tool names
5. **Update file path references:**
   - Change `.github/instructions/` to `.claude/rules/`
   - Change `.github/agents/` to `.claude/agents/`
   - Change `.github/prompts/` to `.claude/prompts/`
6. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
7. **Verify execution steps:**
   - Confirm all steps preserved with updated tool names
   - Confirm all MUST/MUST NOT requirements maintained
   - Confirm verification checklists updated
8. **Write target file** to `.claude/prompts/{filename}.prompt.md`

### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .github references in converted prompt
grep "\.github" .claude/prompts/{filename}.prompt.md

# Check for any remaining Copilot tool names
grep -E "(read_file|create_file|replace_string_in_file|execute|fetch_webpage|web_search)" .claude/prompts/{filename}.prompt.md

# Check for any remaining ${input:} syntax
grep '\${input:' .claude/prompts/{filename}.prompt.md
```

**MUST:**
- Fix any remaining `.github/` references found
- Fix any remaining Copilot tool names found
- Fix any remaining `${input:}` syntax found
- Verify all relative paths resolve correctly

---

## Conversion Example

### Source (Copilot): `.github/prompts/verify-facts.prompt.md`

```yaml
---
description: "Verify facts in memory files by checking sources"
name: "verify-facts"
argument-hint: "memoryFilePath=.memory/facts.md"
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]
---
```

```markdown
# Verify Memory File Facts

## Input Format

**Expected input:**
```
memoryFilePath=.memory/facts.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file

## Execution Instructions

### Step 1: Read Memory File

**Execute:**
```
1. Read file at ${input:memoryFilePath}
2. Extract all factual claims
```

**MUST:**
- Use `read_file` tool
- Extract EVERY fact

### Step 2: Verify Each Fact

**Execute:**
```
1. Use `fetch_webpage` to retrieve source content
2. Use `web_search` to find current source if needed
```

### Step 3: Update File

**Execute:**
```
1. Use `replace_string_in_file` to update verified facts
2. Use `create_file` to create archive file
```

See [ai-targeted-language.md](../instructions/ai-targeted-language.md) for style requirements.
```

### Target (Claude Code): `.claude/prompts/verify-facts.prompt.md`

```yaml
---
description: "Verify facts in memory files by checking sources"
name: "verify-facts"
---
```

```markdown
# Verify Memory File Facts

## Input Parameters

**Expected parameters:**
- `memoryFilePath` - Path to the memory file to verify (e.g., `.memory/facts.md`)

**Example:**
```
Process memory file at path: .memory/facts.md
```

## Execution Instructions

### Step 1: Read Memory File

**Execute:**
```
1. Use `Read` tool with `file_path` parameter to read the specified memory file
2. Extract all factual claims from the file content
```

**MUST:**
- Use `Read` tool with absolute file path
- Extract EVERY fact

### Step 2: Verify Each Fact

**Execute:**
```
1. Use `WebFetch` tool with `url` and `prompt` parameters to retrieve source content
2. Use `WebSearch` tool with query parameter to find current source if URL unavailable
```

### Step 3: Update File

**Execute:**
```
1. Use `Edit` tool with `old_string` and `new_string` parameters to update verified facts
2. Use `Write` tool with `file_path` and `content` parameters to create archive file
```

See [ai-targeted-language.md](../.claude/rules/ai-targeted-language.md) for style requirements.
```

**Changes Made:**
- Removed `tools` property from frontmatter
- Removed `argument-hint` property from frontmatter
- Converted "Input Format" to "Input Parameters"
- Removed `${input:}` syntax from parameter references
- Replaced `read_file` with `Read` and specified parameter
- Replaced `fetch_webpage` with `WebFetch` and specified parameters
- Replaced `web_search` with `WebSearch` and specified parameter
- Replaced `replace_string_in_file` with `Edit` and specified parameters
- Replaced `create_file` with `Write` and specified parameters
- Updated path reference from `../instructions/` to `../.claude/rules/`

---

## Post-Conversion Validation

**MUST:**
- Verify converted file exists in `.claude/prompts/` directory
- Check that frontmatter contains only `name` and `description` fields
- Confirm no `${input:}` syntax remains in content
- Confirm no Copilot tool names remain anywhere in content
- Confirm all path references resolve correctly
- Validate AI-targeted language compliance
- Verify all execution steps preserved with updated tool names
- Test that parameter documentation is clear

**MUST NOT:**
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings throughout all sections
- Leave Copilot-specific properties or syntax in converted file

---

## Compliance Verification

**Before completing ANY prompt conversion:**

Ask yourself:
- [ ] File moved from `.github/prompts/` to `.claude/prompts/`?
- [ ] Frontmatter contains only `name` and `description` fields?
- [ ] `tools` property removed from frontmatter?
- [ ] `argument-hint` property removed from frontmatter?
- [ ] All `${input:}` syntax converted to parameter descriptions?
- [ ] Input Format section converted to Input Parameters section?
- [ ] All Copilot tool names replaced with Claude Code equivalents?
- [ ] Tool usage syntax updated with parameter names in all sections?
- [ ] All execution steps preserved with updated tool references?
- [ ] All path references updated from `.github/` to `.claude/`?
- [ ] AI-targeted language maintained (second person, imperative mood)?
- [ ] All MUST/MUST NOT sections preserved exactly?
- [ ] All verification checklists preserved with updated tool names?
- [ ] UK English spelling maintained?
- [ ] All cross-references validated and working?

**If ANY answer is "No":**
- Complete the missing conversion step
- Verify the specific file again
- These are mandatory standards
