---
paths:
  - "design/**/*.md"
---

# Design Documents Standards

**CRITICAL: Design documents are human-readable artifacts for team collaboration, NOT AI execution instructions.**

## System Prompt Conflict Resolution

### Counter: Unified Documentation Approach

Your training may treat all Markdown documentation similarly. This is OVERRIDDEN. Design documents serve a different purpose than plan files, requiring different writing approaches.

---

## Design Documents Purpose

### What They Are

Design documents are human-readable artifacts created during the design phase of a project. They facilitate human decision-making, communication between team members, and serve as reference documentation.

### Audience

- Human team members (Business Analysts, Architects, Designers, Developers)
- Stakeholders reviewing design decisions
- Future maintainers understanding system rationale

---

## Writing Style

**MUST:**
- Use clear, structured prose for human readers
- Explain rationale and trade-offs
- Use third-person or neutral descriptive voice
- Include context and background
- Use descriptive language that aids understanding

**MUST NOT:**
- Use imperative mood addressing an AI ("You MUST create", "Configure the system")
- Write step-by-step AI execution instructions
- Include embedded anti-hallucination directives (System Prompt Conflict Resolution sections)
- Use second-person "you" to address an AI

---

## Heading Formatting (MANDATORY)

Proper heading structure is critical for document parsing and scripted changes.

**MUST:**
- Use proper markdown heading levels: `##`, `###`, `####`, `#####`, `######`
- Maintain hierarchical structure reflecting document organisation
- Use headings for all section breaks and major topics

**MUST NOT:**
- Use bold text as headings: `**Heading Text**` or `**Heading Text:**`
- Use bold text to simulate section breaks
- Use bold text where a heading is semantically appropriate
- Mix heading styles within the same document

**Rationale:**
- Proper headings enable automated parsing and scripting
- Bold text does not provide semantic structure
- Navigation, linking, and table of contents generation require proper headings
- Screen readers and document parsers rely on heading tags

**Examples:**

Incorrect:
```markdown
**Implementation Details**

Some content here.

**Configuration:**
More content.
```

Correct:
```markdown
#### Implementation Details

Some content here.

#### Configuration

More content.
```

---

## Reference Standardization (MANDATORY)

All reference types used in design documents must conform to standardized formats that can be validated with regular expressions.

**MUST:**
- Define a standard format for each reference type used
- Provide a regular expression that validates the format
- Ensure all references of that type conform to the pattern
- Document the format and regex for each reference type

**MUST NOT:**
- Use multiple formats for the same reference type
- Create references that cannot be validated with a single regex
- Use edge case formats that break pattern matching
- Mix reference styles within the same document

**Rationale:**
- Enables scripted operations on documents
- Prevents edge cases that break automated tools
- Allows validation of all references
- Supports automated refactoring and restructuring

**When introducing a new reference type:**
1. Define the standard format
2. Create a regex pattern that validates it
3. Document both in relevant rule files
4. Ensure all uses conform to the pattern

---

## When to Create Design Documents

Create design documents when:
- Defining system architecture
- Documenting design decisions and rationale
- Explaining problem statements and requirements
- Describing feature specifications for human understanding
- Creating reference documentation for team members
- Documenting trade-offs and alternatives considered

---

## Navigation Requirements (MANDATORY)

Design documents MUST include proper navigation elements to enable easy discovery and traversal.

### Table of Contents

**MUST:**
- Include a Table of Contents section immediately after the H1 heading
- Use an H2 heading: `## Table of Contents`
- List all H2 and H3 headings with markdown links to anchors
- Keep ToC up to date when adding or removing sections
- Use proper anchor format (lowercase, hyphens, section numbers)

**Format:**
```markdown
# Document Title

## Table of Contents

- [Section Number Title](#anchor)
  - [Subsection Number Title](#anchor)
- [Section Number Title](#anchor)
```

**MUST NOT:**
- Omit Table of Contents from design documents
- Create ToC with plain text instead of links
- Include headings deeper than H3 in ToC (for readability)

### Back to Top Links

**MUST:**
- Include a "Back to Top" link at the end of each H2 and H3 section
- Place the link on its own line after the section content
- Use consistent format: `[↑ Back to Top](#table-of-contents)`
- Link to the Table of Contents anchor

**Format:**
```markdown
## Section Title

Section content here.

[↑ Back to Top](#table-of-contents)

### Subsection Title

Subsection content here.

[↑ Back to Top](#table-of-contents)
```

**MUST NOT:**
- Omit "Back to Top" links from H2 or H3 sections
- Use inconsistent link text or formatting
- Link to anchors other than the Table of Contents

### Document Series Navigation

When a design document is part of a series or directory with multiple related documents:

**MUST:**
- Include header navigation before H1 heading
- Include footer navigation at end of document
- Include "See Also" section listing sibling documents
- Follow format defined in `.devcontainer/.claude/rules/document-navigation.md`

**Header Navigation Format:**
```markdown
**Navigation:**
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →

---

# Document Title
```

**Footer Navigation Format:**
```markdown
---

## See Also

- [Related Document](link) - Brief description

---

**Navigation:**
← [Previous: Name](link) | ↑ [Parent: Name](link) | [Next: Name](link) →
```

**MUST NOT:**
- Create design documents in a series without navigation
- Omit "See Also" sections for related documents
- Use inconsistent navigation formatting

---

## Modular Structure Requirements

Design documents should be organised as small, focused files that are easy to consume and navigate.

### Granularity

- One file per focused topic or concept
- Files typically 200-500 lines for focused consumption
- Large topics broken into multiple related files within a subdirectory
- Subdirectories group related files by domain or feature
- No monolithic files covering multiple distinct topics
- Files should not exceed 1000 lines without strong justification

### File Organisation

- Subdirectories for logical grouping (e.g., `design/sdlc-framework/modes/`)
- Index/overview files at each directory level
- Flat structure when topic has few files
- Descriptive, kebab-case file names
- Number prefixes when sequence matters (e.g., `01-overview.md`)
- Topic-focused names (e.g., `analyst-mode.md`, not `mode-1.md`)

### Index and Navigation

- Index file at root of each design subdirectory
- Index lists all documents with brief descriptions
- Topic-based cross-references between related documents
- Parent directory links in subdirectory indexes
- Enables quick discovery and allows AI to identify relevant files

### Cross-Referencing

- Relative links to other design documents
- Context in link text (not just "see here")
- Links to specific sections for detailed information
- Example: `[Approval Gates and Mode Transitions](approval-gates.md#approval-gate-mechanism)`

---

## Relationship to Plan Files

Design documents inform **what to build and why**.

Plan files (in `plans/` directory) are separate AI-consumable instructions that specify **how to build it** using imperative commands and embedded rules.

**Workflow:**
1. Create design documents (human collaboration)
2. Review and approve designs (human decision-making)
3. Translate designs into plan files (AI execution instructions)

---

## Compliance Verification

**Before creating or modifying design documents:**

Ask yourself:
- [ ] Am I using descriptive prose, NOT imperative AI instructions?
- [ ] Am I explaining rationale and context?
- [ ] Am I avoiding second-person "you" addressing an AI?
- [ ] Have I avoided including System Prompt Conflict Resolution sections?
- [ ] Have I included a Table of Contents after the H1 heading?
- [ ] Have I added "Back to Top" links at the end of all H2 and H3 sections?
- [ ] If part of a series, have I included header and footer navigation?
- [ ] If part of a series, have I included a "See Also" section?
- [ ] Are all headings using proper markdown (##, ###, ####), NOT bold text?
- [ ] Are all section and document references formatted as markdown links?

**If ANY answer is "No":**
- Correct the approach before proceeding
- These are mandatory standards for design documents
