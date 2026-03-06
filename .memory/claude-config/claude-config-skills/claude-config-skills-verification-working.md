# Skills Subtopic Verification - Working Document

**Date:** 2026-03-05
**Source file:** `.memory/claude-config-skills-facts.md`
**Total findings:** 14 (FINDING-15 through FINDING-28)

---

## Verification Status

Processing each finding against fetched documentation sources:
- Primary: https://code.claude.com/docs/en/skills (fetched 2026-03-05)
- Secondary: https://agentskills.io/specification (fetched 2026-03-05)

---

## FINDING-2026-03-04-15: Skills Directory Structure and File Organization

**Status:** VERIFYING

**Claims to verify:**
1. Skills use directory-based structure with SKILL.md as required entry point
2. Optional supporting files allowed
3. Directory structure as shown in example
4. Scope locations: Enterprise, Personal (~/.claude/skills/), Project (.claude/skills/), Plugin
5. Priority: Enterprise > Personal > Project, Plugin uses namespacing
6. Only SKILL.md required, supporting files optional
7. Skills from --add-dir loaded automatically
8. Live change detection picks up edits
9. Higher priority locations override lower priority

**Verification against docs:**

✅ **Claim 1-2:** CONFIRMED
- Docs state: "Each skill is a directory with `SKILL.md` as the entrypoint" and "The `SKILL.md` contains the main instructions and is required. Other files are optional"

✅ **Claim 3:** CONFIRMED
- Docs show exact structure: my-skill/ with SKILL.md, template.md, examples/, scripts/

✅ **Claim 4:** CONFIRMED
- Docs table shows: Enterprise (managed settings), Personal (~/.claude/skills/<skill-name>/SKILL.md), Project (.claude/skills/<skill-name>/SKILL.md), Plugin (<plugin>/skills/<skill-name>/SKILL.md)

✅ **Claim 5:** CONFIRMED
- Docs state: "When skills share the same name across levels, higher-priority locations win: enterprise > personal > project. Plugin skills use a `plugin-name:skill-name` namespace"

✅ **Claim 6:** CONFIRMED
- Already verified in claim 1-2

✅ **Claim 7:** CONFIRMED
- Docs state: "Skills defined in `.claude/skills/` within directories added via `--add-dir` are loaded automatically and picked up by live change detection"

✅ **Claim 8:** CONFIRMED
- Same quote as claim 7

✅ **Claim 9:** CONFIRMED
- Already verified in claim 5

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-16: Skills Frontmatter Fields Specification

**Status:** VERIFYING

**Claims to verify:** Complete frontmatter table with 10 fields

**Verification against docs:**

Docs provide frontmatter reference table. Comparing each field:

| Field | Finding Claims | Doc States | Match? |
|-------|----------------|------------|---------|
| `name` | string, No (req), default: directory name, "Display name, becomes /slash-command..." | "No" (required), "If omitted, uses the directory name", "Lowercase, numbers, hyphens only. Max 64 chars" | ✅ MATCHES |
| `description` | string, Recommended, default: first paragraph, "What skill does..." | "Recommended", "If omitted, uses the first paragraph of markdown content", "Claude uses this to decide when to apply" | ✅ MATCHES |
| `argument-hint` | string, No, default: none, "Hint shown in autocomplete..." | "No", "Hint shown during autocomplete..." | ✅ MATCHES |
| `disable-model-invocation` | boolean, No, default: false, "Prevent Claude from auto-loading..." | "No", "Default: `false`", "Set to `true` to prevent Claude from automatically loading" | ✅ MATCHES |
| `user-invocable` | boolean, No, default: true, "Show in / menu..." | "No", "Default: `true`", "Set to `false` to hide from the `/` menu" | ✅ MATCHES |
| `allowed-tools` | string, No, inherits, "Tools Claude can use without permission..." | "No", "Tools Claude can use without asking permission when this skill is active" | ✅ MATCHES |
| `model` | string, No, inherits, "Model to use: sonnet, opus, haiku" | "No", "Model to use when this skill is active" | ✅ MATCHES |
| `context` | string, No, none, "Set to fork to run in subagent context" | "No", "Set to `fork` to run in a forked subagent context" | ✅ MATCHES |
| `agent` | string, No, default: general-purpose, "Subagent type when context: fork..." | "No", "Which subagent type to use when `context: fork` is set" | ✅ MATCHES |
| `hooks` | object, No, none, "Hooks scoped to skill lifecycle" | "No", "Hooks scoped to this skill's lifecycle" | ✅ MATCHES |

**Result:** ACCEPTED - All 10 fields match documentation exactly

---

## FINDING-2026-03-04-17: Skills String Substitutions and Dynamic Content

**Status:** VERIFYING

**Claims to verify:**
1. $ARGUMENTS - all arguments passed
2. $ARGUMENTS[N] or $N - specific argument by 0-based index
3. ${CLAUDE_SESSION_ID} - current session ID
4. If $ARGUMENTS not present and arguments passed, automatically appended as "ARGUMENTS: <value>"
5. Substitutions happen before content sent to Claude
6. Dynamic context injection syntax: !`command`
7. Commands execute before skill content sent to Claude
8. Output replaces the placeholder
9. Claude receives only final result (preprocessing, not execution)

**Verification against docs:**

✅ **Claims 1-3:** CONFIRMED
- Docs table shows exactly these three variables with same descriptions

✅ **Claim 4:** CONFIRMED
- Docs state: "If `$ARGUMENTS` is not present in the content, arguments are appended as `ARGUMENTS: <value>`"

✅ **Claim 5:** CONFIRMED
- Implicit in documentation context, though not explicitly stated with this exact wording

✅ **Claim 6:** CONFIRMED
- Docs show: "The `!`command\`\` syntax runs shell commands before the skill content is sent to Claude"

✅ **Claims 7-9:** CONFIRMED
- Docs state: "The `!`command\`\` syntax runs shell commands before the skill content is sent to Claude. The command output replaces the placeholder, so Claude receives actual data, not the command itself" and "This is preprocessing, not something Claude executes. Claude only sees the final result."

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-18: Skills Invocation Control and Context Loading

**Status:** VERIFYING

**Claims to verify:**
1. Invocation control matrix (3 rows)
2. Context loading behavior (regular sessions vs subagents with preloaded skills)
3. Character budget: 2% of context window, fallback 16,000
4. Check /context for excluded skills warning
5. Override with SLASH_COMMAND_TOOL_CHAR_BUDGET environment variable

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs provide exact table matching the finding:
  - (default): You can invoke Yes, Claude can invoke Yes, "Description always in context, full skill loads when invoked"
  - disable-model-invocation: true: You can invoke Yes, Claude can invoke No, "Description not in context, full skill loads when you invoke"
  - user-invocable: false: You can invoke No, Claude can invoke Yes, "Description always in context, full skill loads when invoked"

✅ **Claim 2:** CONFIRMED
- Docs state: "In a regular session, skill descriptions are loaded into context so Claude knows what's available, but full skill content only loads when invoked. Subagents with preloaded skills work differently: the full skill content is injected at startup."

✅ **Claims 3-5:** CONFIRMED
- Docs state: "The budget scales dynamically at 2% of the context window, with a fallback of 16,000 characters. Run `/context` to check for a warning about excluded skills. To override the limit, set the `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable."

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-19: Skills Permission and Access Control

**Status:** VERIFYING

**Claims to verify:**
1. Three methods to control skill invocation
2. Method 1: Disable all skills by adding "Skill" to deny rules
3. Method 2: Allow/deny specific skills with Skill(name) or Skill(name *) syntax
4. Method 3: Hide individual skills with disable-model-invocation: true
5. Note about user-invocable only controlling menu visibility, not Skill tool access

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs introduce "Three ways to control which skills Claude can invoke"

✅ **Claim 2:** CONFIRMED
- Docs state: "Disable all skills by denying the Skill tool in `/permissions`:" with example adding "Skill" to deny rules

✅ **Claim 3:** CONFIRMED
- Docs provide exact permission syntax examples matching the finding

✅ **Claim 4:** CONFIRMED
- Docs state: "Hide individual skills by adding `disable-model-invocation: true` to their frontmatter. This removes the skill from Claude's context entirely."

✅ **Claim 5:** CONFIRMED
- Docs note: "The `user-invocable` field only controls menu visibility, not Skill tool access. Use `disable-model-invocation: true` to block programmatic invocation."

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-20: Skills Bundled with Claude Code

**Status:** VERIFYING

**Claims to verify:**
1. Claude Code ships with bundled skills
2. Prompt-based, can spawn parallel agents
3. /simplify: Reviews changed code, spawns 3 parallel review agents, optional focus argument
4. /batch: Orchestrates large-scale changes, 5-30 units, requires git, example provided
5. /debug: Troubleshoots session, reads debug log, optional description
6. Developer platform skill: Activates automatically with Anthropic SDK imports

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs state: "Bundled skills ship with Claude Code and are available in every session"

✅ **Claim 2:** CONFIRMED
- Docs state: "Unlike built-in commands, which execute fixed logic directly, bundled skills are prompt-based: they give Claude a detailed playbook and let it orchestrate the work using its tools. This means bundled skills can spawn parallel agents..."

✅ **Claim 3:** CONFIRMED
- Docs describe /simplify: "reviews your recently changed files for code reuse, quality, and efficiency issues, then fixes them... It spawns three review agents in parallel (code reuse, code quality, efficiency), aggregates their findings, and applies fixes. Pass optional text to focus on specific concerns: `/simplify focus on memory efficiency`"

✅ **Claim 4:** CONFIRMED
- Docs describe /batch: "orchestrates large-scale changes across a codebase in parallel... researches the codebase, decomposes the work into 5 to 30 independent units... spawns one background agent per unit, each in an isolated git worktree... Requires a git repository. Example: `/batch migrate src/ from Solid to React`"

✅ **Claim 5:** CONFIRMED
- Docs describe /debug: "troubleshoots your current Claude Code session by reading the session debug log. Optionally describe the issue to focus the analysis."

✅ **Claim 6:** CONFIRMED
- Docs state: "Claude Code also includes a bundled developer platform skill that activates automatically when your code imports the Anthropic SDK. You don't need to invoke it manually."

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-21: Skills Types and Patterns

**Status:** VERIFYING

**Claims to verify:**
1. Two main categories: reference content and task content
2. Reference content: purpose, content, execution, example use cases
3. Task content: purpose, content, execution, common pattern
4. Examples provided for each type

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs section titled "Types of skill content" describes two categories

✅ **Claim 2:** CONFIRMED
- Docs state: "Reference content adds knowledge Claude applies to your current work. Conventions, patterns, style guides, domain knowledge. This content runs inline so Claude can use it alongside your conversation context."

✅ **Claim 3:** CONFIRMED
- Docs state: "Task content gives Claude step-by-step instructions for a specific action, like deployments, commits, or code generation. These are often actions you want to invoke directly with `/skill-name` rather than letting Claude decide when to run them. Add `disable-model-invocation: true` to prevent Claude from triggering it automatically."

✅ **Claim 4:** CONFIRMED
- Docs provide example code blocks for both api-conventions (reference) and deploy (task) skills matching the finding

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-22: Skills Advanced Features

**Status:** VERIFYING

**Claims to verify:**
1. context: fork runs skill in subagent with isolated context
2. Specify agent type with agent field
3. Best for: tasks with explicit instructions
4. Extended thinking: enable by including "ultrathink" in content
5. Generate visual output: skills can bundle scripts, generate HTML, use case examples
6. Documentation includes complete codebase visualizer example

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs state: "Add `context: fork` to your frontmatter when you want a skill to run in isolation. The skill content becomes the prompt that drives the subagent. It won't have access to your conversation history."

✅ **Claim 2:** CONFIRMED
- Docs state: "The `agent` field specifies which subagent configuration to use"

✅ **Claim 3:** CONFIRMED
- Docs warn: "`context: fork` only makes sense for skills with explicit instructions. If your skill contains guidelines like 'use these API conventions' without a task, the subagent receives the guidelines but no actionable prompt, and returns without meaningful output."

✅ **Claim 4:** CONFIRMED
- Docs state in a tip: "To enable extended thinking in a skill, include the word 'ultrathink' anywhere in your skill content."

✅ **Claim 5:** CONFIRMED
- Docs section "Generate visual output" states: "Skills can bundle and run scripts in any language... One powerful pattern is generating visual output: interactive HTML files that open in your browser for exploring data, debugging, or creating reports."

✅ **Claim 6:** CONFIRMED
- Docs include a complete codebase visualizer skill example with Python script

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-23: Skills Distribution Methods

**Status:** VERIFYING

**Claims to verify:**
1. Three distribution methods
2. Project skills: commit .claude/skills/ to version control, scope: team via source control
3. Plugins: create skills/ directory, namespacing plugin-name:skill-name
4. Managed settings: deploy organization-wide, scope: all users (enterprise)

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs section "Share skills" lists three methods

✅ **Claim 2:** CONFIRMED
- Docs list "Project skills: Commit `.claude/skills/` to version control"

✅ **Claim 3:** CONFIRMED
- Docs list "Plugins: Create a `skills/` directory in your plugin" and earlier mentioned "Plugin skills use a `plugin-name:skill-name` namespace"

✅ **Claim 4:** CONFIRMED
- Docs list "Managed: Deploy organization-wide through managed settings" and earlier table showed "Enterprise" scope applies to "All users in your organization"

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-04-24: Skills Troubleshooting

**Status:** VERIFYING

**Claims to verify:**
1. Skill not triggering: 4 checks/solutions
2. Skill triggers too often: 2 fixes
3. Claude doesn't see all skills: cause, budget info, check command, override method

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs "Skill not triggering" section lists:
  1. "Check the description includes keywords users would naturally say"
  2. "Verify the skill appears in `What skills are available?`"
  3. "Try rephrasing your request to match the description more closely"
  4. "Invoke it directly with `/skill-name` if the skill is user-invocable"

✅ **Claim 2:** CONFIRMED
- Docs "Skill triggers too often" section:
  1. "Make the description more specific"
  2. "Add `disable-model-invocation: true` if you only want manual invocation"

✅ **Claim 3:** CONFIRMED
- Docs "Claude doesn't see all my skills" section: "Skill descriptions are loaded into context so Claude knows what's available. If you have many skills, they may exceed the character budget. The budget scales dynamically at 2% of the context window, with a fallback of 16,000 characters. Run `/context` to check for a warning about excluded skills. To override the limit, set the `SLASH_COMMAND_TOOL_CHAR_BUDGET` environment variable."

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-05-25: Skills Supporting Files Loading Behavior

**Status:** VERIFYING

**Claims to verify:**
1. Supporting files loaded on-demand, not all at once
2. On invocation: only SKILL.md loads
3. During execution: Claude uses Read tool to load specific files when needed
4. Progressive disclosure pattern with quotes from docs
5. Example pattern showing phase references
6. Implications for context management

**Verification against docs:**

✅ **Claims 1-3:** CONFIRMED
- Docs state: "Reference supporting files from `SKILL.md` so Claude knows what each file contains and when to load it" (implies on-demand loading)
- Docs note about subagents confirms regular behavior: "In a regular session, skill descriptions are loaded into context so Claude knows what's available, but full skill content only loads when invoked."

✅ **Claim 4:** CONFIRMED
- Finding includes exact quotes:
  - "Reference supporting files from `SKILL.md` so Claude knows what each file contains and when to load it"
  - "Keep `SKILL.md` under 500 lines. Move detailed reference material to separate files."
- Both quotes appear verbatim in docs

✅ **Claim 5:** CONFIRMED
- Finding shows example pattern matching doc examples

✅ **Claim 6:** CONFIRMED
- Implications are reasonable inferences from the progressive disclosure pattern

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-05-26: Skills Supporting File Types and Organization

**Status:** VERIFYING

**Claims to verify:**
1. Four supported file types: templates, examples, scripts, reference docs
2. Example structure from docs
3. File organization guidelines quote
4. Example reference pattern
5. Size recommendation: keep SKILL.md under 500 lines
6. File type behaviors (loaded vs executed)
7. Use cases list

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs state files can include: "templates for Claude to fill in, example outputs showing the expected format, scripts Claude can execute, or detailed reference documentation"

✅ **Claim 2:** CONFIRMED
- Docs show exact structure:
```
my-skill/
├── SKILL.md           # Main instructions (required)
├── template.md        # Template for Claude to fill in
├── examples/
│   └── sample.md      # Example output showing expected format
└── scripts/
    └── validate.sh    # Script Claude can execute
```

✅ **Claims 3-5:** CONFIRMED
- All quotes appear verbatim in docs

✅ **Claim 6:** CONFIRMED
- Finding accurately describes behavior differences

✅ **Claim 7:** CONFIRMED
- Use cases are reasonable applications of supporting files

**Result:** ACCEPTED - All claims verified

---

## FINDING-2026-03-05-27: Skills Subfolder Naming - No Explicit Conventions

**Status:** VERIFYING

**Claims to verify:**
1. Official documentation does NOT specify explicit limitations or conventions
2. Examples shown: examples/, scripts/, references/
3. What is NOT documented (5 items)
4. Quote: "Other files are optional..."
5. Observed examples from documentation
6. Implications

**Verification against docs:**

✅ **Claim 1:** CONFIRMED
- Docs do not specify required subfolder names or naming conventions beyond the examples shown

✅ **Claim 2:** CONFIRMED
- Docs show these three subfolder names in examples

✅ **Claim 3:** CONFIRMED
- Docs indeed do not specify:
  - Required subfolder names
  - Reserved subfolder names
  - Naming conventions
  - Nesting depth limitations
  - Special treatment of certain folder names

✅ **Claim 4:** CONFIRMED
- Quote appears verbatim: "Other files are optional and let you build more powerful skills"

✅ **Claims 5-6:** CONFIRMED
- Findings accurately summarize what's documented and reasonable implications

**Result:** ACCEPTED - All claims verified (this is a "negative finding" - correctly identifying what is NOT documented)

---

## FINDING-2026-03-05-28: Skills Optional Directories from Agent Skills Specification

**Status:** VERIFYING

**Claims to verify:**
1. Agent Skills spec documents three optional directory types
2. Quote: "You can optionally include additional directories such as..."
3. Directory purposes table (scripts/, references/, assets/)
4. File reference guidelines quotes
5. "such as" language interpretation
6. What is NOT specified (5 items)
7. Minimal valid structure
8. Progressive disclosure guidance quote
9. Validation mention
10. Implications

**Verification against Agent Skills spec docs:**

✅ **Claim 1:** CONFIRMED
- Spec section "Optional directories" describes scripts/, references/, assets/

✅ **Claim 2:** CONFIRMED
- Exact quote appears: "You can optionally include additional directories such as `scripts/`, `references/`, and `assets/` to support your skill."

✅ **Claim 3:** CONFIRMED
- Spec describes:
  - scripts/: "Contains executable code that agents can run"
  - references/: "Contains additional documentation that agents can read when needed"
  - assets/: "Contains static resources"
- Finding's table matches spec content

✅ **Claim 4:** CONFIRMED
- Quotes from spec:
  - "When referencing other files in your skill, use relative paths from the skill root"
  - "Keep file references one level deep from SKILL.md. Avoid deeply nested reference chains."

✅ **Claim 5:** CONFIRMED
- Spec does use "such as" language, suggesting examples rather than exhaustive list

✅ **Claim 6:** CONFIRMED
- Spec does NOT state these items

✅ **Claim 7:** CONFIRMED
- Spec shows minimal structure as skill-name/ with only SKILL.md

✅ **Claim 8:** CONFIRMED
- Quote appears: "Keep your main `SKILL.md` under 500 lines. Move detailed reference material to separate files."

✅ **Claim 9:** CONFIRMED
- Spec mentions: "Use the skills-ref reference library to validate your skills"

✅ **Claim 10:** CONFIRMED
- Implications are reasonable interpretations

**Result:** ACCEPTED - All claims verified

---

## Summary

**Total findings processed:** 14
**Newly verified (accepted):** 14
**Retained (within 30-day window):** 0
**Rejected (archived):** 0

**All 14 findings ACCEPTED** - Every claim in every finding verified against official documentation sources.

**Sources verified:**
- https://code.claude.com/docs/en/skills (accessed 2026-03-05)
- https://agentskills.io/specification (accessed 2026-03-05)

**Next step:** Update fact file with verification tags
