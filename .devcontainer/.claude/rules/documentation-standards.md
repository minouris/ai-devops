---
paths:
  - "**/*.md"
---

# Documentation Standards

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

## Language Standards (MANDATORY)

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

## Tone and Terminology (MANDATORY)

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

## Heading Formatting (MANDATORY)

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

## Compliance Verification

**Before completing ANY documentation task:**

Ask yourself:
- [ ] Is UK English used throughout?
- [ ] Are there any cultural-specific references?
- [ ] Are there any prohibited buzzwords or hyperbole?
- [ ] Are proper markdown headings used (not bold text)?
- [ ] Is tone factual and technical (not marketing-style)?

**If ANY answer is "No":**
- Fix the issue before declaring task complete
- Do not ask user if they want it fixed
- These are mandatory standards
