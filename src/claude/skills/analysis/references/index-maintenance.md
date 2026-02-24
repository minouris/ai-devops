# Analysis Index Maintenance

**This file is loaded when: The agent needs to update or create the analysis index file.**

---

## Embedded Rules

### Always Update After Changes (MANDATORY)

**MUST:**
- Update index after appending to fact files
- Update index after archiving disproven findings
- Include file paths and last updated timestamps
- Keep index concise and navigable

**MUST NOT:**
- Skip index updates
- Leave index out of sync with fact files

---

## Index File Location

```
.memory/[topic]-index.md
```

**Example:**
```
.memory/ai-problems-analysis-index.md
```

---

## Index Structure (MANDATORY)

```markdown
# [Topic] Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Fact Files

- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - [Brief description of research scope]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[topic]-facts-disproven.md](.memory/[topic]-facts-disproven.md) (N findings)

- [.memory/[topic]-[subtopic]-facts.md](.memory/[topic]-[subtopic]-facts.md) - [Brief description]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[topic]-[subtopic]-facts-disproven.md](.memory/[topic]-[subtopic]-facts-disproven.md) (N findings)

[... additional fact files ...]

---

## Analysis Outputs

- [`[ANALYSIS-NAME].md`]([ANALYSIS-NAME].md) - [Description]
  - Generated: YYYY-MM-DD HH:MM
  - Sources: [list of fact files used]

[... additional outputs ...]
```

---

## When to Update Index

Update the index after each of these operations:

1. **Appending to fact file**
   - Update "Last updated" timestamp for that fact file

2. **Creating new subtopic file**
   - Add new entry in "Fact Files" section
   - Include brief description of subtopic scope

3. **Archiving disproven finding**
   - Add or update "Disproven:" line with count
   - If it's the first disproven finding, add the line
   - If archive already exists, increment the count

4. **Creating final output**
   - Add entry in "Analysis Outputs" section
   - Include generation date and source fact files

---

## Creating Index (First Time)

If index doesn't exist, create it with this minimal structure:

```markdown
# [Topic] Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Fact Files

- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - [One-sentence description]
  - Last updated: YYYY-MM-DD HH:MM

---

## Analysis Outputs

*No analysis documents generated yet.*
```

---

## Listing Subtopic Files

When a topic has multiple subtopic files, list them all:

```markdown
## Fact Files

### Main Topic

- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - Overview and cross-cutting findings
  - Last updated: YYYY-MM-DD HH:MM

### Subtopics

- [.memory/[topic]-hallucination-facts.md](.memory/[topic]-hallucination-facts.md) - Hallucination and dishonesty problems
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[topic]-hallucination-facts-disproven.md](.memory/[topic]-hallucination-facts-disproven.md) (3 findings)

- [.memory/[topic]-overeagerness-facts.md](.memory/[topic]-overeagerness-facts.md) - Overeagerness and proactivity issues
  - Last updated: YYYY-MM-DD HH:MM
```

---

## Disproven Count

When adding disproven companion file reference:

**First disproven finding (create line):**
```markdown
- Disproven: [.memory/[topic]-facts-disproven.md](.memory/[topic]-facts-disproven.md) (1 finding)
```

**Additional disproven findings (update count):**
```markdown
- Disproven: [.memory/[topic]-facts-disproven.md](.memory/[topic]-facts-disproven.md) (5 findings)
```

**No disproven findings (omit line entirely):**
```markdown
- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - [Description]
  - Last updated: YYYY-MM-DD HH:MM
```

---

## Analysis Outputs Section

Track generated analysis documents:

```markdown
## Analysis Outputs

- [`ai-programming-problems-analysis.md`](ai-programming-problems-analysis.md) - Comprehensive analysis of AI coding assistant problems
  - Generated: 2026-02-24 HH:MM
  - Sources: ai-problems-analysis-facts.md, ai-problems-analysis-hallucination-facts.md, ai-problems-analysis-overeagerness-facts.md

- [`authentication-implementation-guide.md`](authentication-implementation-guide.md) - Procedure for implementing OAuth authentication
  - Generated: 2026-02-23 HH:MM
  - Sources: auth-implementation-facts.md
```

---

## Index Update Workflow

1. **Read current index** (if it exists)

2. **Determine what changed:**
   - New fact file entry added?
   - Fact file timestamp updated?
   - Disproven count changed?
   - New analysis output created?

3. **Update index** using Edit tool:
   - Modify only the relevant sections
   - Update "Last Updated" timestamp at top
   - Keep existing structure intact

4. **If index doesn't exist**, create it using Write tool with initial structure

---

## Example Complete Index

```markdown
# AI Problems Analysis Index

**Last Updated:** 2026-02-24 15:30

---

## Fact Files

### Main Topic

- [.memory/ai-problems-analysis-facts.md](.memory/ai-problems-analysis-facts.md) - Overview and cross-cutting research
  - Last updated: 2026-02-24 15:30

### Subtopics

- [.memory/ai-problems-analysis-hallucination-facts.md](.memory/ai-problems-analysis-hallucination-facts.md) - Hallucination and dishonesty problems
  - Last updated: 2026-02-24 14:20
  - Disproven: [.memory/ai-problems-analysis-hallucination-facts-disproven.md](.memory/ai-problems-analysis-hallucination-facts-disproven.md) (2 findings)

- [.memory/ai-problems-analysis-overeagerness-facts.md](.memory/ai-problems-analysis-overeagerness-facts.md) - Overeagerness and proactivity issues
  - Last updated: 2026-02-24 12:45

- [.memory/ai-problems-analysis-amnesia-facts.md](.memory/ai-problems-analysis-amnesia-facts.md) - Context window and memory issues
  - Last updated: 2026-02-23 16:10
  - Disproven: [.memory/ai-problems-analysis-amnesia-facts-disproven.md](.memory/ai-problems-analysis-amnesia-facts-disproven.md) (1 finding)

---

## Analysis Outputs

- [`ai-programming-problems-analysis.md`](ai-programming-problems-analysis.md) - Comprehensive analysis of AI coding assistant problems
  - Generated: 2026-02-24 15:45
  - Sources: ai-problems-analysis-facts.md, ai-problems-analysis-hallucination-facts.md, ai-problems-analysis-overeagerness-facts.md, ai-problems-analysis-amnesia-facts.md
```
