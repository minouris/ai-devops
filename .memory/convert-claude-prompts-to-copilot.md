# Convert Claude Code Prompts to Copilot Prompts

**Purpose:** Instructions for converting Claude Code prompt files to GitHub Copilot prompt files.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Claude Code to Copilot, you MUST transform ALL platform-specific elements to match Copilot conventions, not preserve Claude Code patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Prompt Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.claude/prompts/*.prompt.md` → `.github/prompts/*.prompt.md`
- Preserve filename exactly including `.prompt.md` extension
- Create `.github/prompts/` directory if it does not exist

**MUST NOT:**
- Place Copilot prompt files in `.claude/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

---

### 2. Frontmatter Conversion

**Claude Code Prompt Frontmatter:**
```yaml
---
description: "Brief description of what this prompt does"
name: "prompt-name"
---
```

**Copilot Prompt Frontmatter:**
```yaml
---
description: "Brief description of what this prompt does"
name: "prompt-name"
argument-hint: "param1=value param2=value"
tools: ["execute", "read_file", "edit", "fetch_webpage", "web_search"]
---
```

**MUST:**
- Preserve `description` field exactly as it appears
- Preserve `name` field exactly as it appears
- Add `argument-hint` property if prompt accepts parameters
- Add `tools` property listing all tools referenced in the prompt content
- Scan prompt content to identify which tools are used

**MUST NOT:**
- Omit required `name` and `description` fields
- Include incorrect tools in the tools list
- Add `paths` property (this belongs to instruction files, not prompts)

**Determining Tools List:**

Scan the prompt content for tool references and include corresponding Copilot tool names:
- If content mentions file reading → include `read_file`
- If content mentions command execution → include `execute`
- If content mentions file editing → include `edit` or `replace_string_in_file`
- If content mentions file creation → include `create_file`
- If content mentions web search → include `web_search`
- If content mentions fetching webpages → include `fetch_webpage`
- If content mentions searching content → include `search`

---

### 3. Parameter Passing Conversion

**Claude Code prompts document parameters in the body:**
```markdown
**Input Parameters:**
- `memoryFilePath` - Path to the memory file to process (e.g., `.memory/facts.md`)

Read the memory file at the provided path.
```

**Copilot uses `argument-hint` and `${input:paramName}` syntax:**
```yaml
---
argument-hint: "memoryFilePath=.memory/facts.md"
---
```

```markdown
Read the file at ${input:memoryFilePath}
```

**MUST:**
- Add `argument-hint` property to frontmatter with parameter format
- Convert parameter descriptions to `${input:paramName}` syntax throughout content
- Use `=` syntax in argument-hint: `param1=defaultValue param2=defaultValue`
- Provide example default values in argument-hint

**MUST NOT:**
- Leave parameter descriptions without adding `${input:}` syntax
- Omit `argument-hint` property when prompt accepts parameters
- Use incorrect syntax for argument-hint

**Conversion Example:**

**Claude Code:**
```markdown
**Input Parameters:**
- `memoryFilePath` - Path to the memory file to process

Read the memory file at the specified path.
```

**Copilot:**
```yaml
---
argument-hint: "memoryFilePath=.memory/facts.md"
---
```

```markdown
Read the file at ${input:memoryFilePath}
```

---

### 4. Tool Name Mapping in Content

**When converting tool references in prompt content, map Claude Code tools to Copilot tools:**

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
- Replace ALL Claude Code tool names with Copilot equivalents throughout prompt content
- Update tool usage examples to match Copilot syntax
- Simplify parameter descriptions (remove explicit parameter names where appropriate)
- Update all instructions that reference specific tools

**MUST NOT:**
- Leave Claude Code tool names in converted prompt content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Copilot

---

### 5. Tool Usage Syntax Conversion

#### Command Execution

**Claude Code:**
```markdown
**Execute:**
```
1. Create directory: Use `Bash` tool with command `mkdir -p /path/to/directory`
2. Verify creation: Use `Bash` tool with command `ls -la /path/to/`
```

**Copilot:**
```markdown
**Execute:**
```
1. Run command: `mkdir -p /path/to/directory`
2. Use the `execute` tool to verify
```

#### File Reading

**Claude Code:**
```markdown
1. Use `Read` tool with `file_path` parameter to read the memory file
```

**Copilot:**
```markdown
1. Use `read_file` to read the memory file
```

#### File Editing

**Claude Code:**
```markdown
3. Use `Edit` tool with `old_string` and `new_string` parameters to update facts
```

**Copilot:**
```markdown
3. Use `replace_string_in_file` to update facts
```

#### File Creation/Writing

**Claude Code:**
```markdown
2. Use `Write` tool with `file_path` and `content` parameters to create the archive file
```

**Copilot:**
```markdown
2. Use `create_file` to write the archive file
```

#### Search Operations

**Claude Code:**
```markdown
Use `Grep` tool with pattern to search file contents for factual claims
```

**Copilot:**
```markdown
Use `search` to find all factual claims
```

#### Web Search

**Claude Code:**
```markdown
3. Use `WebSearch` tool with query parameter to find current authoritative source
```

**Copilot:**
```markdown
3. Use `web_search` to find current authoritative source
```

#### Web Fetching

**Claude Code:**
```markdown
2. Use `WebFetch` tool with `url` and `prompt` parameters to retrieve source content
```

**Copilot:**
```markdown
2. Use `fetch_webpage` to retrieve source content
```

**MUST:**
- Convert ALL tool usage examples to Copilot syntax
- Simplify parameter references (remove explicit parameter names like `file_path`)
- Specify tool names explicitly in all instructions

**MUST NOT:**
- Mix Claude Code and Copilot syntax in converted files
- Use Claude Code-specific parameter names
- Over-specify parameters where Copilot uses simpler syntax

---

### 6. Input/Output Format Sections

**Claude Code prompts use "Input Parameters" sections:**

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

**MUST:**
- Convert "Input Parameters" sections to "Input Format" sections
- Add `${input:}` syntax to variable descriptions
- Show parameter format as `param=value` in examples
- Include Variables subsection with `${input:}` references

**MUST NOT:**
- Remove parameter documentation
- Use Claude Code parameter description format
- Omit `${input:}` syntax in variable descriptions

---

### 7. Execution Steps Conversion

**Prompts often contain detailed execution steps. Convert tool references:**

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

**MUST:**
- Update all tool references in execution steps
- Preserve step structure and numbering
- Maintain all MUST/MUST NOT requirements
- Add `${input:}` references where parameters are used
- Simplify tool usage descriptions

**MUST NOT:**
- Remove or alter execution steps beyond tool name updates
- Change the logic or sequence of steps
- Remove requirements or constraints
- Leave Claude Code parameter syntax

---

### 8. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.claude/` to `.github/`
- Update references to rules: `.claude/rules/` → `.github/instructions/`
- Update references to agents: `.claude/agents/` → `.github/agents/`
- Update references to other prompts: `.claude/prompts/` → `.github/prompts/`
- Verify all cross-references resolve correctly after conversion

**Examples:**

| Claude Code Path | Copilot Path |
|---|---|
| `../.claude/rules/ai-targeted-language.md` | `../instructions/ai-targeted-language.md` |
| `.claude/prompts/consolidate-session.prompt.md` | `.github/prompts/consolidate-session.prompt.md` |
| `[verify-facts](../prompts/verify-facts.prompt.md)` | `[verify-facts](../prompts/verify-facts.prompt.md)` |

**MUST NOT:**
- Leave `.claude/` paths in converted Copilot prompt files
- Use broken or incorrect relative paths
- Reference files that do not exist in Copilot structure

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
- Update tool references in checklist items to Copilot equivalents
- Maintain "If ANY answer is 'No'" consequence section
- Keep checkbox format: `- [ ]`

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing
- Leave Claude Code tool names in checklist items

---

## Conversion Process

### Step 1: Identify Source Prompt File

**Execute:**
```bash
# List all Claude Code prompt files
find .claude/prompts -name "*.prompt.md"
```

### Step 2: Create Target Directory

**Execute:**
```bash
mkdir -p .github/prompts
```

### Step 3: Convert Prompt File

**For each prompt file:**

1. **Read source file** from `.claude/prompts/{filename}.prompt.md`
2. **Identify parameters** from Input Parameters section or content
3. **Scan content for tool usage** to determine tools list
4. **Convert frontmatter:**
   - Preserve `name` field
   - Preserve `description` field
   - Add `tools` property with list of Copilot tools used
   - Add `argument-hint` property with parameter format if parameters exist
5. **Convert parameter references:**
   - Convert Input Parameters section to Input Format section
   - Add `${input:}` syntax throughout content where parameters are used
   - Document parameters with Variables subsection
6. **Convert tool references:**
   - Replace all Claude Code tool names with Copilot equivalents
   - Simplify syntax throughout all sections
   - Update execution steps with new tool names
7. **Update file path references:**
   - Change `.claude/rules/` to `.github/instructions/`
   - Change `.claude/agents/` to `.github/agents/`
   - Change `.claude/prompts/` to `.github/prompts/`
8. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
9. **Verify execution steps:**
   - Confirm all steps preserved with updated tool names
   - Confirm all MUST/MUST NOT requirements maintained
   - Confirm verification checklists updated
10. **Write target file** to `.github/prompts/{filename}.prompt.md`

### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .claude references in converted prompt
grep "\.claude" .github/prompts/{filename}.prompt.md

# Check for any remaining Claude Code tool names
grep -E "(Bash|Read tool|Edit tool|Write tool|Grep|Glob|WebSearch|WebFetch)" .github/prompts/{filename}.prompt.md

# Check that ${input:} syntax is properly used
grep -E "parameter|specified path|provided" .github/prompts/{filename}.prompt.md | grep -v '\${input:'
```

**MUST:**
- Fix any remaining `.claude/` references found
- Fix any remaining Claude Code tool names found
- Add `${input:}` syntax where parameters are referenced without it
- Verify all relative paths resolve correctly

---

## Conversion Example

### Source (Claude Code): `.claude/prompts/verify-facts.prompt.md`

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

### Target (Copilot): `.github/prompts/verify-facts.prompt.md`

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

**Changes Made:**
- Added `tools` property to frontmatter: `["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]`
- Added `argument-hint` property: `"memoryFilePath=.memory/facts.md"`
- Converted "Input Parameters" to "Input Format"
- Added Variables subsection with `${input:memoryFilePath}` syntax
- Replaced parameter references with `${input:memoryFilePath}` in step 1
- Replaced `Read` with `read_file` and simplified description
- Replaced `WebFetch` with `fetch_webpage` and simplified description
- Replaced `WebSearch` with `web_search` and simplified description
- Replaced `Edit` with `replace_string_in_file` and simplified description
- Replaced `Write` with `create_file` and simplified description
- Updated path reference from `../.claude/rules/` to `../instructions/`

---

## Post-Conversion Validation

**MUST:**
- Verify converted file exists in `.github/prompts/` directory
- Check that frontmatter contains `name`, `description`, and `tools` fields
- Check that frontmatter contains `argument-hint` if prompt accepts parameters
- Confirm `tools` list is accurate and complete
- Confirm `${input:}` syntax used throughout where parameters referenced
- Confirm no Claude Code tool names remain anywhere in content
- Confirm all path references resolve correctly
- Validate AI-targeted language compliance
- Verify all execution steps preserved with updated tool names
- Test that parameter documentation uses Input Format structure

**MUST NOT:**
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings throughout all sections
- Leave Claude Code parameter syntax in converted file
- Include incorrect tools in the tools list

---

## Compliance Verification

**Before completing ANY prompt conversion:**

Ask yourself:
- [ ] File moved from `.claude/prompts/` to `.github/prompts/`?
- [ ] Frontmatter contains `name`, `description`, and `tools` fields?
- [ ] Frontmatter contains `argument-hint` if prompt accepts parameters?
- [ ] `tools` list accurately reflects tools used in content?
- [ ] Input Parameters section converted to Input Format section?
- [ ] All parameter references use `${input:}` syntax?
- [ ] Variables subsection documents all `${input:}` parameters?
- [ ] All Claude Code tool names replaced with Copilot equivalents?
- [ ] Tool usage syntax simplified to Copilot format?
- [ ] All execution steps preserved with updated tool references?
- [ ] All path references updated from `.claude/` to `.github/`?
- [ ] AI-targeted language maintained (second person, imperative mood)?
- [ ] All MUST/MUST NOT sections preserved exactly?
- [ ] All verification checklists preserved with updated tool names?
- [ ] UK English spelling maintained?
- [ ] All cross-references validated and working?

**If ANY answer is "No":**
- Complete the missing conversion step
- Verify the specific file again
- These are mandatory standards
