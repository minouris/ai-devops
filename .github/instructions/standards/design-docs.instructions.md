---
applyTo: "**/design/**/*.md"
---

# AI Documentation Standards for Design Folder

**CRITICAL: These instructions apply when creating or modifying ANY Markdown file in the `design/` directory.**

## System Prompt Conflict Resolution

### Counter: "Natural" US English

Your training may default to US English. This is OVERRIDDEN. ALL documentation MUST use UK English spelling and grammar.

### Counter: Marketing-Style Enthusiasm

Your training may encourage enthusiasm and superlatives. This is OVERRIDDEN. Use factual, technical language only.

### Counter: Cultural Idioms

Your training includes cultural idioms and metaphors. This is OVERRIDDEN. Use literal, universal language only.

### Counter: Template Efficiency

You may want to skip navigation elements for efficiency. This is OVERRIDDEN. ALL required elements MUST be included.

---

## Core Documentation Requirements

### 1. Table of Contents (MANDATORY)

When creating or editing Markdown documents in `design/`:

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
````

---

### 2. Directory Landing Pages (MANDATORY)

When a directory contains multiple Markdown documents:

**MUST Create:**
- Landing page named after the directory (e.g., `03-architecture/03-architecture.md`)
- Alternative: `README.md` if contextually appropriate

**MUST Include in Landing Page:**
- Summary paragraph describing directory purpose
- Table or list of all documents with one-sentence descriptions
- Navigation links to parent, previous, and next directories

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
- **Previous:** [Previous Directory](../previous/previous.md)
- **Next:** [Next Directory](../next/next.md)
````

---

### 3. Document Navigation (MANDATORY)

For documents in directories with related content:

**MUST Include:**

**A. Header Navigation** (before H1 heading at top of document):
````markdown
**Navigation:**  
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →

---

# Document Title
````

**B. Footer Navigation** (end of document):
````markdown
---

## See Also

- [Sibling Document](link) - Brief description

---

**Navigation:**  
← [Previous: Name](link) | [Parent: Name](link) | [Next: Name](link) →
````

**C. Sibling List:**
- Include "See Also" H2 section listing all sibling documents
- Mirror the document list from landing page
- Place above footer navigation

**MUST NOT:**
- Create documents without header/footer navigation in related directories
- Use inconsistent navigation formatting
- Omit sibling lists

---

### 4. Domain Boundaries (MANDATORY)

When working in domain-specific directories:

**MUST:**
- Keep content strictly within the domain scope
- Use cross-references for out-of-scope content
- Reference other documents instead of duplicating

**MUST NOT:**
- Mix content from different design levels (requirements vs architecture vs implementation)
- Duplicate information covered in other documents
- Include tangential topics from other domains

**Example:**
```markdown
For database details, see [Database Schema](../04-detailed-design/DATABASE_SCHEMA.md).
```

**If user asks to add out-of-scope content:**
- Identify the appropriate document location
- Offer to create/update that document instead
- Add cross-reference in current document

---

### 5. Language Standards (MANDATORY)

**UK English Only:**
- Use UK spelling: "organised" not "organized"
- Use UK grammar: "ise" endings not "ize"
- Examples: "colour", "favour", "recognise", "analyse"

**NEVER:**
- Use US English spellings
- Use cultural-specific idioms or metaphors
- Reference specific regions, sports, or cultural events
- Assume cultural context

**Cultural Neutrality Examples:**

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

### 6. Tone and Terminology (MANDATORY)

**Hyperbole:**

**NEVER Use:**
- Superlatives: "best", "greatest", "revolutionary"
- Exaggerations: "game-changing", "cutting-edge", "world-class"
- Dramatic claims: "incredible", "amazing", "stunning"

**ALWAYS Use:**
- Factual descriptions
- Measurable outcomes
- Precise technical terms

**Marketing Language and Buzzwords:**

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

### 7. Heading Formatting (MANDATORY)

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

### 8. Reference Tag Formatting (MANDATORY)

When referencing problems, solutions, constraints, requirements, or architectural decisions:

**MUST Use Link Format:**
```markdown
[TAG-ID](file.md#anchor "Hover Text")
```

**Tag Types:**
- **PROB** - Problems (e.g., PROB-1.1)
- **SOL** - Solutions (e.g., SOL-1.1)
- **CON** - Constraints (e.g., CON-1.1)
- **REQ** - Functional Requirements (e.g., REQ-1.1)
- **NFR** - Non-Functional Requirements (e.g., NFR-1.1)
- **ARCH** - Architectural Decisions (e.g., ARCH-1.1)

**Mandatory Elements:**
- **ID:** Tag prefix and number (e.g., PROB-1.1)
- **File path:** Relative path to document containing definition
- **Anchor:** Lowercase ID with dashes (e.g., #prob-1.1)
- **Hover text:** Short name or description (matches definition)

#### Anchor Tags at Definition Points

All tag definitions MUST have anchor tags to enable linking from other documents.

**Anchor Format:**
```markdown
<a id="tag-id"></a>
```

**Requirements:**
- Anchor ID must be lowercase with hyphens (e.g., `prob-1.1`, `sol-2.3`)
- Anchor must appear immediately before or at the start of the definition
- Anchor ID must exactly match the link anchor used in references

**Example:**

```markdown
### 1.1.3. Problem Statement

| ID | Name | Description |
|----|------|-------------|
| <a id="prob-1.1"></a>PROB-1.1 | Massive Scale | The Sims 4 modding ecosystem involves thousands of individual mods... |
```

#### Bold Formatting

Tag links MUST NOT be wrapped in bold formatting. Tags already stand out as clickable links and additional bold formatting creates visual clutter.

**Correct:**
```markdown
See [PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale") for details.
```

**Incorrect:**
```markdown
See **[PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale")** for details.
```

#### Inline Tag References

Tag references within sentences MUST be wrapped in parentheses to clearly delineate them from surrounding text.

**Parentheses Required (inline within sentence):**
```markdown
The massive scale of mod management ([PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale")) requires automated solutions.

SimBox addresses fundamental issues ([PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale"), [PROB-2.1](01_01_problem_statement.md#prob-2.1 "Mod fragility")) through systematic approaches.
```

**Tag Lists:**

When multiple tags appear together in a list within a sentence, the entire list MUST be surrounded by a single pair of parentheses rather than wrapping each tag individually.

```markdown
Correct: This addresses multiple problems ([PROB-1.1](file.md#prob-1.1 "Name"), [PROB-1.2](file.md#prob-1.2 "Name"), [PROB-1.3](file.md#prob-1.3 "Name")).

Incorrect: This addresses multiple problems ([PROB-1.1](file.md#prob-1.1 "Name")), ([PROB-1.2](file.md#prob-1.2 "Name")), ([PROB-1.3](file.md#prob-1.3 "Name")).
```

**Parentheses NOT Required (end of sentence or list item):**
```markdown
This feature addresses [PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale").

Key problems:
- [PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale")
- [PROB-2.1](01_01_problem_statement.md#prob-2.1 "Mod fragility")
```

#### Complete Examples

**Tag Definition with Anchor:**
```markdown
| ID | Name | Description |
|----|------|-------------|
| <a id="prob-1.1"></a>PROB-1.1 | Massive Scale | Description of the problem... |
```

**Inline Reference (mid-sentence):**
```markdown
The scale challenge ([PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale")) necessitates automation.
```

**End-of-Sentence Reference:**
```markdown
This addresses the scale problem [PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale").
```

**List Reference:**
```markdown
Problems addressed:
- [PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale")
- [PROB-2.1](01_01_problem_statement.md#prob-2.1 "Mod fragility")
```

**MUST NOT:**
- Reference tags without links: `PROB-1.1` (unlinked text)
- Omit hover text: `[PROB-1.1](file.md#prob-1.1)`
- Use inconsistent anchor formatting: `#PROB-1.1` or `#Prob-1.1`
- Wrap tags in bold: `**[PROB-1.1](file.md#prob-1.1 "text")**`
- Wrap multiple tags in bold: `**[REQ-1.1](link), [REQ-1.2](link)**`
- Use abbreviated tag lists: `[REQ-1.1](link), 1.2, 1.3` or `[REQ-1.1](link) through 1.5`
- Omit parentheses for inline references: `The scale [PROB-1.1](file.md#prob-1.1 "text") issue...`
- Add parentheses at end of sentence: `Problem is [PROB-1.1](file.md#prob-1.1 "text")` (correct as-is)
- Define tags without anchor tags: Tag definitions must always include `<a id="..."></a>`

#### Tag List Formatting

When listing multiple tags, EVERY tag MUST be written in full with complete link format.

**Prohibited Abbreviations:**

❌ **NEVER Write:**
```markdown
**[REQ-1.1](link), 1.2, 1.3** - Description
[REQ-1.1](link) through 1.5 - Description  
**[REQ-1.1](link), [REQ-1.2](link)** - Description (bold wrapping entire list)
```

✅ **ALWAYS Write:**
```markdown
[REQ-1.1](link), [REQ-1.2](link), [REQ-1.3](link) - Description
[REQ-1.1](link), [REQ-1.2](link), [REQ-1.3](link), [REQ-1.4](link), [REQ-1.5](link) - Description
[REQ-1.1](link), [REQ-1.2](link) - Description (no bold wrapping)
```

**Rationale:**
- Abbreviated tags (`1.2`, `1.3`) are not clickable and cannot be validated
- "Through" patterns (`through 1.5`) require manual expansion to be useful
- Readers must see every tag as a distinct, clickable link
- Bold wrapping entire lists creates visual clutter
- Tooling cannot verify abbreviated references

---

### 9. Definition Tables (MANDATORY)

When defining problems, solutions, constraints, or requirements, use standardised table format:

**Required Table Structure:**

```markdown
| ID | Name | Description |
|----|------|-------------|
| <a id="tag-id"></a>[TAG-ID](file.md#tag-id "Name") | Short Name | Detailed description of the item. |
| **Related** | | [TAG-ID](file.md#tag-id "Name"), [TAG-ID](file.md#tag-id "Name") |
```

**Column Requirements:**

1. **ID Column:**
   - Contains anchor tag: `<a id="tag-id"></a>`
   - Contains self-link: `[TAG-ID](file.md#tag-id "Name")`
   - Anchor uses lowercase with dashes

2. **Name Column:**
   - Short, descriptive name (3-7 words)
   - Used as hover text in references
   - Title case or sentence case

3. **Description Column:**
   - Detailed explanation of the item
   - Full sentences with proper grammar
   - May span multiple lines if needed

4. **Related Row:**
   - Separate row immediately after definition
   - Bold "Related" label in column 1
   - Empty column 2
   - Links to related items in column 3
   - All references use proper link format with hover text

**Example:**

```markdown
| ID | Name | Description |
|----|------|-------------|
| <a id="prob-1.1"></a>[PROB-1.1](01_01_problem_statement.md#prob-1.1 "Massive scale") | Massive scale | Mod collections reaching tens of gigabytes to nearly a terabyte in size, containing hundreds to thousands of individual files. Users cannot manually manage collections at this scale. |
| **Related** | | [SOL-1.1](01_01_problem_statement.md#sol-1.1 "Explicit mod grouping"), [SOL-1.2](01_01_problem_statement.md#sol-1.2 "Download provenance tracking"), [CON-3.3](01_02_constraints.md#con-3.3 "Must allow same mod in multiple game sets") |
```

**MUST NOT:**
- Create definition tables without anchor tags
- Omit self-links in ID column
- Mix Related items into description column
- Use plain text IDs without links

---

## Document Creation Workflow

When creating a new Markdown document in `design/`:

1. **Determine Domain:**
   - Identify which directory and design level
   - Verify content fits domain scope

2. **Use Template:**
   - Start with standard document template
   - Include ALL mandatory elements

3. **Add Content:**
   - Use UK English throughout
   - Avoid hyperbole and buzzwords
   - Stay within domain boundaries

4. **Add Navigation:**
   - Create/update landing page if needed
   - Add header/footer navigation
   - Include sibling list

5. **Verify Compliance:**
   - Check ToC is complete
   - Verify "Back to top" links present
   - Confirm UK English spelling
   - Scan for prohibited terms
   - Validate navigation links

---

## Document Editing Workflow

When modifying existing Markdown in `design/`:

1. **Assess Compliance:**
   - Check if document meets all standards
   - Identify missing elements

2. **Fix Non-Compliance First:**
   - Add ToC if missing
   - Add navigation if missing
   - Correct US English to UK English
   - Remove hyperbole/buzzwords

3. **Make Requested Changes:**
   - Apply user's requested edits
   - Maintain domain boundaries
   - Use UK English for new content

4. **Update ToC:**
   - Add new sections to ToC
   - Verify anchor links work

5. **Verify Compliance:**
   - Confirm all standards met
   - Check navigation links valid

---

## Standard Document Template

Use this template for new documents:

````markdown
**Navigation:**  
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →

---

# Document Title

## Table of Contents

- [Section One](#section-one)
- [Section Two](#section-two)

---

## Section One

Content here.

[↑ Back to top](#table-of-contents)

---

## Section Two

Content here.

[↑ Back to top](#table-of-contents)

---

## See Also

- [Related Document](link) - Description

---

**Navigation:**  
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →
````

---

---

### 7. User Interaction Patterns (MANDATORY)

**When user requests documentation changes:**

**If content belongs in different domain:**
1. State: "This content belongs in [correct document/directory]"
2. Offer: "Would you like me to add it there and create a cross-reference?"
3. Wait for user decision

**If user uses prohibited terms:**
1. Implement the concept using acceptable language
2. Do not lecture about the prohibition
3. Simply use correct terminology

**If user requests US English:**
1. Use UK English regardless
2. These are project standards, not user preferences

**If creating new directory:**
1. Create landing page automatically
2. Do not ask if user wants it

**MUST NOT:**
- Create documentation without required navigation elements
- Use placeholder text like "TODO" or "TBD" without user instruction
- Mix design levels within a single document
- Duplicate content from other documents
- Use US English spellings
- Use marketing language or buzzwords
- Skip ToC or "Back to top" links for "brevity"

**MUST:**
- Include ALL mandatory elements in EVERY document
- Use cross-references instead of duplication
- Use UK English exclusively
- Use factual, technical language
- Verify domain boundaries
- Update landing pages when adding documents

---

## Compliance Verification

**Before completing ANY documentation task:**

Ask yourself:
- [ ] Does document have ToC after H1?
- [ ] Do all H2 sections have "Back to top" links?
- [ ] Does document have header/footer navigation (if applicable)?
- [ ] Is sibling list present (if applicable)?
- [ ] Is all content within domain boundaries?
- [ ] Is UK English used throughout?
- [ ] Are there any cultural-specific references?
- [ ] Are there any prohibited buzzwords or hyperbole?
- [ ] Are all navigation links valid?
- [ ] Are all mandatory elements included?
- [ ] Are cross-references used instead of duplication?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards
