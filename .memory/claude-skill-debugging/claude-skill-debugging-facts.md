# Claude Skill Debugging and Flow Analysis - Findings

## FINDING-2026-04-04-1
**Captured:** 2026-04-04 08:10
**Source:** Analysis of `/workspaces/ai-devops/src/claude/rules/ai-targeted-language.md` requirements and hardened flow specifications in `/workspaces/ai-devops/src/claude/skills/analysis/references/`
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Second-Person Pronoun Ambiguity in Chained Flows

When multiple flows are chained within a single skill invocation (e.g., analytical-research invoking fact-capture), both files use AI-targeted language per ai-targeted-language.md requirements, which mandate second-person pronouns.

**The Problem:**
- analytical-research.md says: "You MUST NOT write directly to fact files" (lines 61-66)
- fact-capture.md says: "You MUST... Create or append to fact files" (lines 15)
- Both use second-person "you", but address different agents
- An agent reading both sequentially cannot determine which instruction applies to which context

**Specific Contradiction Example:**
In analytical-research (lines 61-66), "you" refers to the analytical-research agent:
```
- DO NOT format findings entries
- DO NOT manage fact file structure
- DO NOT update indices
```

In fact-capture (lines 13-51), "you" refers to the fact-capture implementation:
```
- Generate unique FINDING-YYYY-MM-DD-N identifiers
- Create or append to fact files
- Update indices
```

**Impact:** Without explicit context switching, an agent could incorrectly interpret conflicting "you" instructions as a logical contradiction rather than as separate responsibility boundaries for different agents in the call chain.

**Implications for AI-Targeted Language Standard:**
The ai-targeted-language.md mandate (lines 34-38) forbids third-person descriptions ("The AI", "Copilot will") that would disambiguate these contexts. This creates unavoidable ambiguity when flows are chained.

---

## FINDING-2026-04-04-2
**Captured:** 2026-04-04 08:15
**Source:** [Subagent Execution Modes - Claude Config Knowledge Base](https://code.claude.com/docs/en/sub-agents) (from ai-artifact/batch/authoring-workflow branch, FINDING-2026-03-04-31)
**Verified:** [NOT YET VERIFIED - requires verification workflow]
**Clarifies:** (none - root finding about synchronous invocation)

### Synchronous Subagent Invocation Requires `background: false` Frontmatter

Subagents have two execution modes controlled by frontmatter configuration. The default is synchronous/foreground (blocking).

**Key specification:**
- **Default behaviour:** `background: false` (synchronous, blocking)
- **Asynchronous behaviour:** `background: true` (concurrent, non-blocking)
- **Frontmatter field:** `background` (boolean, optional, defaults to false)

**Synchronous (Foreground) Mode:**
- Blocks main conversation until complete
- Permission prompts passed through to user
- Results received before proceeding
- Use when: Need results before proceeding

**Asynchronous (Background) Mode:**
- Runs concurrently in parallel
- Pre-approved permissions only; auto-denies others
- If needs more permissions, tool call fails but continues
- Use when: Have independent work to do in parallel

**Invocation control methods:**
1. Set `background: false` in frontmatter (explicit synchronous)
2. Omit `background` field (defaults to false = synchronous)
3. Ask Claude to "run this in the background" (user request switches to async)
4. Press Ctrl+B to background a running task

**To prevent accidental background execution:** Ensure skill configuration has `background: false` or omit the field entirely.

---

## FINDING-2026-04-04-3
**Captured:** 2026-04-04 08:16
**Source:** [Subagent Frontmatter Fields Complete Specification - Claude Config Knowledge Base](https://code.claude.com/docs/en/sub-agents) (from ai-artifact/batch/authoring-workflow branch, FINDING-2026-03-04-26)
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Complete Subagent Frontmatter Field Specification

When configuring a subagent for synchronous skill invocation, use frontmatter with YAML format. Only `name` and `description` are required; all other fields are optional.

**Complete frontmatter fields:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `name` | string | Yes | none | Unique identifier, lowercase with hyphens only |
| `description` | string | Yes | none | When Claude should delegate to this subagent |
| `tools` | array | No | inherits all | Tools the subagent can use |
| `disallowedTools` | array | No | none | Tools to deny |
| `model` | string | No | `inherit` | Model: `sonnet`, `opus`, `haiku`, or `inherit` |
| `permissionMode` | string | No | inherits | Permission handling: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` |
| `maxTurns` | number | No | none | Maximum agentic turns before stopping |
| `skills` | array | No | none | Skills to preload into subagent context at startup |
| `mcpServers` | array/object | No | none | MCP servers available |
| `hooks` | object | No | none | Lifecycle hooks scoped to this subagent |
| `memory` | string | No | none | Persistent memory scope: `user`, `project`, or `local` |
| `background` | boolean | No | `false` | Run as background task (set to false for synchronous) |
| `isolation` | string | No | none | Set to `worktree` for git worktree isolation |

**Critical for synchronous invocation:**
- Set `background: false` explicitly, or omit the field (defaults to false)
- If `background: true` is set, subagent will run asynchronously and return immediately

---

## FINDING-2026-04-04-4
**Captured:** 2026-04-04 08:20
**Source:** [Skills Frontmatter Fields Specification - Claude Config Knowledge Base](https://code.claude.com/docs/en/skills) (from ai-artifact/batch/authoring-workflow branch, FINDING-2026-03-04-16 and FINDING-2026-03-04-18)
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Skill Frontmatter Fields Controlling Sub-Agent Invocation and Execution

Skills support comprehensive frontmatter configuration in YAML format. Two specific frontmatter fields control whether and how a skill runs in a sub-agent context.

**Frontmatter fields for sub-agent invocation:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `context` | string | No | none | Set to `fork` to run in subagent context (isolated agent) |
| `agent` | string | No | `general-purpose` | Subagent type when `context: fork`. Options: `Explore`, `Plan`, `general-purpose`, or custom skill/agent name |

**Complete frontmatter fields specification:**

| Field | Type | Required | Default | Description |
|-------|------|----------|---------|-------------|
| `name` | string | No | directory name | Display name, becomes `/slash-command`. Lowercase, numbers, hyphens only. Max 64 chars |
| `description` | string | Recommended | first paragraph | What skill does and when to use it. Claude uses for auto-invocation decisions |
| `argument-hint` | string | No | none | Hint shown in autocomplete. Example: `[issue-number]` |
| `disable-model-invocation` | boolean | No | `false` | Prevent Claude from auto-loading. Use for manual-only workflows |
| `user-invocable` | boolean | No | `true` | Show in `/` menu. Set `false` for background knowledge |
| `allowed-tools` | string | No | inherits | Tools Claude can use without permission when skill active |
| `model` | string | No | inherits | Model to use: `sonnet`, `opus`, `haiku` |
| `context` | string | No | none | **Set to `fork` to run in subagent context** |
| `agent` | string | No | `general-purpose` | **Subagent type when `context: fork`. Options: `Explore`, `Plan`, `general-purpose`, or custom** |
| `hooks` | object | No | none | Hooks scoped to skill lifecycle |

**Sub-agent execution behavior:**

When `context: fork` is set in frontmatter:
- Skill content becomes the prompt injected into the specified subagent
- Skill runs in isolated subagent context (separate from main conversation)
- The `agent` field determines which subagent type receives the skill content
- Available subagent types:
  - `Explore` (Haiku model, read-only tools)
  - `Plan` (Plan mode, read-only exploration)
  - `general-purpose` (Default, inherits all tools and permissions)
  - Custom skill or agent names (if defined in configuration)

**Example with sub-agent invocation:**
````yaml
---
name: code-reviewer
description: Reviews code for quality and best practices
context: fork
agent: Explore
---
````

**Important consideration:** Skills with `context: fork` behave differently from regular subagents:
- Skill content becomes the system prompt for the subagent
- Full skill content injected at startup (not loaded on-demand like regular context)
- Execution mode (foreground/background) depends on how the skill is invoked, not frontmatter

---

## FINDING-2026-04-04-5
**Captured:** 2026-04-04 08:25
**Source:** [Skills Advanced Patterns and `context: fork` Behaviour - Claude Config Knowledge Base](https://code.claude.com/docs/en/skills) (from ai-artifact/batch/authoring-workflow branch, FINDING not yet explicitly numbered in source)
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Skills Automatically Spawn Sub-Agents When `context: fork` is Set

When a skill includes `context: fork` in its frontmatter, it automatically spawns a new sub-agent containing itself. No pre-defined sub-agent configuration is required.

**Automatic sub-agent spawning behaviour:**

When `context: fork` is configured:
- Skill content automatically becomes the prompt for a new sub-agent
- The specified `agent` field determines the sub-agent type (Explore, Plan, general-purpose, or custom)
- Sub-agent is spawned on-demand when the skill is invoked
- Full skill content injected at startup of the spawned sub-agent
- Sub-agent runs in isolated context (does not have access to main conversation history)

**Example:**
````yaml
---
name: deep-research
description: Research topic thoroughly
context: fork
agent: Explore
---

Research $ARGUMENTS thoroughly:
1. Find relevant files
2. Analyze code
3. Summarize findings
````

When invoked, this automatically:
- Spawns a new `Explore` sub-agent
- Injects the skill content as the sub-agent's system prompt
- The sub-agent receives the isolated context and performs the specified research task

**Critical design requirement:** Skills with `context: fork` must contain explicit instructions and actionable tasks in their content.

**Failure case:** If skill content contains only guidelines (e.g., "Use these API conventions") without an actionable task, the spawned sub-agent receives guidelines but no task, resulting in meaningless output or no output.

**Correct pattern:**
- Skill content = explicit step-by-step instructions
- Skill content = actionable task for the sub-agent to perform
- Guidelines alone are insufficient for `context: fork` skills

**Consequence for fact-capture flow problem:** When `/verify-analysis fact` is invoked as a skill with `context: fork` configured, it automatically spawns a sub-agent containing the skill content as the system prompt. This explains why the invocation returned silently with "(forked execution)" — the Skill tool automatically spawned an isolated sub-agent without blocking for results.

---

## FINDING-2026-04-04-6
**Captured:** 2026-04-04 08:28
**Source:** Architectural analysis based on FINDING-2026-04-04-1, FINDING-2026-04-04-4, FINDING-2026-04-04-5, and observed skill invocation behaviour
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Architectural Root Cause: Single Skill with Multiple Chained Flows Causes Governance Ambiguity

When multiple flows are combined into a single skill file, the combination creates unavoidable ambiguity and loss of control over individual flow behaviour and responsibility boundaries.

**The problem:**

Skills with multiple chained flows violate single-responsibility principle and create governance issues:

1. **Pronoun ambiguity (FINDING-2026-04-04-1):** Both flows use second-person "you" per AI-targeted language requirement, but address different agents. AI-targeted language forbids third-person disambiguation, making it impossible to clearly distinguish which instructions apply to which flow without context switching that the rule forbids.

2. **Context forking affects entire skill (FINDING-2026-04-04-5):** If any flow requires `context: fork`, the entire skill spawns into a sub-agent. This means:
   - Cannot selectively isolate one flow (e.g., verify-analysis in sub-agent, fact-capture in main)
   - All flows inherit the `context: fork` behaviour
   - Harder to have different invocation strategies per flow

3. **Asynchronous spawning breaks synchronous requirements:** When skill uses `context: fork`, it automatically spawns a sub-agent and returns immediately with "(forked execution)". This breaks fact-capture's requirement for synchronous blocking invocation. The spawned sub-agent runs independently without reporting results back through the Skill tool.

4. **Responsibility boundaries blur:** Single skill makes it unclear:
   - Which agent (flow) is responsible for what?
   - Should research flow format findings, or should fact-capture?
   - Who owns verification: fact-capture or verify-analysis?
   - Who manages indices and file structure?

5. **Invocation contract ambiguity:** Research workflow doesn't know:
   - Does fact-capture return synchronously or asynchronously?
   - When fact-capture invokes verify-analysis, is it blocking or non-blocking?
   - What status should fact-capture return if verification fails?

**The recommendation:**

**Build modular skills with clear responsibilities instead of multi-flow skills:**
- Each skill = one responsibility
- Each skill = independent invocation contract
- Each skill = independent context/async control
- Skills invoke each other via Skill tool, creating explicit boundaries

**Recommended structure:**
- `analysis`: Orchestrate research workflows (calls fact-capture)
- `fact-capture`: Record and format findings (black-box service, no chaining)
- `verify-analysis`: Verify facts independently (can use `context: fork` without affecting other flows)
- `term-capture`: Extract semantic terms independently

**Benefits of modular skills:**
- Each skill's "you" unambiguous within its own scope
- Fact-capture runs inline (no `context: fork` needed)
- Verify-analysis can use `context: fork` independently without breaking fact-capture
- Clear input/output contracts per skill
- Each skill testable in isolation
- Each skill controls its own `background: true/false` or `context: fork` settings independently
- Clearer debugging: failure traces to specific skill, not to opaque flow within skill
- AI-targeted language requirement satisfied naturally (no pronoun conflicts)

**Root cause of observed issues:**
- verify-analysis running "(forked execution)" and returning silently: likely because it has `context: fork` in skill configuration and/or was invoked asynchronously
- fact-capture not receiving verification results: sub-agent spawned in isolation never reported back
- flow ambiguity: multiple flows in one skill with conflicting responsibilities

---

## FINDING-2026-04-04-7
**Captured:** 2026-04-04 09:30
**Source:** [Subagent Frontmatter Fields Complete Specification - Claude Config Knowledge Base](https://code.claude.com/docs/en/sub-agents) (from ai-artifact/batch/authoring-workflow branch, FINDING-2026-03-04-26)
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Explicit Subagent Definitions Provide Comprehensive Control Over Plugin-Based Skills

When bundling related skills in a plugin, defining explicit subagents (`.agent.md` files) provides granular control over invocation behaviour, tool access, execution context, and resource allocation. This is significantly more powerful than relying on implicit subagent spawning via skill `context: fork` settings.

**Comparison: Implicit vs. Explicit Subagents**

**Implicit (skill with `context: fork`):**
```yaml
---
name: verify-analysis
description: Verify research findings
context: fork
agent: general-purpose
---
```
- Uses built-in `general-purpose` agent defaults
- Cannot customize execution mode, tools, permissions, or preloaded skills
- Subject to default subagent behaviour (may run asynchronously)

**Explicit (custom `.agent.md` in plugin):**
```yaml
---
name: verify-analysis-agent
description: Specialized verification subagent
tools: [Read, Grep, Glob, Bash]
disallowedTools: [Write, Edit]
model: sonnet
permissionMode: default
background: false
skills:
  - fact-capture
maxTurns: 20
memory: project
---
```
- **Synchronous execution:** `background: false` ensures blocking invocation
- **Tool restriction:** Specify exact tools available (`tools`) and what's denied (`disallowedTools`)
- **Skill preloading:** Use `skills` field to inject dependent skills at startup
- **Model control:** Specify exact model for capabilities/cost tradeoff
- **Permission handling:** Control permission prompt behaviour
- **Lifecycle limits:** `maxTurns` prevents runaway recursion
- **Persistent memory:** Cross-session knowledge retention
- **Lifecycle hooks:** For PreToolUse, PostToolUse, Stop events
- **Isolation:** `isolation: worktree` for safe testing

**Key benefits of explicit subagents:**

1. **Synchronous guarantees:** `background: false` ensures blocking execution (fixes verify-analysis async problem)
2. **Security:** Restrict tools per subagent (verify-analysis denies Write/Edit)
3. **Dependency injection:** Preload related skills via `skills` field
4. **Cost control:** Assign specific models per subagent
5. **Isolation:** Use `isolation: worktree` for risky operations
6. **Lifecycle control:** `maxTurns` prevents recursion, hooks enable event handling
7. **Persistent knowledge:** `memory` for cross-session learning

**Plugin structure with explicit subagents:**

```
analysis-plugin/
├── agents/
│   ├── fact-capture-recorder.agent.md (background: false, tools: [Read, Write, Edit])
│   ├── verify-facts-specialist.agent.md (background: false, tools: [Read, Bash], skills: [fact-capture])
│   └── term-extractor.agent.md (background: false, tools: [Read, Grep])
└── skills/
    ├── fact-capture/
    │   └── SKILL.md (context: fork, agent: fact-capture-recorder)
    ├── verify-analysis/
    │   └── SKILL.md (context: fork, agent: verify-facts-specialist)
    └── term-capture/
        └── SKILL.md (context: fork, agent: term-extractor)
```

**Critical for fact-capture workflow:**
If verify-analysis is running asynchronously, explicit subagent definition with `background: false` guarantees synchronous blocking execution. Fact-capture would receive results before proceeding, solving the silent-return problem observed in FINDING-2026-04-04-5.

---

## FINDING-2026-04-04-8
**Captured:** 2026-04-04 09:45
**Source:** Architectural analysis and refinement based on FINDING-2026-04-04-6
**Verified:** [NOT YET VERIFIED - requires verification workflow]

### Skill Design Principle: Multiple Flows Within Same Responsibility vs. Separate Responsibilities

A skill CAN contain multiple flows (alternative execution approaches), but only when all flows execute the same responsibility. Different responsibilities must be implemented as separate skills.

**When multiple flows in ONE skill is appropriate:**

Flows represent different approaches or execution paths for the same responsibility:
- `analysis` skill with `procedural-research` and `analytical-research` flows
  - Both conduct research (same responsibility)
  - Different approaches: following a procedure vs. systematic examination
  - Both satisfy research requirement, just different methods
  - Clear single concern: investigation and discovery

- Capture flows within `fact-capture` skill
  - `capture-inline`: Record to main topic facts file
  - `capture-to-subtopic`: Record to subtopic facts file
  - Both satisfy finding-recording responsibility
  - Variations based on file size thresholds, not separate concerns

**Characteristics of valid multi-flow skills:**
- All flows implement variations of ONE responsibility
- Flows are alternative execution paths, not sequential dependencies
- One flow is NOT mandatory for another's completion
- All flows have equal status (none is a "helper" for another)
- Skill has clear, singular concern that encompasses all flows

**When flows should be SEPARATE skills:**

Flows have different responsibilities and cannot be alternatives:
- `fact-capture` (responsibility: record findings) vs `verify-analysis` (responsibility: verify facts)
  - Different concerns: recording ≠ verification
  - Sequential dependency: fact-capture → verify-analysis (one requires output from other)
  - verify-analysis cannot execute independently; it depends on fact-capture output
  - Each has distinct invocation contract and return values

- `analysis` (responsibility: research) vs `fact-capture` (responsibility: record)
  - Analysis needs fact-capture to complete its output process
  - Analysis cannot do what fact-capture does
  - Violation of single responsibility if combined

**Architectural rule:**

If you can say "Flow X is a different way to accomplish [responsibility]", the flows can coexist in one skill.

If you must say "Flow A feeds into Flow B" or "Flow X is a mandatory step for Flow Y", they should be separate skills that invoke each other.

**For the analysis skill issue (FINDING-2026-04-04-6):**

The problem was NOT that analytical-research and procedural-research were in the same skill (that would be fine—they're both research approaches).

The problem WAS that `analysis` skill was creating ambiguity about which "you" applies where due to responsibility mixing (research + fact-capture together), and creating invocation contract confusion (does the skill record findings or invoke something to record them?).

Solution: Keep research flows together within `analysis` skill, but ensure they clearly invoke `fact-capture` as a black-box service, not as an internal flow. This maintains the single-responsibility principle (research coordination) while delegating recording responsibility.

---
