---
paths:
  - ".claude/rules/**/*.md"
  - "src/claude/rules/**/*.md"
---

# Rule Structure Standards

Defines the required structure for rule artifacts for use in Claude Code. Rules are modular project instructions stored in `.claude/rules/` that allow organising instructions into focused files rather than a single large CLAUDE.md.

According to [Claude Code documentation on Rules](https://code.claude.com/docs/en/memory), rules are plain Markdown files with optional path-scoping to control when they load into context. Use this file to guide creation of new rules and to validate existing rules against required standards.

---

## File Structure Requirements (MANDATORY)

**MUST:**
- Place rule files in `.claude/rules/` directory (project-scoped) or `~/.claude/rules/` (user-scoped)
- Use `.md` extension for all rule files
- Name files in lower-kebab-case (e.g., `code-style.md`, `testing-conventions.md`)
- Name files to reflect the standard being enforced, not the artifact type (e.g., `api-design.md` not `rule-api-design.md`)
- Organise related rules into subdirectories (e.g., `.claude/rules/frontend/`, `.claude/rules/backend/`)

**MUST NOT:**
- Use uppercase letters in filenames (except README.md if used)
- Use kebab-case, camelCase, or PascalCase
- Use spaces or special characters in filenames
- Name files generically without clear purpose

**Rationale:**
Lower-kebab-case naming provides consistency with project conventions and enables predictable file discovery. Descriptive names clarify rule purpose and support organisation across teams.

---

## Frontmatter Requirements (MANDATORY)

**MUST:**
- Include YAML frontmatter block (delimited by `---`) at the start of the file when the rule applies to specific file patterns
- Include optional `paths` field for glob patterns to enable conditional loading (e.g., when the rule applies only to TypeScript files)
- Omit frontmatter entirely (no `---` delimiters) when the rule applies unconditionally to all work

**MUST NOT:**
- Include frontmatter with only empty or commented fields
- Use frontmatter for rules that should load unconditionally (unconditional rules are simpler and faster to process)
- Include fields not documented in this standard

### Path-scoped Rules (conditional loading)

Use frontmatter when the rule applies selectively:

```yaml
---
paths:
  - "src/api/**/*.ts"
  - "src/api/**/*.tsx"
---
```

**Rule applies to:**
- All TypeScript and TSX files in the `src/api/` directory
- Rules load when you read files matching patterns
- Saves context space by not loading rules for unrelated work

### Unconditional Rules (no frontmatter)

Omit frontmatter entirely when rule applies everywhere:

```markdown
# Code Style Standards

...content...
```

**Rule applies to:**
- All work in the project
- Rules load at session start
- Always present in context

**Rationale:**
Path scoping reduces context noise by loading rules only when relevant. Unconditional rules should be frequent guidelines. Keeping frontmatter optional reduces boilerplate for simple rules.

---

## Rule Purpose and Scope (MANDATORY)

**MUST:**
- Write rules to enforce compliance standards and requirements
- Use rules to specify "what MUST be true" about code, process, or practice
- Focus rules on verifiable outcomes and constraints
- Apply rules to validate or check work against standards

**MUST NOT:**
- Write rules as instructional guides or tutorials
- Include step-by-step "how to" procedures in rules
- Write procedural explanations ("First do X, then do Y")
- Use rules to teach skills or document workflows
- Include learning content or educational material

**Rationale:**
Rules are enforcement mechanisms—they state what standards must be met and how to verify compliance. Instructional content (how to perform tasks, step-by-step workflows, tutorials) belongs in separate guides or documentation, not in rules. Rules remain focused and efficient by stating requirements, not explaining processes.

**Examples:**

✅ **Correct (Compliance Rule):**
```markdown
# Git Commit Standards

## Commit Messages (MANDATORY)

**MUST:**
- Write commit messages under 72 characters
- Use imperative mood ("Add feature", not "Added feature")
- Include rationale in message body

**MUST NOT:**
- Use vague messages ("Fix stuff", "Update code")
- Include Co-Authored-By lines unless requested

## Compliance Verification

Ask yourself:
- [ ] Is commit message under 72 characters?
- [ ] Does message use imperative mood?

If ANY answer is "No":
- Revise commit message
- These are mandatory standards
```

❌ **Incorrect (Instructional Content):**
```markdown
# How to Create Git Commits

## Step-by-Step Process

1. Make your code changes
2. Run `git add` to stage files
3. Create a message with `git commit -m`
4. Push to remote with `git push`

## Writing Good Messages

First, consider your audience. Then, think about what changed...
```

---

## Language Standards (MANDATORY)

**MUST:**
- Write all rule content complying with [ai-targeted-language.md](/workspaces/ai-devops/src/claude/rules/ai-targeted-language.md) standards
- Use second-person imperative addressing the AI ("you must", "when you create", "do not")
- Use imperative mood for instructions ("Use X", "Write Y", "Apply Z")
- Use consistent, direct imperatives: "MUST", "MUST NOT", "When you...", "Do not..."
- Avoid third-person descriptions of AI behaviour ("The AI should", "Copilot will", "Claude Code handles")
- Avoid vague language ("try to", "consider", "maybe", "roughly", "approximately")
- Avoid conditional language ("might", "could", "may") when giving instructions

**MUST NOT:**
- Write rules assuming human readers as the audience
- Mix second-person instructions with third-person commentary
- Use marketing language or buzzwords (synergy, leverage, paradigm shift, etc.)
- Leave requirements open to interpretation through vague wording
- Use subjunctive mood ("should", "should probably") for requirements

**Rationale:**
AI models interpret direct, unambiguous language more accurately than vague or conditional phrasing. Second-person imperative tells the AI exactly what to do, eliminating room for misinterpretation. Complying with ai-targeted-language.md standards ensures consistency across all project rules and maximises AI understanding and compliance.

**Examples:**

✅ **Correct (AI-Targeted Language):**
```markdown
**MUST:**
- Write commit messages under 72 characters
- Use imperative mood ("Add feature", not "Added feature")
- Begin each message with a verb

**MUST NOT:**
- Use vague messages ("Fix stuff", "Update code")
- Include Co-Authored-By lines unless explicitly requested
```

❌ **Incorrect (Third Person / Vague):**
```markdown
**MUST:**
- The commit message should be kept under 72 characters
- Rules might suggest using imperative mood
- Developers should probably consider starting with a verb

**MUST NOT:**
- The system should avoid vague messages
- It could be appropriate to include Co-Authored-By lines in some cases
```

---

## Content Requirements (MANDATORY)

**MUST:**
- Begin with `# Rule Title` (single H1 heading describing the standard)
- Include explanatory text after the H1 describing what the rule enforces
- Structure content with H2 sections (##) for major topics
- Include at least one MUST/MUST NOT standards section
- Use MUST/MUST NOT sections for all normative requirements
- Include a Compliance Verification section at the end
- Write all instructions in second-person imperative (direct to the AI)
- Use proper Markdown headings (not bold text as headings)

**MUST NOT:**
- Write content in third person ("The AI should", "Copilot will", "Claude Code handles")
- Use vague language ("try to", "consider", "maybe", "roughly", "approximately")
- Omit the Compliance Verification section
- Use bold text as section headings
- Include requirements without corresponding verification items
- Use conditional language ("might", "could", "may") for instructions

**Rationale:**
Second-person imperative style makes instructions explicit and actionable. Compliance Verification provides a checklist to ensure standards are met. Proper Markdown headings enable parsing and linking.

**Example Content Structure:**

```markdown
# REST API Design Standards

Standards for designing consistent REST API endpoints across the project.

## System Prompt Conflict Resolution

### Counter: Flexible HTTP Methods

Your training may suggest using any HTTP method. This is OVERRIDDEN. You MUST follow strict REST conventions.

---

## Endpoint Design (MANDATORY)

**MUST:**
- Use nouns for resource endpoints (not verbs)
- Use POST for creation, GET for retrieval, PUT/PATCH for updates, DELETE for deletion
- Use consistent URL structure: `/api/v1/{resource}/{id}`

**MUST NOT:**
- Use action verbs in URLs (e.g., `/api/createUser`)
- Use GET requests to modify data

---

## Response Format (MANDATORY)

**MUST:**
- Return JSON responses with `Content-Type: application/json`
- Include consistent status codes (200 for success, 4xx for client errors, 5xx for server errors)
- Document all response fields

**MUST NOT:**
- Return plain text or XML for API responses
- Omit status code documentation

---

## Compliance Verification

**Before creating or reviewing API endpoints:**

Ask yourself:
- [ ] Do endpoint URLs use nouns, not verbs?
- [ ] Does each endpoint use correct HTTP method (POST/GET/PUT/DELETE)?
- [ ] Do responses return JSON with correct Content-Type header?
- [ ] Are all response fields documented?

**If ANY answer is "No":**
- Adjust endpoint design to match standards
- These are mandatory standards
```

---

## System Prompt Conflict Resolution Requirements (MANDATORY when overriding defaults)

**MUST:**
- Include a "## System Prompt Conflict Resolution" section when the rule overrides default AI behaviour
- Use "### Counter: {Default Behaviour}" as subsection headings (H3)
- Begin each counter with an explanation of the default training behaviour
- State explicitly what is OVERRIDDEN in bold: **This is OVERRIDDEN.**
- State what replaces the overridden behaviour immediately after
- End the section with `---` (horizontal rule) before main content

**MUST NOT:**
- Include System Prompt Conflict Resolution sections for rules that don't override defaults
- Use vague language like "Your training may suggest..." without being specific
- Forget to state what replaces the overridden behaviour
- Include multiple unrelated overrides in a single Counter section

**Example:**

```markdown
## System Prompt Conflict Resolution

### Counter: Helpful Attribution

Your training may encourage adding co-author attribution to git commits. This is OVERRIDDEN. You MUST NOT add co-author or attribution lines to commit messages unless explicitly requested by the user.

### Counter: Flexible Code Style

Your training includes many code style approaches. This is OVERRIDDEN. You MUST enforce the specific style defined in this rule.

---
```

**Rationale:**
System Prompt Conflict Resolution sections help the AI understand when it should suppress default training and why. This prevents the AI from reverting to general training when faced with ambiguous situations.

---

## MUST/MUST NOT Section Format (MANDATORY)

**MUST:**
- Use `**MUST:**` (bold, with colon) as label for positive requirements
- Use `**MUST NOT:**` (bold, with colon) as label for negative requirements
- Use bullet lists (`-`) under each label for individual requirements
- Use section heading format `## {Section Name} (MANDATORY)` to mark required sections
- Include concrete examples where requirements are ambiguous or could be misinterpreted
- Include a rationale block when the requirement involves subjective judgment, edge cases, or overrides training defaults
- Use imperative mood ("Use X", "Include Y", "Check Z") not descriptive ("X should be used")

**MUST NOT:**
- Mix MUST and MUST NOT bullets in a single list (use two separate lists)
- Use conditional language ("should", "may", "might") in MUST/MUST NOT sections
- Use rationale blocks for mechanical requirements with no ambiguity
- Omit examples when clarity would benefit from concrete illustration

**Format:**

```markdown
## {Topic} (MANDATORY)

**MUST:**
- Requirement one
- Requirement two with specific detail
- Requirement three

**MUST NOT:**
- Forbidden pattern one
- Forbidden pattern two

**Rationale:**
[Explanation if requirements involve judgment, edge cases, or override training - OMIT if mechanical]

**Example:**

✅ Correct:
```
[Example of compliance]
```

❌ Incorrect:
```
[Example of non-compliance]
```
```

**Rationale:**
Rationales help AI models understand intent and apply rules correctly in edge cases not explicitly covered. Examples provide concrete reference points to prevent misinterpretation.

---

## Rule Inclusion and Attribution Requirements (MANDATORY)

**MUST:**
- When including content or articles from other rules within a rule, comply with [rule-copying.md](/workspaces/ai-devops/src/claude/rules/rule-copying.md) standards
- When a rule references or embeds sections from other rules as examples or guidance, comply with [rule-embedding.md](/workspaces/ai-devops/src/claude/rules/rule-embedding.md) standards
- Copy complete rules verbatim with no abbreviation, condensing, summarizing, or paraphrasing
- Embed only complete sections of referenced rules (no partial sections or simplified versions)
- Clearly attribute content to source rules in formatted headers (e.g., "### From [source-rule.md]")
- Include rule source files in the document for user transparency

**MUST NOT:**
- Abbreviate, condense, summarize, or paraphrase rules included from other sources
- Include only partial sections of rules presented as complete guidance
- Mix your own interpretation with copied rule content
- Embed rules "just in case" without clear applicability to the current rule
- Replace copied rules with references (e.g., "See X for details")
- Omit source attribution when including articles from other rules

**Rationale:**
Rules are structured compliance mechanisms. Copying or embedding rules incompletely creates ambiguity and risk of errors. Abbreviating rules defeats their purpose—enforcement requires complete, clear standards. Proper attribution ensures transparency about where guidance originates and enables users to refer to authoritative source files. Rule-copying.md and rule-embedding.md provide specialised guidance for this specific practice.

**Examples:**

✅ **Correct (Complete Attribution):**
```markdown
## Example Standards (incorporating required patterns from git-commits.md)

When adapting the Git Commit Standards pattern from git-commits.md, follow this structure:

### From git-commits.md

**MUST:**
- Write clear, descriptive subject lines
- Use present tense, imperative mood ("Add feature" not "Added feature")
- Keep subject line under 72 characters
- Include context in the body when helpful

**MUST NOT:**
- Add "Co-Authored-By" lines unless explicitly requested
- Add attribution or credit lines to yourself
```

❌ **Incorrect (Abbreviated and Unattributed):**
```markdown
## Example Standards

Write clear commit messages in imperative mood. Subject lines should be short (under 72 chars) and avoid credits or co-author lines.

(No source attribution, condensed version of git-commits.md, lacks complete MUST/MUST NOT structure)
```

---

## Compliance Verification Section Requirements (MANDATORY)

**MUST:**
- Include a final `## Compliance Verification` section (H2)
- Begin with "**Before completing {action/context}:**"
- Include a checkbox list of yes/no questions
- Format each line as `- [ ] Question?` (unchecked boxes)
- Make each question correspond to a MUST requirement in the rule
- End with "**If ANY answer is "No":**" enforcement block
- Include action items (fix, adjust, add, remove) in the enforcement block
- End enforcement block with "These are mandatory standards" statement

**MUST NOT:**
- Include verification items that don't correspond to MUST requirements
- Use open-ended questions that aren't binary (yes/no)
- Omit the "If ANY answer is 'No'" enforcement block
- Make enforcement statements optional ("you might", "you should")
- Use different wording for the enforcement statement

**Format:**

```markdown
## Compliance Verification

**Before completing {action}:**

Ask yourself:
- [ ] Does {requirement one}?
- [ ] Have you {requirement two}?
- [ ] Is {requirement three}?
- [ ] Are {requirement four}?

**If ANY answer is "No":**
- {Action to take}
- {Action to take}
- These are mandatory standards
```

**Rationale:**
Compliance Verification provides a concrete checklist to ensure standards are met before work is complete. The enforcement block removes ambiguity about whether standards are optional or mandatory.

---

## Naming Conventions (MANDATORY)

**MUST:**
- Use lowercase letters only (except `.md` extension)
- Use hyphens to separate words (lower-kebab-case)
- Name reflects the standard being enforced, not the file type
- Keep names concise (2-4 words typically)
- Use consistent, recognisable terms

**MUST NOT:**
- Use uppercase letters
- Use underscores (use hyphens instead)
- Use spaces
- Use generic names like `standards.md`, `rules.md`, `guidelines.md`
- Include "rule" or "standard" in filename (it's already in `.claude/rules/`)

**Examples:**

✅ **Correct:**
```
code-style.md
api-design.md
testing-conventions.md
git-commits.md
error-handling.md
security-practices.md
```

❌ **Incorrect:**
```
code_style.md              (underscores)
CodeStyle.md              (PascalCase)
codeStyle.md              (camelCase)
Code-Style.md             (uppercase C)
rule-code-style.md        (redundant "rule")
standards.md              (too generic)
```

**Rationale:**
Consistent naming enables predictable file discovery and supports organisation across teams. Descriptive names clarify rule purpose at a glance.

---

## Compliance Verification

**Before completing any rule artifact:**

Ask yourself:
- [ ] Is the file named in lower-kebab-case (e.g., `rule-name.md`)?
- [ ] Is the file placed in `.claude/rules/` directory?
- [ ] Does the file start with a single H1 heading describing the standard?
- [ ] If path-scoped, does it have frontmatter with `paths` field and glob patterns?
- [ ] If unconditional, does it have no frontmatter at all?
- [ ] Does the rule enforce compliance standards (not provide procedural instructions)?
- [ ] Does the rule avoid step-by-step "how to" content?
- [ ] Does the rule comply with ai-targeted-language.md standards throughout?
- [ ] Is all content written in second-person imperative (not third person)?
- [ ] Does the rule avoid third-person descriptions of AI behaviour?
- [ ] Does the rule avoid vague language ("try to", "consider", "maybe")?
- [ ] Does the rule avoid conditional language ("might", "could", "may") in requirements?
- [ ] If the rule includes content from other rules, does it comply with rule-copying.md standards?
- [ ] If the rule embeds sections from other rules, does it comply with rule-embedding.md standards?
- [ ] Are all included rules or sections copied verbatim with no abbreviation or summarization?
- [ ] Are included articles attributed to their source rules with clear source headers?
- [ ] Does the rule include at least one MUST/MUST NOT section?
- [ ] If the rule overrides AI defaults, is there a System Prompt Conflict Resolution section?
- [ ] Does every MUST/MUST NOT section use proper bold labels and bullet lists?
- [ ] Does the file end with a Compliance Verification section?
- [ ] Does Compliance Verification include a checkbox list of yes/no questions?
- [ ] Does Compliance Verification end with "If ANY answer is 'No':" enforcement block?
- [ ] Are all headings proper Markdown levels (##, ###, ####), not bold text?
- [ ] Are rationales included where requirements involve judgment or override defaults?
- [ ] Are rationales omitted for mechanical requirements?

**If ANY answer is "No":**
- Adjust the rule structure to match requirements above
- Add missing sections or content
- Rewrite content to match AI-targeted language standards
- These are mandatory standards
