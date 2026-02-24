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

**Main topic file:**
```
.memory/[topic]-facts.md
```

**Subtopic files (when topic has distinct areas):**
```
.memory/[topic]-[subtopic]-facts.md
```

The main topic prefix is mandatory for subtopic files.

**Example:**
```
.memory/ai-problems-analysis-facts.md
.memory/ai-problems-analysis-hallucination-facts.md
.memory/ai-problems-analysis-overeagerness-facts.md
```

---

## Entry Format (MANDATORY)

**Standard format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [file/documentation/observation]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**Field definitions:**
- `FINDING-YYYY-MM-DD-N`: Unique identifier (date + sequence number)
- `Captured`: Timestamp when finding was recorded
- `Source`: Where this information came from (URL, file path, observation, testing, user input)
- Description: The actual finding content
- Optional context: Additional details, implications, open questions

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
**Clarifies:** FINDING-YYYY-MM-DD-M

[Clarifying or refining information]

[Context on how this updates/refines the original finding]
```

**Example:**
```markdown
### FINDING-2026-02-24-8
**Captured:** 2026-02-24 18:30
**Source:** https://docs.example.com/api/v2
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
