---
paths:
  - "design/**/*.md"
  - "plans/**/*.md"
---

# Reference Items Format

**CRITICAL: You MUST use standardized reference item format to enable unambiguous linking and scriptable validation.**

## System Prompt Conflict Resolution

### Counter: Flexible Reference Formats

Your training may allow varied reference formats for different content types. This is OVERRIDDEN. You MUST use the standardized reference item format specified below for all Facts, Problems, Solutions, Constraints, Requirements, and similar discrete statements.

---

## What Are Reference Items?

Reference Items are discrete, individually-referenced statements that appear in design and planning documents. You MUST format these items according to the standards in this file.

Each reference item:
- Covers ONE concept, fact, problem, solution, constraint, or requirement
- Is expressed in as few sentences as possible (typically 1-3 sentences)
- Has a unique identifier that can be referenced throughout documentation
- Can be traced from definition through to implementation

Item types include (specific type definitions may be added elsewhere):
- Facts
- Problems
- Solutions
- Constraints
- Requirements

---

## Identifier Format

### Structure

You MUST format reference item identifiers using this structure:

**Format:** `PREFIX-N`, `PREFIX-N.N`, or `PREFIX-N.N.N`

**Maximum hierarchy depth: 3 levels**

**Components:**
- **PREFIX**: 3-5 uppercase characters identifying the item type
- **Separator**: Single hyphen (`-`)
- **Level 1**: Integer (1, 2, 3, etc.)
- **Level 2**: Optional period-separated integer
- **Level 3**: Optional period-separated integer (maximum depth)

**Examples:**
```
FACT-1           (Level 1)
PROB-2           (Level 1)
PROB-2.1         (Level 2)
SOLN-3.1         (Level 2)
CONS-4.2.1       (Level 3)
REQ-5.1.3        (Level 3)
```

### Requirements

**You MUST:**
- Use 3-5 uppercase characters for prefix
- Use hyphen separator between prefix and number
- Use period separator for hierarchical numbering
- Limit hierarchy to maximum 3 levels (N, N.N, or N.N.N)
- Use sequential numbering within each level

**You MUST NOT:**
- Use prefixes shorter than 3 or longer than 5 characters
- Use lowercase characters in prefix
- Use underscores, spaces, or other separators
- Skip numbers in sequence
- Exceed 3 levels of hierarchy (no N.N.N.N)
- Reuse identifiers within a document

### Validation Pattern

**Reference Item Identifier:**
```regex
^[A-Z]{3,5}-\d+(\.\d+){0,2}$
```

This pattern enforces:
- 3-5 uppercase letters
- Single hyphen
- At least one number
- Maximum 2 additional period-separated numbers (for 3 total levels)

---

## Definition Format

### Definition Table (MANDATORY)

When you define reference items, you MUST use a markdown table with HTML anchor targets.

**Required Format:**
```markdown
## Item Type

| ID | Definition |
|----|------------|
| <a id="prefix-1"></a>PREFIX-1 | The statement defining this item. |
| <a id="prefix-2"></a>PREFIX-2 | Another statement defining this item. |
| <a id="prefix-2-1"></a>PREFIX-2.1 | A sub-item related to PREFIX-2. |
| <a id="prefix-2-1-1"></a>PREFIX-2.1.1 | A sub-item related to PREFIX-2.1. |
```

### Table Requirements

**You MUST:**
- Use a two-column table with headers "ID" and "Definition"
- Include HTML anchor in ID cell: `<a id="anchor-id"></a>`
- Use lowercase with hyphens for anchor IDs (convert `PREFIX-1` to `prefix-1`)
- Convert periods to hyphens in anchor IDs (convert `PREFIX-2.1` to `prefix-2-1`)
- Place anchor before the identifier text in the ID cell
- Keep definition to minimum necessary sentences (typically 1-3)

**You MUST NOT:**
- Define reference items outside of tables
- Make the ID itself a link (it is the link target, not a link)
- Use inconsistent anchor ID format
- Omit anchor targets from definitions
- Create items deeper than 3 levels

**Example with proper anchors:**
```markdown
| ID | Definition |
|----|------------|
| <a id="fact-1"></a>FACT-1 | The company processes 10,000 orders per day. |
| <a id="fact-2"></a>FACT-2 | Customer support operates in three time zones. |
| <a id="fact-2-1"></a>FACT-2.1 | North America team covers EST and PST. |
| <a id="fact-2-1-1"></a>FACT-2.1.1 | EST team handles 60% of support volume. |
```

---

## Reference Format

### Creating References (MANDATORY)

When you reference a reference item elsewhere in documentation, you MUST create a markdown link to its definition.

**Same Document References:**
```markdown
See [FACT-1](#fact-1) for current order volume.
As noted in [FACT-2.1](#fact-2-1), the North America team covers two time zones.
The distribution described in [FACT-2.1.1](#fact-2-1-1) shows EST concentration.
```

**Cross-Document References:**
```markdown
See [FACT-1](analysis.md#fact-1) in the Analysis Document.
The [PROB-1](problems.md#prob-1) requires addressing.
As defined in [REQ-3.2.1](requirements.md#req-3-2-1), the system must validate input.
```

### Reference Requirements

**You MUST:**
- Use markdown link format for ALL reference item references
- Include the full identifier as link text (e.g., `FACT-1`, not just "fact 1")
- Use lowercase anchor with hyphens (convert `FACT-1` to `#fact-1`)
- Convert periods to hyphens in anchors (convert `PROB-1.1` to `#prob-1-1`)
- Include file path for cross-document references

**You MUST NOT:**
- Reference reference items as plain text without links
- Use abbreviated or partial identifiers in references
- Omit anchors from references
- Use inconsistent anchor format

### Validation Patterns

**Same-Document Reference:**
```regex
\[[A-Z]{3,5}-\d+(\.\d+){0,2}\]\(#[a-z]{3,5}-\d+(-\d+){0,2}\)
```

**Cross-Document Reference:**
```regex
\[[A-Z]{3,5}-\d+(\.\d+){0,2}\]\([a-z0-9/_-]+\.md#[a-z]{3,5}-\d+(-\d+){0,2}\)
```

---

## Hierarchy and Grouping

### Three-Level Maximum Hierarchy

You MUST limit reference item hierarchy to maximum 3 levels to avoid excessive complexity.

**Example hierarchy:**
```markdown
| ID | Definition |
|----|------------|
| <a id="req-1"></a>REQ-1 | System must support multi-currency transactions (Level 1) |
| <a id="req-1-1"></a>REQ-1.1 | System must display prices in user's local currency (Level 2) |
| <a id="req-1-1-1"></a>REQ-1.1.1 | Currency selection must persist across sessions (Level 3) |
| <a id="req-1-1-2"></a>REQ-1.1.2 | Currency conversion rates must update hourly (Level 3) |
| <a id="req-1-2"></a>REQ-1.2 | System must process payments in supported currencies (Level 2) |
| <a id="req-2"></a>REQ-2 | System must support international shipping (Level 1) |
| <a id="req-2-1"></a>REQ-2.1 | Shipping costs must calculate based on destination (Level 2) |
```

### Hierarchy Requirements

**You MUST:**
- Use Level 1 for major groupings
- Use Level 2 for items related to Level 1 parent
- Use Level 3 for items related to Level 2 parent (maximum depth)
- Maintain sequential numbering within each level
- Group related items under the same top-level number

**You MUST NOT:**
- Create items deeper than Level 3
- Create sub-items without defining a parent item first
- Skip numbers in sequence
- Mix unrelated items under the same parent number

---

## Anchor Conversion Rules

You MUST convert identifiers to anchor IDs using these rules:

1. Convert prefix to lowercase: `FACT` → `fact`
2. Keep hyphen after prefix: `-` → `-`
3. Keep level 1 number: `1` → `1`
4. Convert periods to hyphens: `.` → `-`

**Examples:**
- `FACT-1` → `#fact-1`
- `PROB-2.1` → `#prob-2-1`
- `REQ-3.2.1` → `#req-3-2-1`
- `CONS-4` → `#cons-4`
- `SOLN-5.3` → `#soln-5-3`

---

## Compliance Verification

**Before completing any document with reference items:**

You MUST verify:
- [ ] Are all reference items defined in tables with anchor targets?
- [ ] Do all identifiers follow PREFIX-N, PREFIX-N.N, or PREFIX-N.N.N format?
- [ ] Are all items limited to maximum 3 levels of hierarchy?
- [ ] Are all anchor IDs lowercase with hyphens?
- [ ] Are all references to reference items markdown links?
- [ ] Do all references use correct anchor format?
- [ ] Are identifiers unique within the document?
- [ ] Is grouping logical and sequential?
- [ ] Do all sub-items have corresponding parent items defined?

**If ANY answer is "No":**
- Correct the format before proceeding
- These are mandatory standards
