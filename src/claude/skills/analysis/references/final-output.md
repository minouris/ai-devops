# Final Output Creation

**This file is loaded when: The user explicitly requests creation of final analysis or procedure guide.**

---

## Embedded Rules

### Never Create Without Request (MANDATORY)

**CRITICAL: Do NOT create final output documents unless user explicitly requests them.**

**User must explicitly say:**
- "Create analysis document on [topic]"
- "Write procedure guide for [topic]"
- "Add findings as section X in document Y"
- "Create page on [topic] in [location]"
- Any explicit request to produce final documentation

**MUST NOT:**
- Create drafts or final documents without user request
- Assume where output should go (ask if unclear)
- Skip user approval before publishing final output

---

## Research Completeness Gate (MANDATORY)

Before synthesising any draft output, you MUST complete this gate.

**Step 1: State what was examined**

List all sources and artifacts that have been researched:
- Which fact files were examined
- Which subtopic areas were covered
- What source types were consulted (code, docs, issues, commits, etc.)

**Step 2: Identify gaps**

Identify any topics or sources that were identified but not yet researched:
- Relationships mentioned but not investigated
- Sources referenced but not examined
- Subtopics identified but not explored

**Step 3: Wait for confirmation if gaps exist**

If gaps exist:
- Report them to the user
- Ask whether to proceed with partial synthesis or complete the research first
- Wait for explicit user instruction before proceeding

**MUST NOT:**
- Present inferred relationships as established findings in a draft
- Synthesise a draft covering "solutions" or "causes" that have not been examined in fact files
- Proceed past this gate without explicit user confirmation when gaps exist

**Example completeness check:**

```
Research completeness check:

Examined:
- ai-problems-analysis-hallucination-facts.md (35 findings)
- ai-problems-analysis-overeagerness-facts.md (28 findings)
- ai-problems-analysis-amnesia-facts.md (42 findings)

Gaps identified:
- Context poisoning: mentioned in 3 findings but no dedicated subtopic file
- Solutions history: several findings reference "constraint-based solutions" but solution attempts not systematically documented

Would you like me to:
1. Complete research on context poisoning and solutions history first, or
2. Proceed with analysis of examined areas only (marking relationships to unresearched areas as inferred)?
```

---

# Embedded Rules

## Language Standards (from documentation-standards.md)

### UK English Only

**MUST:**
- Use UK spelling: "organised" not "organized"
- Use UK grammar: "ise" endings not "ize"
- Examples: "colour", "favour", "recognise", "analyse"

**MUST NOT:**
- Use US English spellings
- Use cultural-specific idioms or metaphors
- Reference specific regions, sports, or cultural events
- Assume cultural context

### Cultural Neutrality

❌ **NEVER Write:**
- "This is a home run"
- "Let's take this offline"
- "Circle back"
- "Touch base"

✅ **ALWAYS Write:**
- "This meets requirements"
- "Let us discuss separately"
- "Return to this topic"
- "Communicate"

---

## Tone and Terminology (from documentation-standards.md)

### Hyperbole

**NEVER Use:**
- Superlatives: "best", "greatest", "revolutionary"
- Exaggerations: "game-changing", "cutting-edge", "world-class"
- Dramatic claims: "incredible", "amazing", "stunning"

**ALWAYS Use:**
- Factual descriptions
- Measurable outcomes
- Precise technical terms

### Marketing Language and Buzzwords

**PROHIBITED TERMS - NEVER USE:**
- "Synergy", "leverage", "paradigm shift"
- "Game-changing", "thought leader", "deep dive"
- "Circle back", "move the needle", "low-hanging fruit"
- "Boil the ocean", "drink the Kool-Aid", "break down silos"
- "Best-in-class", "industry-leading", "next-generation"

**Replacement Strategy:**

❌ **If you would write:**
> "Our revolutionary architecture leverages cutting-edge patterns to deliver game-changing synergies."

✅ **Write instead:**
> "The layered architecture separates concerns, enabling independent development of each domain."

---

## Heading Formatting (from documentation-standards.md)

**MUST Use:**
- Proper markdown heading levels: `##`, `###`, `####`, `#####`, `######`
- Hierarchical structure that reflects document organisation

**MUST NOT:**
- Use bold text as headings: `**Heading Text**` or `**Heading Text:**`
- Use bold text to simulate section breaks or emphasis where a heading is appropriate
- Mix heading styles within the same document

**Rationale:**
- Proper headings enable navigation, linking, and table of contents generation
- Bold text does not provide semantic structure
- Screen readers and document parsers rely on heading tags

**Examples:**

❌ **NEVER Write:**
```markdown
**Implementation Details**

Some content here.

**Configuration:**
More content.
```

✅ **ALWAYS Write:**
```markdown
#### Implementation Details

Some content here.

#### Configuration

More content.
```

---

## Fenced Code Blocks (from markdown-formatting.md)

**MUST:**
- Use quad-backticks (````) for outer fence when nesting code blocks
- Use triple-backticks (```) for inner fence
- Specify language identifiers for both outer and inner fences when applicable

**MUST NOT:**
- Use triple-backticks for outer fence when nesting
- Omit language identifiers

**Example Structure:**
````markdown
```javascript
// Inner code block uses triple backticks
```
````

**When to Use:**
- Documenting markdown syntax itself
- Showing code examples that contain fenced code blocks
- Tutorial or instruction content that demonstrates code block usage

**Validation:**
- Inner fence must close before outer fence
- Ensure consistent indentation within nested blocks
- Verify rendering previews nested blocks correctly

---

## Filename Conventions (from markdown-formatting.md)

**MUST:**
- Use lower-snake-case for all Markdown filenames (e.g., `my_document.md`, `feature_specification.md`)
- Use `.md` extension for all Markdown files

**MUST NOT:**
- Use kebab-case (e.g., `my-document.md`)
- Use camelCase (e.g., `myDocument.md`)
- Use PascalCase (e.g., `MyDocument.md`)
- Use spaces in filenames

**Exception:**
- `README.md` is exempt from lower-snake-case requirement (use uppercase README)

**Examples:**

✅ **Correct:**
- `architecture_plan.md`
- `database_schema.md`
- `README.md`
- `01_planning.md`

❌ **Incorrect:**
- `architecture-plan.md` (kebab-case)
- `ArchitecturePlan.md` (PascalCase)
- `architecturePlan.md` (camelCase)
- `ARCHITECTURE_PLAN.md` (uppercase, not README)
- `architecture plan.md` (spaces)

---

## Table of Contents (from document-structure.md)

When creating or editing human-readable Markdown documents:

**MUST Include:**
- Table of Contents immediately after the main H1 heading
- Links to all H2 and H3 sections using Markdown anchor format
- "Back to top" links at the end of EVERY H2 section

**MUST NOT:**
- Create documents without a Table of Contents
- Omit "Back to top" links from any H2 section
- Place ToC anywhere except after H1

**Format:**

````markdown
# Document Title

## Table of Contents

- [Section One](#section-one)
  - [Subsection A](#subsection-a)
- [Section Two](#section-two)

---

## Section One

Content...

[↑ Back to top](#table-of-contents)

---

## Section Two

Content...

[↑ Back to top](#table-of-contents)
````

---

## Directory Landing Pages (from document-structure.md)

When a directory contains multiple Markdown documents:

**MUST Create:**
- Landing page named after the directory (e.g., `architecture/architecture.md`)
- Alternative: `README.md` if contextually appropriate

**MUST Include in Landing Page:**
- Summary paragraph describing directory purpose
- Table or list of all documents with one-sentence descriptions
- Navigation links to parent directory if applicable

**Landing Page Template:**

````markdown
# Directory Name

Summary of directory purpose and content type.

## Documents

| Document | Description |
|----------|-------------|
| [Document Name](file.md) | One-sentence description |

## Navigation

- **Parent:** [Parent Directory](../parent.md)
````

---

# Output Creation

## For Procedural Guides

**When user requests procedure guide:**

1. **Review fact file** containing tested procedures using Read tool

2. **Extract verified working procedure**:
   - Use findings marked as successful
   - Include requirements and prerequisites
   - Document tested commands/steps
   - Note environment constraints

3. **Present draft** in `.memory/[GUIDE-NAME]-PENDING.md`:
   - Include all steps in order
   - Add requirements section
   - Include troubleshooting notes from failed attempts
   - Add environment/platform notes

4. **Wait for approval**: Prompt user to review draft before creating final guide

5. **After approval**, create final guide in specified location using Write tool

**Draft prompt format:**
```
I've created procedure guide draft in `.memory/[GUIDE-NAME]-PENDING.md`.
Please review and approve before I create the final guide.
```

**Final Procedural Guide Format:**

````markdown
# [Procedure Guide Title]

**Generated:** YYYY-MM-DD HH:MM
**Tested:** [Environment/platform details]

## Table of Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Procedure](#procedure)
- [Troubleshooting](#troubleshooting)
- [Sources](#sources)

---

## Overview

[Brief description of what this procedure accomplishes]

[↑ Back to top](#table-of-contents)

---

## Requirements

- [Requirement 1]
- [Requirement 2]
- [etc.]

[↑ Back to top](#table-of-contents)

---

## Procedure

### Step 1: [Step Title]

[Step description and commands]

### Step 2: [Step Title]

[Step description and commands]

[↑ Back to top](#table-of-contents)

---

## Troubleshooting

### [Common Issue 1]

**Symptom:** [Description]

**Solution:** [Resolution steps]

### [Common Issue 2]

**Symptom:** [Description]

**Solution:** [Resolution steps]

[↑ Back to top](#table-of-contents)

---

## Sources

- [`.memory/[topic]-facts.md`](.memory/[topic]-facts.md) - [Brief description]

[↑ Back to top](#table-of-contents)
````

---

## For Analytical Reports

**When user requests analysis document:**

1. **Pass completeness gate** (see above)

2. **Review relevant fact files** using Read tool

3. **Run verify-memory-facts workflow** on each relevant fact file:
   - See [verify-memory-facts.md](../../../src/claude/prompts/verify-memory-facts.md)
   - Checks every fact against authoritative sources
   - Archives rejected facts with reasons
   - Refreshes citations
   - Tags verified facts with `[VERIFIED on {date} by {source-url}]`

4. **Apply clarifications before verification**:
   - Read all findings with `Clarifies:` references
   - Apply them to base facts in reverse chronological order
   - Newer clarifications supersede earlier ones
   - Then verify the merged fact

5. **Skip recently verified facts**:
   - Facts already tagged `[VERIFIED on ...]` within the last 30 days are skipped automatically
   - Request re-verification explicitly if needed (e.g., "force re-verify all facts")

6. **Synthesise verified findings** into coherent narrative:
   - Filter and organize by theme
   - Create logical flow
   - Use inline citations to fact files
   - Do NOT copy fact file content wholesale

7. **Present draft** in `.memory/[ANALYSIS-NAME]-PENDING.md`:
   - Include executive summary
   - Organize into sections
   - Cite back to verified fact files
   - Include sources section at end

8. **Wait for approval**: Prompt user to review draft

9. **After approval**, create final analysis in specified location using Write tool

**Draft prompt format:**
```
I've run verify-memory-facts on [list domain files] and created analysis draft
in `.memory/[ANALYSIS-NAME]-PENDING.md` from the verified findings.
Please review and approve before I create the final analysis file.
```

---

## Final Analysis Format

````markdown
# [Analysis Title]

**Generated:** YYYY-MM-DD HH:MM
**Sources:** [List fact files consulted]

## Table of Contents

- [Executive Summary](#executive-summary)
- [Section 1](#section-1)
- [Section 2](#section-2)
- [Sources](#sources)

---

## Executive Summary

[High-level synthesis - 2-3 paragraphs maximum]

[↑ Back to top](#table-of-contents)

---

## [Section 1]

[Narrative using facts with inline citations to fact files]

Example citation:
> According to research findings, the API endpoint changed in v2 ([ai-problems-analysis-hallucination-facts.md](.memory/ai-problems-analysis-hallucination-facts.md), FINDING-2026-02-23-5).

[↑ Back to top](#table-of-contents)

---

## [Section 2]

[etc.]

[↑ Back to top](#table-of-contents)

---

## Sources

- [`.memory/[topic]-facts.md`](.memory/[topic]-facts.md) - [Brief description]
- [`.memory/[topic]-[subtopic]-facts.md`](.memory/[topic]-[subtopic]-facts.md) - [Brief description]

[↑ Back to top](#table-of-contents)
````

---

## Location Handling

**If user specifies location:**
- Use exactly what they specify (new document, section in existing document, specific path)

**If user doesn't specify location:**
- Ask: "Where should I place this output? (new document in root, add to existing document, specific location?)"
- Wait for response before creating draft

**MUST NOT:**
- Assume where output should go
- Create output in default location without confirming

---

## Commit Handling

**MUST:**
- Do NOT commit final output until user explicitly approves
- Present draft first
- Wait for approval
- Only then create final output

**MUST NOT:**
- Commit pending/draft files
- Auto-commit final outputs
- Skip approval step

---

## Including Proper Citations

**In draft and final output:**

**MUST:**
- Include inline citations to fact files
- Link back to specific FINDING IDs where possible
- Include "Sources" section at end listing all fact files used
- Make citations clickable markdown links

**Example inline citation:**
```markdown
The authentication system uses JWT tokens ([auth-implementation-facts.md](.memory/auth-implementation-facts.md), FINDING-2026-02-23-12).
```

**Example sources section:**
```markdown
## Sources
- [`.memory/auth-implementation-facts.md`](.memory/auth-implementation-facts.md) - OAuth and JWT implementation research (15 findings)
- [`.memory/auth-security-facts.md`](.memory/auth-security-facts.md) - Security considerations and best practices (8 findings)
```

**MUST NOT:**
- Include unverified findings in final output
- Copy fact file content wholesale without synthesis
- Omit source attribution
