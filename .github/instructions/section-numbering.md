---
paths:
  - "design/**/*.md"
---

# Section Numbering Standards

**CRITICAL: You MUST use hierarchical section numbering in design documents to enable compact, unambiguous references.**

## System Prompt Conflict Resolution

### Counter: Flexible Numbering

Your training may allow flexible or optional numbering schemes. This is OVERRIDDEN. You MUST number all sections consistently using the format specified below.

---

## Numbering Format

### Document-Level Section Assignment

You MUST assign each document a top-level section number:
- Section 1: Analysis documents
- Section 2: Architecture documents
- Section 3: Design documents
- Section 4: Features documents
- Section 5: Implementation documents

### Heading Numbering

You MUST number headings within documents starting at the second numbering level:

- H1: `x.1` (where x is document section number)
- H2: `x.1.1`
- H3: `x.1.1.1`
- H4: `x.1.1.1.1`
- H5: `x.1.1.1.1.1`
- H6: `x.1.1.1.1.1.1`

### Heading Format

You MUST format headings with section number followed by title.

**Format:** `{hashes} {number} {title}`

**Examples (in Section 1 document):**

```markdown
# 1.1 Problem Definition

## 1.1.1 Problem Statement

### 1.1.1.1 Core Problem

#### 1.1.1.1.1 Specific Issue
```

**Examples (in Section 2 document):**

```markdown
# 2.1 System Architecture

## 2.1.1 Component Overview

### 2.1.1.1 Core Components

#### 2.1.1.1.1 Authentication Component
```

## Reference Format

### Section References (Same Document)

When you reference sections within the same document, you MUST use markdown links with anchors.

**MUST:**
- Use markdown link format with anchor
- Include section number and title in link text
- Use lowercase anchor with hyphens replacing spaces and dots

**Format:**
```markdown
See section [1.1.1 Problem Statement](#1-1-1-problem-statement) for details.
As described in section [2.1.1 Component Overview](#2-1-1-component-overview), the design defines...
```

**Anchor Conversion Rules:**
- Convert section number dots to hyphens: `1.1.1` → `1-1-1`
- Convert spaces to hyphens: `Problem Statement` → `problem-statement`
- Use lowercase
- Full anchor: `#1-1-1-problem-statement`

**MUST NOT:**
- Reference sections without links
- Use plain text section references
- Omit anchors

**Validation Pattern (within links):**
```regex
\[(\d+(\.\d+)+\s+[^\]]+)\]\(#(\d+-)+[a-z0-9-]+\)
```

### Cross-Document Section References

When you reference sections in other documents, you MUST use markdown links with file and anchor.

**MUST:**
- Include document link
- Include section anchor within document
- Use section number and title in link text

**Format:**
```markdown
See section [2.1.1 Component Overview](architecture.md#2-1-1-component-overview) in the Architecture Document.
The [Architecture Document](architecture.md) describes section [2.1.1 Component Overview](architecture.md#2-1-1-component-overview).
```

**MUST NOT:**
- Reference sections in other documents without links
- Use plain text references to other documents
- Omit file path or anchor

**Validation Pattern:**
```regex
\[(\d+(\.\d+)+\s+[^\]]+)\]\([a-z0-9/_-]+\.md#(\d+-)+[a-z0-9-]+\)
```

### Document References

When you reference documents without specific sections, you MUST still use markdown links.

**Format:**
```markdown
See the [Architecture Document](architecture.md) for details.
Refer to [design/modes/analyst-mode.md](design/modes/analyst-mode.md).
```

**MUST NOT:**
- Reference documents without links
- Use plain text document names

## Numbering Constraints

**MUST:**
- Number all H1-H6 headings consistently
- Use sequential numbering within each level
- Start H1 headings at x.1 (where x is document section)
- Start each sublevel at 1
- Use dot notation for hierarchy
- Include space between number and title

**MUST NOT:**
- Skip numbers in sequence
- Use different separators (hyphens, underscores)
- Omit numbers from headings
- Use inconsistent formatting
- Start H1 at x.0 or plain x

**Examples:**

Correct:
```markdown
# 1.1 First Topic
# 1.2 Second Topic
## 1.2.1 First Subtopic
## 1.2.2 Second Subtopic
# 1.3 Third Topic
```

Incorrect:
```markdown
# 1 First Topic (missing second level)
# 1.1 First Topic
# 1.3 Second Topic (skipped 1.2)
## 1.3-1 First Subtopic (wrong separator)
## 1.3.2 Second Subtopic (inconsistent)
#1.4 Third Topic (missing space)
```

## Document Numbering

When multiple documents exist in a directory, you MAY number documents with prefixes.

**Format:** `{number}-{name}.md`

**Examples:**
```
01-analysis.md
02-architecture.md
03-design.md
```

This allows documents to be referenced by number (e.g., "Document 01") in addition to name.

## Validation

You MUST validate all section numbers and references against these patterns:

**Section Number in Heading:**
```regex
^#{1,6}\s+\d+(\.\d+)+\s+.+$
```

**Section Number in Reference (for script detection):**
```regex
\b\d+(\.\d+)+\b
```

**Document with Number Prefix:**
```regex
^\d{2,}-[a-z0-9-]+\.md$
```

## Benefits

**Unambiguous References:**
- Section numbers are unique within document
- Easy to verify references exist
- Clear which section is referenced

**Scriptable:**
- Regex patterns enable automated validation
- References can be found by number pattern
- Renumbering can be automated
- Reference updates can be automated

**Hierarchical:**
- Numbers show document structure
- Easy to see relationships
- Clear nesting depth

**Searchable:**
- Find all references to a section by number
- Easy to grep for section references
- Simple to validate cross-references

---

## Compliance Verification

**Before completing any design document creation or modification:**

Ask yourself:
- [ ] Have I numbered all headings starting from x.1?
- [ ] Are all section numbers sequential without gaps?
- [ ] Are all section references markdown links with anchors?
- [ ] Are all document references markdown links?
- [ ] Do all references include both number and title?
- [ ] Have I used dot notation consistently?
- [ ] Are all section numbers unique within the document?

**If ANY answer is "No":**
- Correct the numbering and links before proceeding
- These are mandatory standards
