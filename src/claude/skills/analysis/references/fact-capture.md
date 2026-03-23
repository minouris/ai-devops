# Fact Capture Guidelines

**This file is loaded when: You need detailed guidance on capturing research findings in fact files.**

---

# Embedded Rules

## Documentation-First Response Requirements (from /src/claude/rules/documentation-first.md)

### 1. Documentation Consultation (MANDATORY)

**MUST:**
- Search for and reference official documentation sources relevant to facts being captured
- Verify information against authoritative sources before recording facts
- Prioritize official documentation over general knowledge

**MUST NOT:**
- Rely solely on general knowledge or training data
- Provide facts without verifying against official sources
- Skip documentation research even for seemingly simple facts

---

### 2. No Assumptions or Speculation (MANDATORY)

**MUST:**
- Explicitly state when information cannot be verified through documentation
- Say "I don't know" or "I cannot verify this information" when uncertain
- Ask for clarification rather than assuming what sources say

**MUST NOT:**
- Speculate or provide unverified facts
- Make assumptions about technical details without documentation
- Guess at implementation details

---

### 3. Citation Requirements (MANDATORY)

**MUST:**
- Include source reference for every fact captured
- Link to official documentation sources
- Specify the exact section or page referenced
- Place citations inline with each fact entry

**MUST NOT:**
- Record facts without source citations
- Reference unofficial or unverified sources as authoritative
- Use vague source references

---

## Literal Specification Compliance (from /src/claude/rules/literal-specification.md)

**MUST:**
- Follow FINDING-YYYY-MM-DD-N format precisely (no variations)
- Include all required fields: timestamp, source, content
- Preserve exact field order as specified in template

**MUST NOT:**
- Add fields to the finding template beyond specification
- Add metadata or sections not in the specification
- Modify the finding format "for convenience"

---

## Existing Rules

### No Inline Approval (MANDATORY)

**MUST:**
- Continue research without pausing for approval
- Capture broadly: facts, observations, theories, hypotheses, approaches attempted
- Archive disproven findings immediately when user disproves them
- Never delete disproven findings

**MUST NOT:**
- Stop to ask for inline approval during research
- Duplicate existing entries
- Edit existing findings during research phase

---

## File Naming Conventions

**Folder-based organisation (MANDATORY):**

Organise topics and subtopics in folders within the workspace root `.memory/` directory. This is the ONLY correct location for analysis memory files.

**CRITICAL - Path Requirements:**
- **CORRECT location:** `.memory/[topic]/` (within workspace root)
- **WRONG locations:** `src/claude/projects/.../memory/` (NEVER use this), `.claude/projects/...` (NEVER use this)
- When you create any memory file, verify its path starts with `.memory/` in the workspace root

**Correct structure:**
```
.memory/[topic]/
├── [topic]-facts.md              (main topic fact file)
├── [topic]-facts-disproven.md    (main topic disproven archive)
├── [topic]-index.md              (topic index)
├── [topic]-log.md                (operation log)
├── [topic]-[subtopic1]/          (subtopic folder)
│   ├── [topic]-[subtopic1]-facts.md
│   ├── [topic]-[subtopic1]-facts-disproven.md
│   └── [topic]-[subtopic1]-terms.md (optional)
└── [topic]-[subtopic2]/          (subtopic folder)
    ├── [topic]-[subtopic2]-facts.md
    ├── [topic]-[subtopic2]-facts-disproven.md
    └── [other supplementary files]
```

**MUST:**
- Create a folder for each topic: `.memory/[topic]/`
- Create a folder for each subtopic: `.memory/[topic]/[topic]-[subtopic]/`
- Place all topic-level files (main facts, index, log) directly in the topic folder
- Place all subtopic-level files (subtopic facts, disproven archives, term files) in the subtopic folder
- Use the full `[topic]-[subtopic]` prefix for subtopic folder names and file names
- Use `-facts-disproven.md` suffix for disproven findings archives (not `-archive.md`)
- Apply this structure recursively for nested subtopics
- **ENFORCE**: Topic column in index findings table MUST link to actual subtopic facts files
  - Example: If finding has Topic="Authentication", file `github-api-authentication/github-api-authentication-facts.md` must exist
  - Finding links in index point directly to subtopic files, not main facts file

**MUST NOT:**
- Create flat file structures in `.memory/` root for topics with multiple files
- Place subtopic fact files directly in the topic folder alongside the main fact file
- Scatter topic or subtopic files across multiple folders
- Place subtopic files outside their designated subtopic folder
- Use `-archive.md` suffix for disproven files (use `-facts-disproven.md` instead)
- List a Topic value unless its corresponding subtopic facts file exists

**Example:**
```
.memory/github-api/
├── github-api-facts.md
├── github-api-facts-disproven.md
├── github-api-index.md
├── github-api-log.md
├── github-api-authentication/
│   ├── github-api-authentication-facts.md
│   └── github-api-authentication-facts-disproven.md
├── github-api-comment-resolution/
│   ├── github-api-comment-resolution-facts.md
│   └── github-api-comment-resolution-facts-disproven.md
└── github-api-integration/
    ├── github-api-integration-facts.md
    └── github-api-integration-facts-disproven.md
```
│   └── claude-config-hooks-verification.md
└── claude-config-composition/
    ├── claude-config-composition-facts.md
    └── claude-config-composition-verification.md
```

---

## Link Integrity (MANDATORY)

When you use folder-based organisation, maintain correct relative paths between files at different levels.

**From topic-level files to subtopic files:**
```markdown
See [claude-config-skills-facts.md](claude-config-skills/claude-config-skills-facts.md)
```

**From subtopic files to topic-level files:**
```markdown
See [claude-config-index.md](../claude-config-index.md)
```

**From subtopic files to sibling subtopic files:**
```markdown
See [claude-config-hooks-facts.md](../claude-config-hooks/claude-config-hooks-facts.md)
```

**MUST:**
- Use relative paths that account for folder nesting
- Test links work from the file's actual location
- Update all links when migrating from flat to folder structure
- Use `../` to navigate up from subtopic folder to topic folder
- Use `[subtopic-folder]/[filename]` to navigate down from topic folder to subtopic folder

**MUST NOT:**
- Use absolute paths in markdown links between memory files
- Assume files are at the same level when they're in different folders
- Leave broken links after restructuring files into folders

**Example index file with correct links:**
```markdown
# Claude Config Research Index

## Fact Files

### Primary Fact File
- [claude-config-facts.md](claude-config-facts.md) — Core configuration

### Subtopic Files
- [claude-config-skills-facts.md](claude-config-skills/claude-config-skills-facts.md) — Skills
- [claude-config-hooks-facts.md](claude-config-hooks/claude-config-hooks-facts.md) — Hooks
```

---

## File Size Management (MANDATORY)

Large fact files are difficult to parse and slow down research operations. Manage file growth by creating new subtopics when thresholds are exceeded.

**Size threshold:**
- **Maximum recommended:** 40,000 characters (~10,000 tokens)
- **Action trigger:** When you add a new fact that would exceed this threshold

**MUST:**
- Check current file size before appending new facts
- Create a new subtopic when threshold would be exceeded
- Move related facts from the main file to the new subtopic
- Group facts by natural thematic boundaries (not arbitrary splits)
- Update the topic index to reference the new subtopic

**MUST NOT:**
- Allow fact files to grow beyond 40,000 characters
- Split files arbitrarily in the middle of a thematic group
- Create subtopics with only 1-2 facts (group related facts together)
- Leave orphaned facts in the main file after creating a subtopic

**Rationale:**
Claude's long context capabilities support performance up to 20K+ tokens with data at the top of prompts. However, fact files that you read and parse frequently during research benefit from smaller sizes for efficiency. The 40,000 character threshold (~10,000 tokens) balances manageability with avoiding excessive file fragmentation.

**When you exceed the threshold, follow this process:**

1. **Identify thematic groups:** Review existing facts and identify natural groupings
2. **Select subtopic name:** Choose a descriptive name for the new subtopic
3. **Create subtopic folder:** `.memory/[topic]/[topic]-[subtopic]/`
4. **Move related facts:** Transfer the new fact and related existing facts to the new subtopic file
5. **Update main topic index:** Add the new subtopic to the main topic index file (`.memory/[topic]/[topic]-index.md`)
6. **Update links:** Ensure all cross-references use correct relative paths

**CRITICAL - DO NOT create per-subtopic indexes:**
- DO NOT create `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-index.md`
- All findings from subtopics MUST be added to the main topic index at `.memory/[topic]/`

**Example scenario:**

```
.memory/claude-config/
├── claude-config-facts.md (38,000 characters)
└── claude-config-index.md

New fact would add 5,000 characters → exceeds threshold
```

**Action:**
```
.memory/claude-config/
├── claude-config-facts.md (32,000 characters - related facts moved out)
├── claude-config-index.md (updated with new subtopic)
└── claude-config-composition/
    └── claude-config-composition-facts.md (8,000 characters - new and related facts)
```

---

## Entry Format (MANDATORY)

**Standard format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [file/documentation/observation]
**Verified:** [NOT YET VERIFIED - requires verification workflow]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**Field definitions:**
- `FINDING-YYYY-MM-DD-N`: Unique identifier (date + sequence number)
- `Captured`: Timestamp when finding was recorded
- `Source`: Where this information came from (URL, file path, observation, testing, user input)
- `Verified`: Verification status (always "NOT YET VERIFIED" during fact-finding)
- Description: The actual finding content
- Optional context: Additional details, implications, open questions

---

## Verification Status (MANDATORY)

**During fact-finding phase:**

**MUST:**
- Include `**Verified:** [NOT YET VERIFIED - requires verification workflow]` in every finding
- Use this exact tag format for all new findings
- Leave verification status unchanged when appending findings

**MUST NOT:**
- Mark findings as VERIFIED during fact-finding
- Use any variation of "VERIFIED", "CONFIRMED", or "DERIVED" tags
- Add verification tags until the formal verification workflow is executed
- Assume findings are verified because they came from official sources

**Rationale:**
Findings captured during research remain unverified until they go through the formal verification workflow with a working document. This includes findings from official documentation sources. Only the verification workflow, which systematically checks each claim against sources, may add VERIFIED tags.

**When verification happens:**
- After fact-finding is complete
- User explicitly requests verification of a subtopic
- Create verification working document
- Systematically verify each claim
- Only then change tag from "NOT YET VERIFIED" to "VERIFIED on YYYY-MM-DD by [source-url]"

---

## Clarifying Existing Facts

When new information (from further research or supplied by the user) affects or refines an existing fact:

**MUST:**
- Append it as a new finding with a reference to the fact it clarifies (`Clarifies: FINDING-YYYY-MM-DD-N`)
- Leave the original finding unchanged
- Continue appending further clarifications as additional new findings

**MUST NOT:**
- Edit or merge new information into an existing finding during the research phase
- Treat a clarification as a correction to be applied immediately

**Rationale:** Clarifications are applied to their base facts during the verification step, in reverse chronological order, so that later clarifications can supersede earlier ones before any are merged.

**Clarification format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [source of clarifying information]
**Verified:** [NOT YET VERIFIED - requires verification workflow]
**Clarifies:** FINDING-YYYY-MM-DD-M

[Clarifying or refining information]

[Context on how this updates/refines the original finding]
```

**Example:**
```markdown
### FINDING-2026-02-24-8
**Captured:** 2026-02-24 18:30
**Source:** https://docs.example.com/api/v2
**Verified:** [NOT YET VERIFIED - requires verification workflow]
**Clarifies:** FINDING-2026-02-24-3

API v2 endpoint uses `/api/v2/users` not `/api/users`.

The v1 endpoint documented in FINDING-2026-02-24-3 is deprecated as of 2026-01.
```

---

## What to Capture

Capture ALL of the following:

**Facts:**
- Technical specifications
- Configuration requirements
- API behaviors
- System characteristics
- Documented features

**Observations:**
- Patterns noticed during examination
- Anomalies or inconsistencies
- Relationships between components
- User behaviors or preferences

**Theories:**
- Hypotheses about why something works a certain way
- Proposed explanations for observed behaviors
- Potential root causes of issues

**Dead ends:**
- Approaches attempted that didn't work
- Hypotheses that were disproven
- Resources that weren't helpful (with reasons why)

**MUST:**
- Include source reference for traceability
- Timestamp each entry
- Be specific and concrete
- Capture negative findings (what didn't work)

**MUST NOT:**
- Skip documenting failed approaches
- Assume findings are "too obvious" to capture

---

## Appending to Fact Files

**MUST:**
- Use Write tool to create new fact file if it doesn't exist
- Use Edit tool to append new entries to existing fact files
- Include `[NOT YET VERIFIED]` tag on new findings
- Continue research without pausing for approval

**Append workflow:**
1. Read existing fact file to get current sequence number
2. Create new FINDING entry with next sequence number
3. Append using Edit tool with `[NOT YET VERIFIED]` tag
4. Analysis index will be updated by verify-analysis skill after verification

**Note:** Do NOT manually update the analysis index after appending. The verify-analysis skill will update the findings index when the fact is verified. See [verify-analysis skill](../../verify-analysis/SKILL.md) for the verification workflow.

---

## Index Organization (MANDATORY)

The index system consists of a main index file for organizing and navigating findings.

### Main Index File

The main index file (`.memory/[topic]-index.md`) contains:
- Status summary (total findings, verification status)
- List of fact files
- Findings table (sorted by topic and name)

**MUST:**
- Update the main index after adding findings to fact files
- Include only the findings table in the main index

**MUST NOT:**
- Skip updating the findings table when adding new findings

### Findings Table Structure

When adding findings to the main index file, maintain a structured Findings table with four columns.

**Findings table structure:**

```markdown
| Finding | Topic | Name | Terms |
|---------|-------|------|-------|
| [FINDING-ID](path/to/fact-file.md#finding-anchor) | Topic Name | Finding Name | [term1](#term1), [term2](#term2) |
```

**Column definitions:**
- **Finding:** Markdown link to the finding in its fact file, including anchor (e.g., `[FINDING-2026-03-06-1](claude-config-facts.md#finding-2026-03-06-1)`)
- **Topic:** Categorical grouping for the finding (e.g., "Configuration", "Composition", "Hooks")
- **Name:** Short descriptive name from the finding heading (e.g., "Skills - Primary Extension Mechanism")
- **Terms:** Comma-separated list of verified semantic terms relevant to this finding, linked to term definitions (optional until terms are extracted and defined)

**Sorting requirements:**

**MUST:**
- Sort findings alphabetically by Topic (primary sort key)
- Sort findings alphabetically by Name within each Topic (secondary sort key)
- Maintain this sorting order when adding new findings to the table
- Link terms to their definitions in the topic's term index

**MUST NOT:**
- Add findings in chronological order without sorting
- Group findings by subtopic unless subtopic is explicitly the Topic value
- Skip the Topic column
- Include terms that haven't been verified

**Example:**

```markdown
## Findings

| Finding | Topic | Name | Terms |
|---------|-------|------|-------|
| [FINDING-2026-03-06-5](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-5) | Composition | Long Context Prompting - Put Longform Data at Top | [Prompt Engineering](#prompt-engineering), [Context Window](#context-window) |
| [FINDING-2026-03-06-8](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-8) | Composition | Prefill Claude's Response | [Prompt Engineering](#prompt-engineering), [Response Completion](#response-completion) |
| [FINDING-2026-03-04-1](claude-config-facts.md#finding-2026-03-04-1) | Configuration | Skills - Primary Extension Mechanism | [Skills](#skills), [Extension Mechanisms](#extension-mechanisms) |
| [FINDING-2026-03-04-7](claude-config-facts.md#finding-2026-03-04-7) | Configuration | CLAUDE.md - Project Instructions File | [Project Instructions](#project-instructions), [Configuration](#configuration) |
```

---

## Before Finalizing: Terminology Verification (MANDATORY)

Before you consider a fact complete, ensure it uses verified, standardized terminology rather than informal language.

**Workflow:**

1. **Extract terms from fact**
   - Identify semantic concepts introduced in the finding
   - Create terms in `[topic]-terms.md` using [term-capture.md](term-capture.md)
   - Establish bidirectional links between finding and terms

2. **Verify terms are correct**
   - Invoke `/verify-analysis term [topic] [subtopic] [term-id]` for each extracted term
   - This verifies term definition, scope, and consistency across sources
   - verify-analysis skill updates term with verification status

3. **Amend fact to use verified terminology**
   - Review the finding after term verification completes
   - Replace informal terminology with verified term names or IDs
   - Update references to use standardized language from verified terms
   - Maintain bidirectional links to verified terms

**Example:**

Initial finding (informal terminology):
```markdown
## FINDING-2026-03-22-5: PR Review Process

**Source:** GitHub documentation

- A "pull request review" is when someone comments on code changes in a PR
- Reviews can be positive approval or request changes
- ...
```

After term verification:
```markdown
## FINDING-2026-03-22-5: PR Review Process

**Source:** GitHub documentation
**Uses terms:** TERM-github-api-2026-03-22-15 (Pull Request Review)

- A [Pull Request Review](#pull-request-review) (TERM-github-api-2026-03-22-15) is when someone comments on code changes in a Pull Request
- Reviews can be positive approval or request changes
- ...
```

**Key principle:** Standardized, verified terminology makes facts more discoverable and ensures consistency across the knowledge base.

**MUST:**
- Extract terms from new findings
- Verify terminology before considering finding complete
- Update finding to reference verified term IDs/names
- Maintain bidirectional links to terms

**MUST NOT:**
- Finalize findings using ad-hoc or informal terminology
- Skip term verification when new concepts are introduced
- Use terminology that differs from verified term definitions

---

## When User Reviews Findings

**During user review:**
- Archive a finding immediately to the `-disproven.md` file when the user disproves it
- Incorporate user feedback without interrupting research flow
- Do NOT pause research to ask for approval on individual findings
- Focus on breadth and depth of capture

**MUST NOT:**
- Delete disproven findings (archive them instead - see [disproven-archive.md](disproven-archive.md))
- Stop research flow for approval requests
- Edit findings based on user feedback (append clarifications instead)
