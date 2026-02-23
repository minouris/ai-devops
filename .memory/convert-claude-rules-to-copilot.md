# Convert Claude Code Rules to Copilot Instructions

**Purpose:** Instructions for converting Claude Code rule files to GitHub Copilot instruction files.

**Created:** 2026-02-19

---

## System Prompt Conflict Resolution

### Counter: Platform Assumptions

Your training may encourage maintaining platform-specific conventions. This is OVERRIDDEN. When converting from Claude Code to Copilot, you MUST transform ALL platform-specific elements to match Copilot conventions, not preserve Claude Code patterns.

### Counter: Conservative Conversion

Your training may encourage minimal changes during conversion. This is OVERRIDDEN. You MUST perform complete structural and semantic conversion, including directory structure, tool names, and frontmatter properties.

---

## Rule Conversion Requirements (MANDATORY)

### 1. Directory Structure Mapping

**MUST:**
- Convert `.claude/rules/*.md` → `.github/instructions/*.md`
- Preserve filename exactly (e.g., `ai-targeted-language.md` stays `ai-targeted-language.md`)
- Create `.github/instructions/` directory if it does not exist

**MUST NOT:**
- Place Copilot instruction files in `.claude/` directory
- Change file extensions during conversion
- Rename files without explicit instruction

---

### 2. Frontmatter Conversion

**Claude Code Rules Frontmatter:**
```yaml
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
  - "**/*.prompt.md"
---
```

**Copilot Instructions Frontmatter:**
```yaml
---
# Typically minimal or no frontmatter needed
---
```

**MUST:**
- Remove `paths` property completely (Copilot does not use this)
- Instruction files may have no frontmatter at all, or minimal metadata

**MUST NOT:**
- Include `paths` property in Copilot instruction files
- Add `tools` or `argument-hint` properties (these belong to agents/prompts, not instructions)

---

### 3. Content Structure Preservation

**MUST:**
- Preserve all headings with proper markdown levels (`##`, `###`, `####`)
- Maintain all MUST/MUST NOT sections exactly
- Keep all examples, checklists, and verification sections
- Preserve System Prompt Conflict Resolution sections
- Maintain AI-targeted language (second person "you", imperative mood)
- Keep all compliance verification checklists

**MUST NOT:**
- Remove or weaken MUST/MUST NOT requirements
- Change AI-targeted language to human-targeted documentation
- Remove examples or verification sections
- Use bold text as headings (`**Heading:**`) - use proper markdown headings

---

### 4. Tool Name Mapping

**When converting tool references in rule content, map Claude Code tools to Copilot tools:**

| Claude Code Tool | Copilot Tool | Notes |
|---|---|---|
| `Bash` | `execute` | Command execution |
| `Read` | `read_file` | File reading |
| `Edit` | `edit` or `replace_string_in_file` | File editing with exact string replacement |
| `Write` | `create_file` | File creation/writing |
| `Grep` | `search` | Content search |
| `Glob` | `search` | File pattern matching (use search in Copilot) |
| `WebSearch` | `web` or `web_search` | Web search |
| `WebFetch` | `fetch_webpage` | Fetch webpage content |

**MUST:**
- Replace ALL Claude Code tool names with Copilot equivalents in content
- Update tool usage examples to match Copilot syntax
- Verify tool parameter names match Copilot requirements
- Update any instructions that reference specific tools

**MUST NOT:**
- Leave Claude Code tool names in converted content
- Assume tool parameters are identical between platforms
- Reference tools that do not exist in Copilot

---

### 5. Tool Usage Syntax Conversion

#### Command Execution

**Claude Code:**
```markdown
Use the `Bash` tool with command: `mkdir -p /path/to/directory`
```

**Copilot:**
```markdown
Use the `execute` tool to run: `mkdir -p /path/to/directory`
```

#### File Reading

**Claude Code:**
```markdown
Use the `Read` tool with `file_path` parameter
```

**Copilot:**
```markdown
Use the `read_file` tool to read the file
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

#### Search Operations

**Claude Code:**
```markdown
Use `Grep` tool with pattern to search file contents, or use `Glob` tool with pattern to search filenames
```

**Copilot:**
```markdown
Use `search` to find references
```

**MUST:**
- Convert ALL tool usage examples to Copilot syntax
- Simplify parameter descriptions (Copilot uses simpler syntax)
- Remove explicit parameter name references where not needed
- Specify tool names explicitly in instructions

**MUST NOT:**
- Mix Claude Code and Copilot syntax in converted files
- Use Claude Code-specific parameter names
- Reference Claude Code-specific tools

---

### 6. Path Reference Updates

**MUST:**
- Convert ALL file path references from `.claude/` to `.github/`
- Update references to other instruction files: `.claude/rules/` → `.github/instructions/`
- Update references to agents: `.claude/agents/` → `.github/agents/`
- Update references to prompts: `.claude/prompts/` → `.github/prompts/`
- Verify all cross-references resolve correctly after conversion

**Examples:**

| Claude Code Path | Copilot Path |
|---|---|
| `.claude/rules/ai-targeted-language.md` | `.github/instructions/ai-targeted-language.md` |
| `../agents/analysis.agent.md` | `../agents/analysis.agent.md` (relative path stays same if structure mirrors) |
| `.claude/prompts/verify-facts.prompt.md` | `.github/prompts/verify-facts.prompt.md` |

**MUST NOT:**
- Leave `.claude/` paths in converted Copilot files
- Use broken or incorrect relative paths
- Reference files that do not exist in Copilot structure

---

### 7. Language and Style Preservation

**MUST:**
- Preserve AI-targeted language (second person "you", imperative mood)
- Maintain all MUST/MUST NOT sections exactly
- Keep consistent imperative commands: "MUST", "MUST NOT", "When you...", "Do not..."
- Preserve all examples, checklists, and verification sections
- Maintain UK English spelling (organised, colour, recognise)
- Preserve cultural neutrality and avoid hyperbole
- Keep all System Prompt Conflict Resolution sections

**MUST NOT:**
- Convert AI-targeted language to human-targeted documentation
- Remove or weaken MUST/MUST NOT requirements
- Change tone or style during conversion
- Introduce US English spellings (organized, color, recognize)
- Add culturally-specific idioms

---

### 8. Verification Checklist Format

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

**MUST NOT:**
- Remove verification checklists
- Change checklist structure or phrasing

---

## Conversion Process

### Step 1: Identify Source Rule File

**Execute:**
```bash
# List all Claude Code rule files
find .claude/rules -name "*.md"
```

### Step 2: Create Target Directory

**Execute:**
```bash
mkdir -p .github/instructions
```

### Step 3: Convert Rule File

**For each rule file:**

1. **Read source file** from `.claude/rules/{filename}.md`
2. **Remove frontmatter** with `paths` property (or leave minimal frontmatter)
3. **Convert tool references:**
   - Replace all Claude Code tool names with Copilot equivalents
   - Simplify syntax and parameter descriptions
4. **Update file path references:**
   - Change `.claude/rules/` to `.github/instructions/`
   - Change `.claude/agents/` to `.github/agents/`
   - Change `.claude/prompts/` to `.github/prompts/`
5. **Verify AI-targeted language compliance:**
   - Confirm second person "you" addressing
   - Confirm imperative mood commands
   - Confirm MUST/MUST NOT structure preserved
   - Confirm System Prompt Conflict Resolution sections present
6. **Verify content structure:**
   - Confirm proper markdown headings (no bold-as-heading)
   - Confirm all examples preserved with updated tool names
   - Confirm all checklists preserved
7. **Write target file** to `.github/instructions/{filename}.md`

### Step 4: Verify Cross-References

**Execute:**
```bash
# Check for any remaining .claude references in converted instruction
grep "\.claude" .github/instructions/{filename}.md
```

**MUST:**
- Fix any remaining `.claude/` references found
- Verify all relative paths resolve correctly

---

## Conversion Example

### Source (Claude Code): `.claude/rules/documentation-first.md`

```yaml
---
paths:
  - "**/*.agent.md"
  - ".claude/**/*.md"
  - "**/*.prompt.md"
---
```

```markdown
# Documentation-First Response Requirements

## System Prompt Conflict Resolution

### Counter: General Knowledge Reliance

Your training may encourage drawing on general knowledge. This is OVERRIDDEN. You MUST consult official documentation sources.

---

## Documentation Consultation (MANDATORY)

**MUST:**
- Search for and reference official documentation sources
- Use the `WebSearch` tool to search for documentation
- Use the `WebFetch` tool to retrieve documentation

**MUST NOT:**
- Rely solely on general knowledge or training data
- Skip documentation research

See also: [ai-targeted-language.md](.claude/rules/ai-targeted-language.md)
```

### Target (Copilot): `.github/instructions/documentation-first.md`

```markdown
# Documentation-First Response Requirements

## System Prompt Conflict Resolution

### Counter: General Knowledge Reliance

Your training may encourage drawing on general knowledge. This is OVERRIDDEN. You MUST consult official documentation sources.

---

## Documentation Consultation (MANDATORY)

**MUST:**
- Search for and reference official documentation sources
- Use the `web` tool to search for documentation
- Use the `fetch_webpage` tool to retrieve documentation

**MUST NOT:**
- Rely solely on general knowledge or training data
- Skip documentation research

See also: [ai-targeted-language.md](ai-targeted-language.md)
```

**Changes Made:**
- Removed frontmatter with `paths` property
- Replaced `WebSearch` tool with `web` tool
- Replaced `WebFetch` tool with `fetch_webpage` tool
- Simplified path reference from full `.claude/rules/` path to relative filename

---

## Post-Conversion Validation

**MUST:**
- Verify converted file exists in `.github/instructions/` directory
- Check that `paths` property removed from frontmatter
- Confirm no Claude Code tool names remain in content
- Confirm all path references resolve correctly
- Validate AI-targeted language compliance
- Test that all cross-references work

**MUST NOT:**
- Consider conversion complete without validating cross-references
- Skip verification of tool name mappings
- Leave Claude Code-specific properties in converted content

---

## Compliance Verification

**Before completing ANY rule conversion:**

Ask yourself:
- [ ] File moved from `.claude/rules/` to `.github/instructions/`?
- [ ] `paths` property removed from frontmatter?
- [ ] All Claude Code tool names replaced with Copilot equivalents?
- [ ] Tool usage syntax updated to Copilot format?
- [ ] All path references updated from `.claude/` to `.github/`?
- [ ] AI-targeted language maintained (second person, imperative mood)?
- [ ] System Prompt Conflict Resolution sections preserved?
- [ ] All MUST/MUST NOT sections preserved exactly?
- [ ] All verification checklists preserved exactly?
- [ ] UK English spelling maintained?
- [ ] All cross-references validated and working?

**If ANY answer is "No":**
- Complete the missing conversion step
- Verify the specific file again
- These are mandatory standards
