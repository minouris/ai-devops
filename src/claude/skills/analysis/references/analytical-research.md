# Analytical Research Workflow

**This file is loaded when: You need to examine artifacts systematically and capture research findings.**

---

## Embedded Rules

### Two-Stage Text Search (MANDATORY)

When searching for information within artifacts and documentation, use a two-stage approach before concluding that information is unavailable.

**Stage 1 — Keyword search:**
- Use Grep or search tools as the initial approach
- Try multiple related terms, synonyms, and variations
- Search for feature names, configuration keys, code patterns

**If Stage 1 yields no results or only false positives, proceed to Stage 2:**

**Stage 2 — Direct file examination:**
- Read the full relevant files or sections directly using Read tool
- Design rationales, configuration logic, and architectural decisions are frequently expressed in natural language comments
- Do NOT report that information cannot be found until Stage 2 has been completed

**MUST NOT:**
- Report information as unavailable after only a keyword search
- Treat search/grep returning zero results as confirmation that information does not exist
- Skip file examination when keyword search yields no results

---

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

## Index Maintenance

After appending to fact files or archiving disproven findings, update `.memory/[topic]/[topic]-index.md`.

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
```
