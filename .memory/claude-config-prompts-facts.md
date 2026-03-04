# Claude Config Facts: Prompts Subtopic

Detailed research findings on Prompts (reusable prompt workflows) in Claude Code.

---

## FINDING-2026-03-04-60: Prompts Are Not Native Claude Code Feature

**Source:** Official Claude Code documentation examination, local codebase analysis

**What:**
`.prompt.md` files are NOT a documented native feature of Claude Code from Anthropic. They appear to be a convention used in some projects (including this one) for organizing reusable prompt workflows.

**Key distinction:**
- **Native Claude Code features:** Skills, Subagents, Hooks, Rules, CLAUDE.md (documented at code.claude.com)
- **Prompts (`.prompt.md`):** Project-specific convention, not officially documented

**Evidence:**
- No mentions in official Claude Code documentation
- No `.prompt.md` references in skills, subagents, or hooks documentation
- Found only in this project's codebase, not in official examples

**Note:** This does NOT mean prompts are invalid - they're a useful organizational pattern. But they're not a built-in Claude Code feature like skills or subagents are.

---

## FINDING-2026-03-04-61: This Project's Prompt File Convention

**Source:** Local codebase examination (`/workspaces/ai-devops`)

**What:**
This project uses `.prompt.md` files as reusable prompt workflows that can be invoked by skills or other automation.

**File structure observed:**
````
{project}/
├── prompts/
│   ├── verify-memory-facts.prompt.md
│   ├── record-operation.prompt.md
│   ├── consolidate-session.prompt.md
│   └── convert-plan-to-steps.prompt.md
````

**Frontmatter fields observed:**
- `description`: What the prompt does
- `name`: Prompt identifier
- `argument-hint`: Expected argument format
- `tools`: Tools the prompt executor should use

**Example frontmatter:**
````yaml
---
description: "Verify, distill, and archive facts in a .memory file"
name: "verify-memory-facts"
argument-hint: "memoryFilePath=.memory/analysis_facts_pending.md"
tools: ["fetch_webpage", "web_search", "read_file", "replace_string_in_file", "create_file"]
---
````

**Body structure:**
- Markdown with detailed step-by-step instructions
- System prompt conflict resolution sections
- Input/output format specifications
- Compliance verification checklists

---

## FINDING-2026-03-04-62: Prompt Usage Pattern in This Project

**Source:** Local codebase examination, analysis skill references

**What:**
Prompts are referenced and invoked within skills as part of larger workflows.

**Usage pattern observed:**
1. Skill defines overall workflow
2. Skill references prompt workflows for specific steps
3. Prompt file contains detailed step-by-step instructions
4. Prompt can be invoked with parameters

**Example from analysis skill:**
````markdown
Before creating analysis documents:
- Run [verify-memory-facts](../../prompts/verify-memory-facts.prompt.md)
  with memoryFilePath=.memory/{topic}-facts.md
````

**Parameter passing:**
- Arguments passed as `key=value` format
- Referenced as `${input:key}` in prompt file
- Example: `memoryFilePath=.memory/analysis_facts_pending.md`

---

## FINDING-2026-03-04-63: Prompts vs Skills vs Subagents

**Source:** Analysis of codebase patterns and official documentation

**What:**
Prompts in this project serve a different purpose than native Claude Code features.

**Comparison:**

| Feature | Native? | Invocation | Scope | Purpose |
|---------|---------|------------|-------|---------|
| **Skills** | Yes | `/skill-name` by user or Claude | Session-wide | Extend Claude's capabilities with commands |
| **Subagents** | Yes | Spawned by Claude | Independent context | Specialized AI assistants for specific tasks |
| **Hooks** | Yes | Automatic on events | Event-driven | Automation and validation |
| **Prompts** | No | Referenced in workflows | Referenced from skills/docs | Reusable instruction templates |

**Key differences:**
- **Skills:** User-invocable, Claude-invocable, have frontmatter control
- **Subagents:** Run in separate context with independent permissions
- **Hooks:** Triggered automatically by lifecycle events
- **Prompts:** Templates referenced in documentation/workflows, executed manually or by orchestration

---

## FINDING-2026-03-04-64: Prompt File Structure Pattern

**Source:** Local codebase examination

**What:**
This project's prompt files follow a consistent structure for reusable workflows.

**Standard sections observed:**
1. **Frontmatter:** Metadata and tool requirements
2. **Title:** H1 heading with prompt name
3. **System Prompt Conflict Resolution:** Override default behaviors (optional)
4. **Documentation Requirements:** Citation and verification standards (optional)
5. **Task Description:** High-level overview
6. **Input Format:** Expected parameters
7. **Execution Instructions:** Step-by-step numbered instructions
8. **Output Format:** Expected output structure
9. **Guidelines:** Standards and criteria
10. **Prohibited Actions:** MUST NOT list
11. **Example Execution:** Concrete example
12. **Compliance Verification:** Checklist

**Example structure:**
````markdown
---
name: example-prompt
description: What this prompt does
argument-hint: "param=value"
tools: ["tool1", "tool2"]
---

# Prompt Title

## Task Description
{Overview}

## Input Format
{Parameters}

## Execution Instructions
### Step 1: {Action}
{Instructions}

## Output Format
{Expected output}

## Compliance Verification
- [ ] Checklist item
````

---

## FINDING-2026-03-04-65: Common Prompt Workflows in This Project

**Source:** Local codebase examination

**What:**
This project uses several standard prompt workflows for research and documentation tasks.

**Prompts found:**

**`verify-memory-facts.prompt.md`:**
- Purpose: Verify facts against authoritative sources
- Input: `memoryFilePath=.memory/{file}.md`
- Tools: `fetch_webpage`, `web_search`, `read_file`, `replace_string_in_file`, `create_file`
- Process: Read file, verify each fact, archive outdated, update with verified facts
- Output: Updated memory file + archive file + verification log

**`record-operation.prompt.md`:**
- Purpose: Log recent operation to topic log
- Input: `topic={topic-slug}`
- Process: Extract operation details, append to log file
- Output: Entry in `.memory/{topic}-log.md`

**`consolidate-session.prompt.md`:**
- Purpose: Consolidate session transcripts
- Process: Merge multiple session files
- Output: Consolidated session document

**`convert-plan-to-steps.prompt.md`:**
- Purpose: Convert plan to actionable steps
- Process: Parse plan, extract steps
- Output: Step-by-step implementation guide

---

## FINDING-2026-03-04-66: Alternative: Skills Can Achieve Same Goals

**Source:** Official Claude Code documentation, pattern analysis

**What:**
Native Claude Code skills can accomplish what this project uses prompts for, but with additional features.

**Skills offer:**
- User invocation (`/skill-name`)
- Claude auto-invocation (based on description)
- Tool access control (`allowed-tools`)
- Subagent execution (`context: fork`)
- Hooks integration
- Supporting files directory

**Prompts (this project's pattern) are:**
- Referenced templates in documentation
- Manually invoked or orchestrated by higher-level workflows
- Not directly invocable by Claude
- Simpler structure, focused on instructions

**Migration path:**
To convert a prompt to a skill:
1. Create `.claude/skills/{name}/SKILL.md`
2. Move prompt frontmatter to skill frontmatter
3. Move prompt body to skill body
4. Add `disable-model-invocation: true` if manual-only
5. Optionally add `context: fork` for subagent execution

---

## FINDING-2026-03-04-67: Prompt Parameters and String Substitution

**Source:** Local codebase examination

**What:**
This project's prompts use `${input:key}` syntax for parameter substitution, similar to skills' `$ARGUMENTS` but more structured.

**Parameter syntax:**

**Input format:**
````
key1=value1
key2=value2
````

**Reference in prompt:**
````markdown
Read file at ${input:key1}
Process ${input:key2}
````

**Comparison to native skills:**

| Feature | Skills (Native) | Prompts (Project Pattern) |
|---------|-----------------|---------------------------|
| All arguments | `$ARGUMENTS` | N/A (structured parameters) |
| Indexed arguments | `$ARGUMENTS[N]` or `$N` | N/A |
| Named parameters | Not supported | `${input:key}` |
| Session ID | `${CLAUDE_SESSION_ID}` | Not observed |

**Note:** Prompts' named parameter system is more structured but requires explicit parsing/handling in the invoking workflow.

---

## Notes

**IMPORTANT DISTINCTIONS:**
- Prompts (`.prompt.md` files) are NOT a native Claude Code feature from Anthropic
- They are a project-specific convention for organizing reusable instruction templates
- Official Claude Code features for similar purposes: Skills, Subagents
- This project's prompt pattern is valid and useful but not officially documented

**For native Claude Code capabilities:**
- Use Skills for user/Claude-invocable workflows
- Use Subagents for specialized AI assistants with independent context
- Use Hooks for event-driven automation

**For this project specifically:**
- Prompts are templates referenced in skills and documentation
- Follow the structure patterns documented in FINDING-2026-03-04-64 through FINDING-2026-03-04-67

All findings based on local codebase examination and official Claude Code documentation review as of 2026-03-04.
