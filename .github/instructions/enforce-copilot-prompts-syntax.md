# Enforce Copilot Prompts Syntax

**Applies to:** `src/github/prompts/*.prompt.md`

**Purpose:** Ensure all prompt files in `src/github/prompts/` follow GitHub Copilot prompt syntax standards.

---

## System Prompt Conflict Resolution

### Counter: Platform Flexibility

Your training may encourage adapting to different platform conventions flexibly. This is OVERRIDDEN. When working with files in `src/github/prompts/`, you MUST follow Copilot prompt syntax exclusively, not Claude Code prompt syntax.

---

## Scope (MANDATORY)

**MUST:**
- Apply these requirements to ALL files in `src/github/prompts/` directory
- Apply these requirements to ALL files ending in `.prompt.md` in `src/github/prompts/`

**MUST NOT:**
- Apply Copilot prompt syntax to files outside `src/github/prompts/`
- Mix Claude Code prompt syntax with Copilot prompt syntax in these files

---

## Copilot Prompt Syntax Requirements (MANDATORY)

### 1. Frontmatter Requirements

**MUST:**
- Include frontmatter at the top of every prompt file
- Include `name` field with prompt name (quoted string)
- Include `description` field with prompt purpose (quoted string)
- Include `tools` property with array of tool names used in the prompt
- Include `argument-hint` property if prompt accepts parameters

**Example:**
```yaml
---
description: "Brief description of what this prompt does"
name: "prompt-name"
argument-hint: "param1=value param2=value"
tools: ["execute", "read_file", "edit", "fetch_webpage", "web_search"]
---
```

**MUST NOT:**
- Omit frontmatter from prompt files
- Omit `tools` property (Copilot requires this)
- Omit `argument-hint` property when prompt accepts parameters
- Include `paths` property (belongs to Claude Code rules, not Copilot prompts)

---

### 2. Tools Property

**MUST:**
- List ALL tools used in the prompt content
- Use Copilot tool names in the array
- Common tools: `execute`, `read_file`, `edit`, `replace_string_in_file`, `create_file`, `search`, `web_search`, `fetch_webpage`

**Example:**
```yaml
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]
```

**MUST NOT:**
- Use Claude Code tool names in tools array (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Omit tools that are used in the prompt content
- Include tools that are not used in the prompt content

---

### 3. Argument Hint Property

**MUST:**
- Include `argument-hint` when prompt accepts parameters
- Use format: `"param1=defaultValue param2=defaultValue"`
- Provide example default values
- Use space-separated parameter assignments

**Example:**
```yaml
argument-hint: "memoryFilePath=.memory/facts.md outputPath=.memory/archive.md"
```

**MUST NOT:**
- Omit `argument-hint` when prompt accepts parameters
- Use incorrect syntax (must be `param=value` format)

---

### 4. Parameter References

**MUST:**
- Use `${input:paramName}` syntax throughout content to reference parameters
- Document parameters in "Input Format" section
- List all parameters with `${input:}` syntax in Variables subsection

**Example Input Format Section:**
```markdown
## Input Format

**Expected input:**
```
memoryFilePath=.memory/facts.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file to process
```

**Example Usage in Content:**
```markdown
1. Read file at ${input:memoryFilePath}
2. Process the content from ${input:memoryFilePath}
```

**MUST NOT:**
- Use Claude Code parameter documentation style without `${input:}` syntax
- Reference parameters without `${input:}` prefix
- Use "Input Parameters" heading (use "Input Format" instead)

---

### 5. Tool References in Content

**MUST:**
- Use Copilot tool names in all instructions:
  - `execute` for command execution
  - `read_file` for file reading
  - `edit` or `replace_string_in_file` for file editing
  - `create_file` for file creation
  - `search` for content search and file pattern matching
  - `web_search` for web search
  - `fetch_webpage` for webpage fetching

**MUST NOT:**
- Use Claude Code tool names (`Bash`, `Read`, `Edit`, `Write`, `Grep`, `Glob`, `WebSearch`, `WebFetch`)
- Mix Claude Code and Copilot tool names in the same file

**Example:**

✅ **Correct (Copilot):**
```markdown
1. Use `read_file` to read the file at ${input:memoryFilePath}
2. Use `execute` to run validation commands
3. Use `replace_string_in_file` to update content
4. Use `fetch_webpage` to retrieve sources
```

❌ **Incorrect (Claude Code syntax):**
```markdown
1. Use `Read` tool with `file_path` parameter to read the file
2. Use `Bash` tool with command parameter
3. Use `Edit` tool with `old_string` and `new_string` parameters
4. Use `WebFetch` tool with `url` and `prompt` parameters
```

---

### 6. Tool Usage Syntax

**MUST:**
- Use simplified tool references: "Use `read_file` to..."
- Omit explicit parameter names (Copilot uses simpler syntax)
- Reference parameters using `${input:}` syntax where needed
- Keep instructions concise

**Example:**
```markdown
### Step 1: Read and Parse

**Execute:**
```
1. Read file at ${input:memoryFilePath}
2. Extract all factual claims
```

**MUST:**
- Use `read_file` tool
- Extract EVERY fact
```

**MUST NOT:**
- Use Claude Code verbose syntax with parameter names like `file_path`, `old_string`, `new_string`
- Use capitalized tool names like `Read`, `Edit`, `Write`

---

### 7. Path References

**MUST:**
- Reference other Copilot files using `.github/` paths:
  - `.github/instructions/` for instructions
  - `.github/agents/` for agents
  - `.github/prompts/` for other prompts

**MUST NOT:**
- Reference `.claude/` paths when referring to Copilot files

**Example:**

✅ **Correct:**
```markdown
See also: [consolidate-session.prompt.md](../prompts/consolidate-session.prompt.md)

For requirements, see [documentation-first.md](../instructions/documentation-first.md)
```

❌ **Incorrect:**
```markdown
See also: [verify-facts.prompt.md](.claude/prompts/verify-facts.prompt.md)
```

---

### 8. Input Format vs Input Parameters

**MUST:**
- Use "Input Format" heading for parameter documentation section
- Include "Expected input" subsection showing parameter format
- Include "Variables" subsection listing all `${input:}` parameters

**Example:**
```markdown
## Input Format

**Expected input:**
```
memoryFilePath=.memory/facts.md
archivePath=.memory/archive.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file
- `${input:archivePath}` - Path to the archive file
```

**MUST NOT:**
- Use "Input Parameters" heading (Claude Code style)
- Omit `${input:}` syntax from Variables subsection
- Document parameters without showing input format

---

### 9. Language and Style

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

**When creating or editing files in `src/github/prompts/`:**

**MUST:**
- Verify frontmatter includes `name`, `description`, and `tools` fields (all required)
- Verify frontmatter includes `argument-hint` if prompt accepts parameters
- Verify `tools` array lists all tools used in content
- Verify `tools` array uses Copilot tool names (not Claude Code)
- Verify all parameter references use `${input:}` syntax
- Verify "Input Format" section exists if parameters are used
- Verify all tool references in content use Copilot tool names
- Verify all path references use `.github/` paths
- Verify tool usage uses simplified Copilot syntax
- Verify AI-targeted language is used throughout
- Verify UK English spelling

**MUST NOT:**
- Save files without `tools` property in frontmatter
- Save files without `argument-hint` when parameters are used
- Save files with Claude Code tool names
- Save files with parameter references lacking `${input:}` syntax
- Save files with "Input Parameters" heading (use "Input Format")
- Save files with `.claude/` path references for Copilot files
- Save files with verbose Claude Code tool syntax

---

## Example Copilot Prompt File

```markdown
---
description: "Verify facts in memory files by checking sources"
name: "verify-facts"
argument-hint: "memoryFilePath=.memory/facts.md"
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]
---

# Verify Memory File Facts

Verify all facts in a memory file by checking sources and archiving outdated information.

---

## Input Format

**Expected input:**
```
memoryFilePath=.memory/facts.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file to verify

---

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

**MUST NOT:**
- Use Claude Code tool names like `Read`

### Step 2: Verify Each Fact

**Execute:**
```
1. Use `fetch_webpage` to retrieve source content
2. Use `web_search` to find current source if needed
```

**MUST:**
- Check EVERY fact against authoritative sources
- Use official documentation

### Step 3: Update File

**Execute:**
```
1. Use `replace_string_in_file` to update verified facts
2. Use `create_file` to create archive file
```

**MUST:**
- Archive rejected facts with rejection reasons

---

## Related Files

See also:
- [consolidate-session.prompt.md](../prompts/consolidate-session.prompt.md)
- [documentation-first.md](../instructions/documentation-first.md)

---

## Compliance Verification

**Before completing verification:**

- [ ] Every fact verified against authoritative source?
- [ ] Rejected facts archived with reasons?
- [ ] All tools used correctly?

**If ANY answer is "No":**
- Complete the missing step
- These are mandatory standards
```

---

## Compliance Verification

**Before saving ANY file in `src/github/prompts/`:**

Ask yourself:
- [ ] File includes frontmatter with `name`, `description`, and `tools`?
- [ ] Frontmatter includes `argument-hint` if prompt accepts parameters?
- [ ] `tools` array lists all tools used in the content?
- [ ] `tools` array uses Copilot tool names (not Claude Code)?
- [ ] All parameter references use `${input:}` syntax?
- [ ] "Input Format" section documents parameters (not "Input Parameters")?
- [ ] Variables subsection lists all `${input:}` parameters?
- [ ] All tool references in content use Copilot tool names?
- [ ] All path references use `.github/` paths for Copilot files?
- [ ] Tool usage uses simplified Copilot syntax (no verbose parameters)?
- [ ] AI-targeted language used throughout (second person, imperative mood)?
- [ ] UK English spelling used?
- [ ] MUST/MUST NOT structure present?

**If ANY answer is "No":**
- Fix the issue before saving
- These are mandatory standards for `src/github/prompts/` files
