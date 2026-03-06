# Fact Capture Guidelines

**This file is loaded when: The agent needs detailed guidance on capturing research findings in fact files.**

---

## Embedded Rules

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

Organise topics and subtopics in folders containing the main file and all supplementary files. Use recursive structure: subtopics are folders within the topic folder.

**Structure:**
```
.memory/[topic]/
├── [topic]-facts.md              (main topic fact file)
├── [topic]-index.md              (topic index)
├── [topic]-log.md                (operation log)
├── [topic]-[subtopic1]/          (subtopic folder)
│   ├── [topic]-[subtopic1]-facts.md
│   ├── [topic]-[subtopic1]-verification-working.md
│   └── [topic]-[subtopic1]-archive.md
└── [topic]-[subtopic2]/          (subtopic folder)
    ├── [topic]-[subtopic2]-facts.md
    ├── [topic]-[subtopic2]-verification-working.md
    └── [other supplementary files]
```

**MUST:**
- Create a folder for each topic: `.memory/[topic]/`
- Create a folder for each subtopic: `.memory/[topic]/[topic]-[subtopic]/`
- Place all topic-level files (main facts, index, log) directly in the topic folder
- Place all subtopic-level files (subtopic facts, verification docs, archives) in the subtopic folder
- Use the full `[topic]-[subtopic]` prefix for subtopic folder names and file names
- Apply this structure recursively for nested subtopics

**MUST NOT:**
- Create flat file structures in `.memory/` root for topics with multiple files
- Place subtopic fact files directly in the topic folder alongside the main fact file
- Scatter topic or subtopic files across multiple folders
- Place subtopic files outside their designated subtopic folder

**Example:**
```
.memory/claude-config/
├── claude-config-facts.md
├── claude-config-index.md
├── claude-config-log.md
├── claude-config-skills/
│   ├── claude-config-skills-facts.md
│   ├── claude-config-skills-verification-working.md
│   └── claude-config-skills-archive.md
├── claude-config-hooks/
│   ├── claude-config-hooks-facts.md
│   └── claude-config-hooks-verification-working.md
└── claude-config-composition/
    ├── claude-config-composition-facts.md
    └── claude-config-composition-verification-working.md
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
5. **Update index:** Add the new subtopic to the topic index file
6. **Update links:** Ensure all cross-references use correct relative paths

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
**Keywords:** keyword1, keyword2, keyword3
**Verified:** [NOT YET VERIFIED - requires verification workflow]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**Field definitions:**
- `FINDING-YYYY-MM-DD-N`: Unique identifier (date + sequence number)
- `Captured`: Timestamp when finding was recorded
- `Source`: Where this information came from (URL, file path, observation, testing, user input)
- `Keywords`: Comma-separated subject area tags for categorisation and search (required)
- `Verified`: Verification status (always "NOT YET VERIFIED" during fact-finding)
- Description: The actual finding content
- Optional context: Additional details, implications, open questions

---

## Keywords (MANDATORY)

Keywords help categorise findings by subject area and enable searching across related facts. You must include keywords in every finding.

**Keyword selection:**
- Select keywords that describe the technical domains or topics the finding covers
- Choose keywords that group related findings thematically
- Include keywords that enable cross-referencing

**Keyword selection guidelines:**

**MUST:**
- Include keywords in every finding
- Reuse existing keywords where applicable before creating new ones
- Use lowercase for consistency
- Use singular form (e.g., "configuration" not "configurations")
- Limit to 3-5 keywords per finding
- Choose keywords that describe subject areas, not actions
- Use comma-separated format with space after comma

**MUST NOT:**
- Omit keywords from any finding
- Create new keywords when existing keywords serve the same purpose
- Use full sentences or phrases as keywords
- Duplicate information already in the finding heading
- Use more than 5 keywords (indicates lack of focus)
- Use uppercase or mixed case

**Keyword categories:**

Choose keywords from these categories when applicable:
- **Technology/tool names:** docker, api, webhook, xml, yaml
- **Concepts:** authentication, caching, validation, composition, configuration
- **Domains:** security, performance, testing, deployment
- **Component types:** agent, skill, hook, rule, command, plugin
- **Patterns:** workflow, pattern, structure, format

**Examples:**

```markdown
**Keywords:** prompt, composition, xml, structure
```

```markdown
**Keywords:** hook, automation, event, shell
```

```markdown
**Keywords:** verification, testing, validation
```

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
**Keywords:** keyword1, keyword2
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
**Keywords:** api, endpoint, deprecation
**Verified:** [NOT YET VERIFIED - requires verification workflow]
**Clarifies:** FINDING-2026-02-24-3

API v2 endpoint uses `/api/v2/users` not `/api/users`.

The v1 endpoint documented in FINDING-2026-02-24-3 is deprecated as of 2026-01.
```

---

## File Boundaries (MANDATORY)

**During research phase, you may write ONLY to:**
- **Fact files:** `.memory/[topic]-facts.md` or `.memory/[topic]-[subtopic]-facts.md`

**During research phase, these are READ-ONLY:**
- **Pending analysis:** `.memory/[NAME]-PENDING.md` — written only once when user requests final output
- **Final output:** root or specified location — written only after user approval of pending analysis

**MUST NOT:**
- Write new findings to any `-PENDING.md` or draft output file — these are output artifacts, not research records
- Edit any pending analysis file during the research phase, even to "update" it with new findings

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
- Filter findings during capture (filtering happens during synthesis)
- Skip documenting failed approaches
- Assume findings are "too obvious" to capture

---

## Appending to Fact Files

**MUST:**
- Use Write tool to create new fact file if it doesn't exist
- Use Edit tool to append new entries to existing fact files
- Update analysis index after appending
- Continue research without pausing for approval

**Append workflow:**
1. Read existing fact file to get current sequence number
2. Create new FINDING entry with next sequence number
3. Append using Edit tool
4. Update index with new timestamp

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
