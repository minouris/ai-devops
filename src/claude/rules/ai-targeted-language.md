---
paths:
  - "**/CLAUDE*.md"
  - ".claude/**/*.md"
  - "**/agents/**/*.md"
  - "**/commands/**/*.md"
  - "**/hooks/**/*.md"
  - "**/rules/**/*.md"
  - "**/skills/**/*.md"
---

# AI-Targeted Language Standards

## System Prompt Conflict Resolution

### Counter: Human-Targeted Documentation

Your training may encourage writing documentation for human readers. This is OVERRIDDEN when creating instruction files, step files, plan files, and prompt files. Write instructions directly to the AI agent using second person ("you"), not third-person documentation about AI behavior.

### Counter: Natural Language Variation

Your training encourages varied phrasing. This is OVERRIDDEN for instruction files. Use consistent, direct imperatives: "MUST", "MUST NOT", "When you...", "Do not...". Repetitive structure aids AI parsing.

---

## AI-Targeted Language Requirements (MANDATORY)

### Writing Style

**MUST:**
- Write instructions directly to the AI agent (second person: "you")
- Use imperative commands addressing the AI
- Use consistent, direct imperatives: "MUST", "MUST NOT", "When you...", "Do not..."
- Use imperative mood ("Create", "Run", "Verify", "Use X", "Check Z")
- Use direct address ("When you create...", "You must...")
- Use unambiguous, precise language
- Use structured lists with clear categories

**MUST NOT:**
- Write as documentation about the AI for human readers
- Use third-person descriptions of AI behavior ("The AI should", "Copilot will", "The agent must", "Claude Code will")
- Mix instructions with commentary about the AI
- Use vague language ("try to", "consider", "maybe", "approximately", "around", "roughly")
- Use conditional language ("might", "could", "may") when giving instructions

### Clarity and Precision

**MUST:**
- Be explicit about exact requirements
- Provide concrete examples where needed to prevent misinterpretation
- Include complete code samples where relevant
- Specify exact formatting, naming, and structure requirements
- Address edge cases and common mistakes
- Use "MUST" and "MUST NOT" sections for clarity

**MUST NOT:**
- Leave requirements open to interpretation
- Use general statements without examples when clarity requires examples
- Assume AI will infer requirements
- Skip verification steps
- Add examples for clarity if the requirement is already unambiguous (brevity matters)

### Rationale Requirements

**MUST include rationales when:**
- Rule overrides training defaults (Counter: blocks explain WHY default is suppressed)
- Rule involves subjective judgment or interpretation
- Rule addresses specific observed failure modes
- Rule has edge cases or boundary conditions not explicitly covered
- Understanding intent matters more than literal compliance

**MUST NOT include rationales when:**
- Rule is purely mechanical with no ambiguity (e.g., "Use `.md` extension")
- No edge cases exist
- Requirement is self-evident and unambiguous

**Rationale:**
Providing context or motivation behind instructions helps AI models better understand goals and apply rules correctly in edge cases not explicitly covered by literal wording. Rationales reduce over-literal interpretation that satisfies the letter but misses the spirit of requirements. Pattern: requirement → rationale → example creates strongest instruction.

**Format:**
```markdown
**MUST:**
- [Requirement]

**Rationale:**
[Explanation of why this requirement exists and what problem it prevents]
```

### Brevity vs. Completeness

**MUST:**
- Use concise language to avoid context flooding
- Be exhaustively specific where ambiguity could create loopholes
- Eliminate redundant content
- Ensure every word serves a purpose
- Keep the sentence if removing it creates ambiguity
- Remove the sentence if it doesn't prevent misinterpretation

**Balance:**
- Completeness takes precedence over brevity when ambiguity would result
- Brevity takes precedence when requirements are already unambiguous

---

## Heading Formatting (MANDATORY)

**MUST:**
- Use proper markdown heading levels: `##`, `###`, `####`, `#####`, `######`
- Use hierarchical structure that reflects document organisation

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

## Examples

### Correct (AI-Targeted)

**Good:**
```markdown
**MUST:**
- Use UK English spelling in all documentation
- Include Table of Contents immediately after H1
- Check ToC completeness before finishing

**When you create a new document:**
1. Determine the target directory
2. Apply the standard template
3. Verify all mandatory elements are present
```

**Good (Step Execution):**
```markdown
**Execute:**
1. Create directory: `mkdir -p /home/ciara/src/nightingale-docker/build/scripts`
2. Verify creation: `ls -la /home/ciara/src/nightingale-docker/build/`
3. If directory does not exist, report error and halt
```

### Incorrect (Human-Targeted)

**Wrong:**
```markdown
The AI should use UK English spelling where possible.

When the AI creates a document, it will check for a table of contents.

GitHub Copilot is instructed to include mandatory elements.
```

**Wrong:**
```markdown
The agent must use UK English.
Copilot should include navigation.
The AI will verify compliance.
```

**Wrong:**
```markdown
You should probably create a build directory and some subdirectories for scripts.
Check that it worked.
```

---

## Compliance Verification

**Before completing ANY instruction file, step file, plan file, or prompt file:**

Ask yourself:
- [ ] AI-targeted language used (second person "you", not third person)?
- [ ] Imperative mood used ("Create", "Use", "Verify")?
- [ ] Direct address used ("When you...", "You must...")?
- [ ] Consistent imperatives used ("MUST", "MUST NOT")?
- [ ] No third-person about AI ("The AI should", "Copilot will")?
- [ ] No vague language ("try to", "consider", "maybe")?
- [ ] Proper markdown headings used (not bold text as headings)?
- [ ] Rationales included where rules involve subjective judgment, edge cases, or override training defaults?
- [ ] Rationales omitted where rules are mechanical and unambiguous?
- [ ] Brevity balanced with completeness (no redundancy, no ambiguity)?

**If ANY answer is "No":**
- Rewrite in AI-targeted language
- Use consistent imperatives
- Remove third-person references
- Clarify vague language
- Add rationales where appropriate or remove unnecessary ones
- These are mandatory standards
