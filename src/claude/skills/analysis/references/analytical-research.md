# Analytical Research Workflow

**This file is loaded when: The agent needs to examine artifacts systematically and synthesise findings into analysis.**

---

## Embedded Rules

### Documentation-First (MANDATORY)

**MUST:**
- Search for and reference official documentation sources
- Verify information against authoritative sources before recording
- Use two-stage text search: keyword search → direct file examination
- Read documentation directly from files, not from cached context

**MUST NOT:**
- Rely solely on general knowledge or training data
- Report information unavailable after only keyword search
- Use cached documentation content without re-reading

---

## When to Use This Workflow

- Examining codebase systematically
- Analysing project artifacts (commits, issues, documentation)
- Capturing research findings with proper citation
- Creating evidence-based technical analysis
- Any task requiring systematic investigation and synthesis

---

## Workflow Steps

1. **Clarify scope**: Ask which projects/domains to examine and what to look for

2. **Confirm topic slug**: Confirm the topic slug with the user (e.g., `ai-problems-analysis`); this is used for file naming and operation logging throughout this work

3. **Index artifacts**: Create an index of all relevant artifacts (commits, issues, code, documentation)

4. **Systematic examination**: Examine each artifact using Read, Grep, Glob tools

5. **Capture findings**: Capture ALL findings in fact file(s):
   - Main topic: `.memory/[topic]-facts.md`
   - Subtopics: `.memory/[topic]-[subtopic]-facts.md`
   - Capture facts, observations, theories, hypotheses, dead ends

6. **Maintain index**: Track all fact files (main topic and subtopics) in the single main topic index file `.memory/[topic]/[topic]-index.md` - never create per-subtopic indexes

7. **Handle disproven findings**: When user disproves a finding, archive it immediately to `-disproven.md` file

8. **Keep building**: Keep building fact files without pausing for approval

9. **Wait for request**: Do NOT create analysis until the user explicitly requests one

---

## Fact Capture Format

**Entry format:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [file/documentation/observation]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**When to create subtopic files:**

When a topic has distinct areas requiring separate fact files, create `.memory/[topic]-[subtopic]-facts.md`. The main topic prefix is mandatory.

**Example structure:**
```
.memory/
├── ai-problems-analysis-facts.md                    # Main topic
├── ai-problems-analysis-hallucination-facts.md     # Subtopic
├── ai-problems-analysis-overeagerness-facts.md     # Subtopic
└── ai-problems-analysis-index.md                    # Index linking all
```

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

Clarifications are applied to their base facts during the verification step, in reverse chronological order, so that later clarifications can supersede earlier ones before any are merged.

**Example:**
```markdown
### FINDING-2026-02-24-5
**Captured:** 2026-02-24 16:20
**Source:** User clarification
**Clarifies:** FINDING-2026-02-23-3

The API endpoint supports rate limiting of 100 requests/minute, not 60 as initially documented.

Confirmed via testing in production environment.
```

---

## File Boundaries (MANDATORY)

**During research phase:**

- **Fact files** (`.memory/[topic]-facts.md` or `.memory/[topic]-[subtopic]-facts.md`) — the ONLY files you write to during research
- **Pending analysis** (`.memory/[NAME]-PENDING.md`) — read-only during research; written only once when user requests final output
- **Final output** (root or specified location) — written only after user approval of pending analysis

**MUST NOT:**
- Write new findings to any `-PENDING.md` or draft output file
- Edit any pending analysis file during the research phase

---

## Index Maintenance

After appending to fact files or archiving disproven findings, update `.memory/[topic]-index.md`.

**Index format:**
```markdown
# [topic] Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Fact Files

- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - [Brief description]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[topic]-facts-disproven.md](.memory/[topic]-facts-disproven.md) (N findings)

- [.memory/[topic]-[subtopic]-facts.md](.memory/[topic]-[subtopic]-facts.md) - [Brief description]
  - Last updated: YYYY-MM-DD HH:MM

---

## Analysis Outputs

- [`[ANALYSIS-NAME].md`]([ANALYSIS-NAME].md) - [Description]
  - Generated: YYYY-MM-DD HH:MM
  - Sources: [list of fact files used]
```

---

## Final Output Creation

Do NOT create final output until the user explicitly requests it.

Final output is an analysis document with citations (e.g., `ai-programming-problems-analysis.md`).

When user requests final output:
1. Check research completeness (see [final-output.md](final-output.md))
2. Run [verify-memory-facts](../../../src/claude/prompts/verify-memory-facts.md) on all fact files
3. Apply clarifications to base facts before verification
4. Synthesise verified findings into coherent narrative
5. Present draft in `.memory/[ANALYSIS-NAME]-PENDING.md`
6. After user approval, create final analysis in specified location
