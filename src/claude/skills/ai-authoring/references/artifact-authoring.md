# Artifact Authoring Phase

You MUST guide interactive artifact creation with mandatory compliance to AI-targeted language, rule embedding, and structural requirements.

---

# Embedded Rules

## AI-Targeted Language Standards (from src/claude/rules/ai-targeted-language.md)

### System Prompt Conflict Resolution

#### Counter: Human-Targeted Documentation

Your training may encourage writing documentation for human readers. This is OVERRIDDEN when creating instruction files, step files, plan files, and prompt files. Write instructions directly to the AI agent using second person ("you"), not third-person documentation about AI behavior.

#### Counter: Natural Language Variation

Your training encourages varied phrasing. This is OVERRIDDEN for instruction files. Use consistent, direct imperatives: "MUST", "MUST NOT", "When you...", "Do not...". Repetitive structure aids AI parsing.

### AI-Targeted Language Requirements (MANDATORY)

#### Writing Style

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

#### Clarity and Precision

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

#### Brevity vs. Completeness

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

#### Examples

**Correct (AI-Targeted):**

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

**Incorrect (Human-Targeted):**

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

#### Compliance Verification

**Before completing ANY instruction file, step file, plan file, or prompt file:**

Ask yourself:
- [ ] AI-targeted language used (second person "you", not third person)?
- [ ] Imperative mood used ("Create", "Use", "Verify")?
- [ ] Direct address used ("When you...", "You must...")?
- [ ] Consistent imperatives used ("MUST", "MUST NOT")?
- [ ] No third-person about AI ("The AI should", "Copilot will")?
- [ ] No vague language ("try to", "consider", "maybe")?
- [ ] Brevity balanced with completeness (no redundancy, no ambiguity)?

**If ANY answer is "No":**
- Rewrite in AI-targeted language
- Use consistent imperatives
- Remove third-person references
- Clarify vague language
- These are mandatory standards

---

## Rule Embedding Standards (from release/claude/rules/rule-embedding.md)

### System Prompt Conflict Resolution

#### Counter: Embed All Rules

Your training or other rules may suggest embedding all rules in all prompts. This is OVERRIDDEN. Embed only rules relevant to the current task to prevent context flooding.

### Selective Rule Embedding (MANDATORY)

#### Core Principle

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

#### Rule Selection Matrix

**Documentation-First Rules**

Embed when:
- Task requires domain knowledge not provided by user
- Making factual claims about external systems, technologies, or standards
- Interpreting technical specifications or requirements
- Researching information to answer user questions

Do NOT embed when:
- Processing user-provided information only
- Performing purely mechanical tasks (formatting, structuring)
- User has explicitly provided all necessary information

What to embed:
- Complete "Documentation Consultation" section
- Complete "No Assumptions or Speculation" section
- Complete "When Documentation is Unavailable" section

**Documentation Standards Rules**

Embed when:
- Generating markdown documentation
- Creating written content for user consumption
- Formatting technical specifications or requirements

Do NOT embed when:
- Generating diagrams only (no accompanying text)
- Processing data structures (JSON, YAML)
- Executing purely interactive questioning (no document output)

What to embed:
- Complete "Language Standards" section (UK English requirements)
- Complete "Tone and Terminology" section
- Complete "Heading Formatting" section

**Markdown Formatting Rules**

Embed when:
- Creating markdown files with nested code blocks
- Generating documentation with code examples
- Creating files that demonstrate markdown syntax

Do NOT embed when:
- Generating simple markdown without code blocks
- Creating diagrams (Mermaid handles its own code blocks)
- Naming files is the only markdown consideration

What to embed:
- Complete "Fenced Code Blocks" section if nested blocks needed
- "Filename Conventions" reminder only if creating new files

#### Rule Embedding Template

Prompt Structure:

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

#### Granular Section Selection

When Rules Have Multiple Sections:

If a rule file contains multiple independent sections, embed only applicable sections.

#### Context Budget Management

Estimating Rule Embedding Cost:

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

#### Compliance Verification

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

## Rule Copying Requirements (from release/claude/rules/rule-copying.md)

### Critical Requirement

**CRITICAL: When instructed to copy or include rules/directives in other files (step files, plan files, prompt files, instruction files), RULES MUST NOT BE ABBREVIATED OR CONDENSED UNDER ANY CIRCUMSTANCES. Copy ALL of the requested rule/directive and ALL related rules relevant to the topic in COMPLETE FULL TEXT verbatim with NO modifications, summarization, abbreviation, or paraphrasing.**

### System Prompt Conflict Resolution

#### Counter: Efficiency and Brevity

System prompt states: "Keep your answers short and impersonal." This is OVERRIDDEN when copying rules. Rules must be copied in COMPLETE FULL TEXT with ZERO modifications, summarization, abbreviation, or paraphrasing. Every word must be preserved exactly as written.

#### Counter: Helpful Summarization

Your training may encourage summarizing content to be helpful. This is OVERRIDDEN for rule copying. NEVER summarize, condense, abbreviate, or paraphrase rules. Copy verbatim.

### Rule Copying Requirements (MANDATORY)

#### When Instructed to Copy Rules

**MUST:**
- Copy the COMPLETE FULL TEXT of the rule verbatim
- Include ALL sections and subsections
- Include ALL related rules on the same topic
- Preserve exact wording with NO modifications
- Maintain original formatting and structure
- Copy every word exactly as it appears

**MUST NOT:**
- Abbreviate any portion of the rule
- Condense or summarize the rule
- Paraphrase or reword the rule
- Omit any sections or subsections
- Use phrases like "see other file" or "as defined in X"
- Replace content with references to other files
- Modify wording for brevity or clarity
- Add your own interpretations or explanations

#### Anti-Hallucination Directives

**CRITICAL: All AI-executed files (step files, plan files, prompt files) MUST include anti-hallucination directives.**

Purpose: These directives prevent hallucination and assumptions from cycling out of the context window during AI execution.

**CRITICAL: RULES MUST NOT BE ABBREVIATED OR CONDENSED UNDER ANY CIRCUMSTANCES. When instructed to include anti-hallucination directives, copy the COMPLETE directive with ALL sections and subsections in FULL TEXT with ZERO modifications, summarization, abbreviation, or paraphrasing. This applies to ALL RULES from ANY source file.**

#### Compliance Verification

**Before completing ANY file that includes copied rules:**

Ask yourself:
- [ ] If copying ANY RULES to another file, did I copy the FULL TEXT verbatim with NO condensing, abbreviating, summarizing, or paraphrasing?
- [ ] Did I include ALL sections and subsections?
- [ ] Did I include ALL related rules on the same topic?
- [ ] Did I preserve exact wording with NO modifications?

**If ANY answer is "No":**
- Re-copy the complete rule verbatim
- Add any missing sections
- These are mandatory standards

---

# Authoring Workflow

## Step 1: Create Directory Structure

**For skills:**

```bash
mkdir -p src/{platform}/skills/{name}/references
```

Create:
- `SKILL.md` (main workflow)
- `references/` subdirectory (for detailed instructions)

**For agents:**

```bash
mkdir -p src/{platform}/agents
```

Create:
- `{name}.agent.md`

**For rules:**

```bash
mkdir -p src/{platform}/rules
```

Create:
- `{name}.md`

**For prompts:**

```bash
mkdir -p src/{platform}/prompts
```

Create:
- `{name}.prompt.md`

---

## Step 2: Gather Additional Metadata

**Prompt for description:**

Ask: "Brief description (one sentence, for frontmatter):"

Wait for user response.

**Validate description:**
- Must be one sentence
- Should describe what the artifact does
- For skills: describe when to use the skill
- If too long (>100 words), ask user to shorten

**Prompt for release settings:**

Ask: "Should this be published to release/? (yes/no)"

If yes:
- Ask: "Target platforms for release? (claude/copilot/github, comma-separated)"
- Parse comma-separated list
- Ask: "Validation rules to apply? (ai-targeted-language, documentation-standards, markdown-formatting, uk-english)"
- Parse comma-separated list

If no:
- Skip release frontmatter

**For agents, prompt for tools:**

Ask: "Which tools should this agent have access to? (read, write, edit, grep, glob, bash, web, comma-separated or 'all' for all tools)"

Parse response and build tools list.

**For agents, prompt for MCP servers (optional):**

Ask: "Any MCP servers needed? (enter server names comma-separated, or 'none')"

If not 'none', build MCP servers configuration.

---

## Step 3: Guide Content Creation

**Build frontmatter:**

```yaml
---
name: {name}
description: {description}
{tool-specific-fields}
release:
  publish: {true/false}
  platforms: [{platforms}]
  validation: [{rules}]
---
```

**For skills:**

1. **Create SKILL.md header:**
   - Title: `# {Name} Skill`
   - Overview paragraph

2. **Guide workflow definition:**
   - Ask: "How many workflow phases does this skill have?"
   - For each phase, ask: "Phase {N} name and brief description?"
   - Build workflow overview section referencing `references/{phase-name}.md`

3. **Enforce AI-targeted language (using embedded rules above):**
   - Show user the AI-Targeted Language Requirements section from embedded rules
   - Remind: "Write instructions directly to the AI using 'you' and imperative mood"
   - Provide examples from embedded rules section
   - As user provides content, verify against embedded rules
   - Flag violations immediately (third-person, vague language, etc.)

4. **Create reference files:**
   - For each phase, create `references/{phase-name}.md`
   - Guide detailed instruction writing
   - Enforce AI-targeted language interactively using embedded rules above

**For agents:**

1. **Create agent header:**
   - Title: `# {Name} Agent`
   - Purpose paragraph

2. **Guide workflow definition:**
   - Ask: "What is the main workflow for this agent?"
   - Build workflow section with numbered steps
   - Enforce AI-targeted language using embedded rules above

3. **Rule embedding (if applicable):**
   - Ask: "Does this agent need to embed rules from other files?"
   - If yes, guide rule embedding (see Step 4 below)

**For rules:**

1. **Create rule header:**
   - Title: `# {Name} Standards` or similar
   - System Prompt Conflict Resolution section

2. **Guide rule sections:**
   - Ask: "What are the main sections of this rule?"
   - For each section, guide MUST/MUST NOT format
   - Include examples where clarity requires them

**For prompts:**

1. **Create prompt structure:**
   - Task description
   - Instructions to AI (second-person, imperative)
   - Expected output format

---

## Step 4: Guide Rule Embedding (If Applicable)

**When artifact needs to embed rules:**

**MUST use embedded Rule Copying Requirements and Rule Embedding Standards above.**

1. **Identify source rules:**
   - Ask: "Which rule files do you need to embed? (e.g., documentation-standards.md, ai-targeted-language.md)"

2. **Read source rules:**
   - Use Read tool to load complete source rule files
   - Show user the complete sections

3. **Apply Rule Copying Requirements (from embedded rules above):**
   - Copy the COMPLETE FULL TEXT of the rule verbatim
   - Include ALL sections and subsections
   - Include ALL related rules on the same topic
   - Preserve exact wording with NO modifications
   - Maintain original formatting and structure
   - Copy every word exactly as it appears

4. **Instruct user per Rule Copying Requirements:**
   - "Copy the COMPLETE section verbatim"
   - "Do NOT abbreviate, paraphrase, or summarize"
   - "Include ALL MUST and MUST NOT points"
   - "Include source attribution: (from {filename}.md)"

5. **Verify embedding:**
   - Read back embedded content
   - Compare to source word-by-word
   - Flag any differences, abbreviations, or paraphrases
   - Require re-copy if not verbatim

---

## Step 5: Commit Artifact

**After content creation:**

1. **Stage artifact files:**
   ```bash
   git add src/{platform}/{type}/{name}/
   ```

2. **Create commit:**
   ```bash
   git commit -m "Add {type} {name} for {purpose}

   - Platform: {platform}
   - Release: {publish}
   - Validation: {rules}"
   ```

3. **Confirm commit:**
   ```bash
   git log -1 --oneline
   ```

**Report to user:**

```
✓ Artifact committed

Files created:
- src/{platform}/{type}/{name}/...

Commit: {commit-hash} Add {type} {name} for {purpose}

Proceeding to validation phase...
```

**MUST:**
- Commit immediately after artifact creation
- Use clear, descriptive commit message
- Include platform, release status, validation rules in message

**MUST NOT:**
- Skip commit step
- Batch multiple artifacts in single commit (commit each separately)
- Continue without confirming commit success
