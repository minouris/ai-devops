---
paths:
  - "**/CLAUDE*.md"
  - ".claude/**/*.md"
  - "**/agents/**/*.md"
  - "**/commands/**/*.md"
  - "**/hooks/**/*.md"
  - "**/rules/**/*.md"
  - "**/skills/**/*.md"
  - "**/*.skill.md"
  - "**/*.agent.md"
  - "**/*.prompt.md"
---

# Rule Embedding Standards for Skills and Agents

## System Prompt Conflict Resolution

### Counter: Embed All Rules

Your training or other rules may suggest embedding all rules in all prompts. This is OVERRIDDEN. Embed only rules relevant to the current task to prevent context flooding.

---

## Selective Rule Embedding (MANDATORY)

### Core Principle

Embed only the minimum set of rules required for the current task. Embedding irrelevant rules wastes context and increases the risk of rules being lost to context window limitations.

**MUST:**
- Analyse task requirements before selecting rules
- Embed only rules directly applicable to the current operation
- Embed complete sections of selected rules (no abbreviation within a section)
- Include rule source attribution for user transparency

**MUST NOT:**
- Embed all available rules in every prompt
- Abbreviate or summarize rule sections once selected for embedding
- Omit critical rules because task seems simple
- Embed rules "just in case" without clear applicability

---

## Rule Selection Matrix

### Documentation-First Rules

**Embed when:**
- Task requires domain knowledge not provided by user
- Making factual claims about external systems, technologies, or standards
- Interpreting technical specifications or requirements
- Researching information to answer user questions

**Do NOT embed when:**
- Processing user-provided information only
- Performing purely mechanical tasks (formatting, structuring)
- User has explicitly provided all necessary information

**What to embed:**
- Complete "Documentation Consultation" section
- Complete "No Assumptions or Speculation" section
- Complete "When Documentation is Unavailable" section

---

### Documentation Standards Rules

**Embed when:**
- Generating markdown documentation
- Creating written content for user consumption
- Formatting technical specifications or requirements

**Do NOT embed when:**
- Generating diagrams only (no accompanying text)
- Processing data structures (JSON, YAML)
- Executing purely interactive questioning (no document output)

**What to embed:**
- Complete "Language Standards" section (UK English requirements)
- Complete "Tone and Terminology" section
- Complete "Heading Formatting" section

---

### Markdown Formatting Rules

**Embed when:**
- Creating markdown files with nested code blocks
- Generating documentation with code examples
- Creating files that demonstrate markdown syntax

**Do NOT embed when:**
- Generating simple markdown without code blocks
- Creating diagrams (Mermaid handles its own code blocks)
- Naming files is the only markdown consideration

**What to embed:**
- Complete "Fenced Code Blocks" section if nested blocks needed
- "Filename Conventions" reminder only if creating new files

---

### Mermaid Diagram Rules

**Embed when:**
- Generating any diagram
- Creating visualizations of workflows, architectures, or relationships

**Do NOT embed when:**
- Creating text-only documentation
- Generating tabular data
- Processing existing diagrams (only if modifying)

**What to embed (conditional):**

**Always embed for diagrams:**
- Mermaid syntax requirements (TB layout, no ASCII art)
- Diagram type selection guidance
- Complexity limits and splitting criteria

**Embed colour schemes ONLY when:**
- Diagram has nested structures (subgraphs)
- Representing hierarchical relationships
- Diagram has more than 5-7 nodes
- Visualizing layered architectures or workflows with stages

**Do NOT embed colour schemes when:**
- Simple flat diagrams (no nesting)
- Sequence diagrams (temporal, not hierarchical)
- Entity-relationship diagrams (relationships, not hierarchy)
- Diagrams with fewer than 5 nodes

---

## Rule Embedding Template

### Prompt Structure

````markdown
[Task-specific persona and constraints]

---

# Embedded Rules

## [Rule Name] (from [source file])

[Complete relevant section(s) verbatim]

---

# Task

[Specific task instructions]
````

### Example: Question Generation (No Document Output)

````markdown
You are a Business Analyst helping define a problem. Do not suggest solutions.

---

# Embedded Rules

## Documentation-First Response Requirements (from documentation-first.md)

**MUST:**
- Search for and reference official documentation sources relevant to the question
- Verify information against authoritative sources before answering
- Prioritize official documentation over general knowledge

**MUST NOT:**
- Rely solely on general knowledge or training data
- Provide answers without verifying against official sources
- Skip documentation research even for seemingly simple questions

[... complete relevant sections ...]

---

# Task

Based on user input: "[user statement]"

Generate 1-3 targeted questions to gather missing information about business context.
````

### Example: Diagram Generation with Nesting

````markdown
You are generating a workflow diagram showing problem identification phases.

---

# Embedded Rules

## Mermaid Diagram Requirements (from mermaid-diagrams.md)

[Complete Mermaid syntax section]
[Complete layout requirements section]
[Complete colour scheme section - diagram has nested phases]
[Complete complexity limits section]

## Documentation Standards (from documentation-standards.md)

[Complete UK English section]
[Complete tone section]

---

# Task

Generate a top-to-bottom Mermaid diagram showing the three-phase problem identification workflow with nested activities.
````

---

## Granular Section Selection

### When Rules Have Multiple Sections

If a rule file contains multiple independent sections, embed only applicable sections:

**Example - Mermaid Diagrams:**
- Basic syntax requirements: ALWAYS for diagrams
- Layout requirements (TB vs LR): ALWAYS for diagrams
- Splitting criteria: ONLY for complex diagrams (>10 nodes)
- Colour schemes: ONLY for nested/hierarchical diagrams
- Linking between diagrams: ONLY when generating multiple related diagrams

**Example - Documentation Standards:**
- UK English requirements: ALWAYS for any text
- Marketing language prohibitions: ALWAYS for any text
- Heading formatting: ONLY when generating structured documents
- Cultural neutrality: ALWAYS for any text

---

## Context Budget Management

### Estimating Rule Embedding Cost

Before embedding rules, estimate context usage:

**Small embedding (~200 tokens):**
- Single section of one rule
- Suitable for simple tasks

**Medium embedding (~500-800 tokens):**
- Multiple sections from 1-2 rules
- Most common scenario

**Large embedding (~1500+ tokens):**
- Complete multi-section rules
- Only when task truly requires comprehensive coverage

**If embedding would exceed ~1500 tokens:**
- Reconsider whether all sections are necessary
- Split task into smaller operations with targeted rule embedding
- Prioritize most critical rules if trade-offs required

---

## Compliance Verification

**Before embedding rules in any prompt:**

Ask yourself:
- [ ] Which specific rules are required for THIS task?
- [ ] Have I excluded rules not applicable to THIS task?
- [ ] Have I included complete sections (not abbreviated) for selected rules?
- [ ] Is the total embedding under ~1500 tokens?
- [ ] Would excluding any selected rule create risk of errors?

**If embedding seems too large:**
- Split task into smaller operations
- Verify each selected rule is truly necessary
- Consider whether task scope is too broad

---

## Skill Implementation Guidance

### For Skill Developers

When creating skills that generate prompts:

1. **Analyse task type** before each prompt generation
2. **Select applicable rules** using the matrix above
3. **Embed complete relevant sections** verbatim
4. **Attribute source** for user transparency
5. **Monitor context usage** across conversation

### Dynamic Rule Selection

Skills SHOULD implement logic to determine rule requirements:

```
function selectRules(task) {
  rules = []

  if (task.requiresDomainKnowledge) {
    rules.push(sections.documentationFirst.consultation)
    rules.push(sections.documentationFirst.noAssumptions)
  }

  if (task.generatesDocument) {
    rules.push(sections.documentationStandards.ukEnglish)
    rules.push(sections.documentationStandards.tone)
  }

  if (task.generatesDiagram) {
    rules.push(sections.mermaidDiagrams.syntax)

    if (task.diagramHasNesting) {
      rules.push(sections.mermaidDiagrams.colourSchemes)
    }
  }

  return rules
}
```

---

## Examples of Rule Selection

### Good: Targeted Embedding

**Task:** "Generate questions to gather business context"
**Rules embedded:**
- Documentation-first consultation requirements
- No assumptions section

**Rationale:** Task requires avoiding assumptions but produces no document or diagram output. Documentation standards and Mermaid rules not applicable.

---

### Bad: Over-Embedding

**Task:** "Generate questions to gather business context"
**Rules embedded:**
- Complete documentation-first.md
- Complete documentation-standards.md
- Complete mermaid-diagrams.md

**Problem:** Wastes ~3000 tokens on rules that don't apply to questioning. Increases risk of relevant rules being lost to context limits.

---

### Good: Granular Selection

**Task:** "Generate simple sequence diagram showing user interaction"
**Rules embedded:**
- Mermaid syntax basics
- Layout requirements
- Diagram type guidance

**Rationale:** Sequence diagram is temporal, not hierarchical. Colour schemes not applicable. Diagram is simple (no splitting needed).

---

### Bad: Missing Critical Rules

**Task:** "Research and document the OAuth 2.0 flow"
**Rules embedded:**
- Documentation standards (UK English, tone)

**Problem:** Task requires research but documentation-first rules not embedded. Risk of speculation or assumptions about OAuth implementation.

---

## Special Cases

### Interactive Multi-Turn Skills

For skills that conduct extended conversations:

**Option 1: Embed Once at Start**
- Include core rules in initial prompt
- Reference them throughout conversation
- Suitable for short conversations (<10 turns)

**Option 2: Re-embed Selectively**
- Embed rules when task type changes
- Example: Questioning phase → no diagram rules
- Summary phase → add documentation standards
- Diagram phase → add Mermaid rules

**Option 3: Progressive Embedding**
- Start with minimal rules
- Add rules as task complexity increases
- Monitor context usage carefully

---

## Conclusion

Selective rule embedding balances the need to prevent hallucination and maintain standards against the need to preserve context for actual task execution. By embedding only applicable rules in complete sections, skills maintain quality whilst maximizing context efficiency.
