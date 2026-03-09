# Analysis Index Maintenance

**This file is loaded when: The agent needs to update or create the analysis index file.**

---

## Embedded Rules

### Always Update After Changes (MANDATORY)

**MUST:**
- Update index after appending to fact files
- Update index after archiving disproven findings
- Update keyword counts when findings are added or archived
- Update findings table when findings are added or archived
- Include file paths and last updated timestamps
- Keep index concise and navigable
- Add ALL subtopic findings to the main topic index and keyword indexes

**MUST NOT:**
- Skip index updates
- Leave index out of sync with fact files
- Leave keyword counts out of sync with findings
- Leave findings table out of sync with fact files
- Create separate index files for subtopics
- Create separate keyword index files for subtopics

---

## Index File Location

```
.memory/[topic]/[topic]-index.md
```

**Example:**
```
.memory/ai-problems-analysis/ai-problems-analysis-index.md
```

---

## Index Structure (MANDATORY)

```markdown
# [Topic] Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Fact Files

- [[topic]-facts.md]([topic]-facts.md) - [Brief description of research scope]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [[topic]-facts-disproven.md]([topic]-facts-disproven.md) (N findings)

- [[topic]-[subtopic]-facts.md]([topic]-[subtopic]/[topic]-[subtopic]-facts.md) - [Brief description]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [[topic]-[subtopic]-facts-disproven.md]([topic]-[subtopic]/[topic]-[subtopic]-facts-disproven.md) (N findings)

[... additional fact files ...]

---

## Keywords

Browse findings by keyword:

- [Keywords A-D]([topic]-index-keywords-a-d.md) - X keywords
- [Keywords E-L]([topic]-index-keywords-e-l.md) - X keywords
- [Keywords M-P]([topic]-index-keywords-m-p.md) - X keywords
- [Keywords Q-S]([topic]-index-keywords-q-s.md) - X keywords
- [Keywords T-Z]([topic]-index-keywords-t-z.md) - X keywords

**Total:** N unique keywords across all findings

---

## Findings

| Finding | Topic | Name | Keywords |
|---------|-------|------|----------|
| [FINDING-YYYY-MM-DD-N]([topic]-facts.md#finding-yyyy-mm-dd-n) | Topic Name | Finding Name | keyword1, keyword2, keyword3 |
| [FINDING-YYYY-MM-DD-M]([topic]-[subtopic]/[topic]-[subtopic]-facts.md#finding-yyyy-mm-dd-m) | Topic Name | Another Finding | keyword1, keyword4 |

[... all findings sorted alphabetically by topic (primary), then name (secondary) ...]

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
   - Update keyword index pages with new keywords or add findings to existing keyword sections
   - Add new row to Findings table in alphabetically sorted position (by Topic, then Name)
   - Update total keyword count in main index Keywords section

2. **Creating new subtopic file**
   - Add new entry in "Fact Files" section in the main topic index
   - Include brief description of subtopic scope
   - Update main topic keyword index pages with any new keywords from the subtopic file
   - Add all findings from new subtopic file to main topic Findings table (sorted by Topic, then Name)
   - Update total keyword count in main topic index Keywords section
   - **DO NOT create a separate index for the subtopic** - all subtopic findings go into the main topic index

3. **Archiving disproven finding**
   - Add or update "Disproven:" line with count
   - If it's the first disproven finding, add the line
   - If archive already exists, increment the count
   - Remove finding from keyword index pages
   - Remove finding from Findings table
   - Update total keyword count if keywords are no longer used

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

- [[topic]-facts.md]([topic]-facts.md) - [One-sentence description]
  - Last updated: YYYY-MM-DD HH:MM

---

## Keywords

Browse findings by keyword:

- [Keywords A-Z]([topic]-index-keywords.md) - N keywords

**Total:** N unique keywords across all findings

---

## Findings

| Finding | Topic | Name | Keywords |
|---------|-------|------|----------|
| [FINDING-YYYY-MM-DD-1]([topic]-facts.md#finding-yyyy-mm-dd-1) | Topic Name | Finding Name | keyword1, keyword2 |

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

- [[topic]-facts.md]([topic]-facts.md) - Overview and cross-cutting findings
  - Last updated: YYYY-MM-DD HH:MM

### Subtopics

- [[topic]-hallucination-facts.md]([topic]-hallucination/[topic]-hallucination-facts.md) - Hallucination and dishonesty problems
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [[topic]-hallucination-facts-disproven.md]([topic]-hallucination/[topic]-hallucination-facts-disproven.md) (3 findings)

- [[topic]-overeagerness-facts.md]([topic]-overeagerness/[topic]-overeagerness-facts.md) - Overeagerness and proactivity issues
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

## Keyword Index Files (MANDATORY)

Keyword index files are separate files linked from the main index. Each file covers an alphabetical range of keywords. Small topics may use a single A-Z file; larger topics split across multiple files (A-D, E-L, M-P, Q-S, T-Z).

**File naming:**
```
[topic]-index-keywords.md              (single file for small topics)
[topic]-index-keywords-a-d.md         (split files for large topics)
[topic]-index-keywords-e-l.md
[topic]-index-keywords-m-p.md
[topic]-index-keywords-q-s.md
[topic]-index-keywords-t-z.md
```

**MUST:**
- List keywords in alphabetical order within the file
- Include count of findings using each keyword
- Update counts when appending findings with keywords
- Update counts when archiving disproven findings
- Use bold formatting for keywords
- Update the keyword count on each file's link in the main index when counts change

**MUST NOT:**
- List keywords inline in the main index file — use keyword index files only
- List keywords without counts
- Include keywords with zero findings
- Create keyword index files for subtopics — all keywords go in the main topic's keyword files

**Format for keyword index files:**
```markdown
# [Topic] — Keywords [Range]

**N keywords**

---

- **api** (12 findings)
- **authentication** (8 findings)
- **configuration** (15 findings)
- **hook** (6 findings)
- **prompt** (23 findings)
- **skill** (10 findings)
- **validation** (9 findings)
- **workflow** (14 findings)
```

**When updating keyword counts:**

1. **New finding added:** Count keywords in the new finding and increment each keyword's count (add keyword if not present)
2. **Finding archived:** Count keywords in the archived finding and decrement each keyword's count (remove keyword if count reaches zero)
3. **Finding clarified:** No change to counts (clarifications reference existing findings but don't replace them)

---

## Findings Table (MANDATORY)

List all findings from the topic and all subtopics in a table format, sorted alphabetically by finding name, then by keywords.

**MUST:**
- Include three columns: Finding (ID as link), Name (title), Keywords (alphabetically ordered)
- Link Finding column to the actual finding heading using anchor syntax
- Sort findings alphabetically by Name column
- When names are identical, sort by Keywords column (alphabetically)
- Update table when appending findings
- Update table when archiving findings (remove archived findings)
- List keywords in alphabetical order within each row

**MUST NOT:**
- Omit findings table from index
- Include findings without all three columns
- List findings in unsorted order
- Include archived findings in the table

**Table Format:**
```markdown
## Findings

| Finding | Name | Keywords |
|---------|------|----------|
| [FINDING-2026-03-04-12](#finding-2026-03-04-12) | API Authentication Methods | api, authentication, security |
| [FINDING-2026-03-04-15](#finding-2026-03-04-15) | CLAUDE.md Locations and Scope | configuration, documentation, scope |
| [FINDING-2026-03-04-8](#finding-2026-03-04-8) | Hook Event Types | automation, event, hook |
```

**Sorting rules:**
1. Sort primarily by Name (alphabetical, case-insensitive)
2. If names match, sort by Keywords (alphabetical comparison of keyword strings)
3. Finding ID is for reference only, not used for sorting

**When updating findings table:**

1. **New finding added:** Add row in alphabetically correct position by name and keywords
2. **Finding archived:** Remove row from table
3. **Keywords changed:** Re-sort if keyword order affects alphabetical position

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
   - New finding added?
   - Finding archived?
   - Keywords added or removed from findings?
   - Keyword counts changed?
   - Disproven count changed?
   - New analysis output created?

3. **Update index** using Edit tool:
   - Modify only the relevant sections
   - Update keyword counts in Keywords section
   - Update Findings table (add/remove rows, maintain alphabetical sort)
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

## Keywords

Browse findings by keyword:

- [Keywords A-D](ai-problems-analysis-index-keywords-a-d.md) - 14 keywords
- [Keywords E-L](ai-problems-analysis-index-keywords-e-l.md) - 8 keywords
- [Keywords M-P](ai-problems-analysis-index-keywords-m-p.md) - 6 keywords
- [Keywords Q-S](ai-problems-analysis-index-keywords-q-s.md) - 4 keywords
- [Keywords T-Z](ai-problems-analysis-index-keywords-t-z.md) - 5 keywords

**Total:** 37 unique keywords across all findings

---

## Findings

| Finding | Name | Keywords |
|---------|------|----------|
| [FINDING-2026-02-24-3](#finding-2026-02-24-3) | Attention Mechanism Limitations | context, performance, training |
| [FINDING-2026-02-24-7](#finding-2026-02-24-7) | Behavioral Training Artifacts | behavioral, pattern, training |
| [FINDING-2026-02-24-1](#finding-2026-02-24-1) | Confidence Calibration Issues | accuracy, hallucination, verification |
| [FINDING-2026-02-23-5](#finding-2026-02-23-5) | Context Window Management | context, memory, performance |
| [FINDING-2026-02-24-9](#finding-2026-02-24-9) | False Positive Patterns | accuracy, pattern, verification |

---

## Analysis Outputs

- [`ai-programming-problems-analysis.md`](ai-programming-problems-analysis.md) - Comprehensive analysis of AI coding assistant problems
  - Generated: 2026-02-24 15:45
  - Sources: ai-problems-analysis-facts.md, ai-problems-analysis-hallucination-facts.md, ai-problems-analysis-overeagerness-facts.md, ai-problems-analysis-amnesia-facts.md
```
