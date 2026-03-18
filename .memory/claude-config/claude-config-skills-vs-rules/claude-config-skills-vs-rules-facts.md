# Claude Config Facts: Skills vs Rules Subtopic

Detailed research findings comparing the use of Reference Skills vs Rules for supplying standards, conventions, and domain knowledge.

**Sources:**
- [claude-config-skills-facts.md](.memory/claude-config-skills-facts.md) (FINDING-18)
- [claude-config-rules-facts.md](.memory/claude-config-rules-facts.md) (FINDING-68, FINDING-71, FINDING-78)
- User discussion on 2026-03-05

---

## FINDING-2026-03-05-82: Reference Skills Overview for Standards

**Source:** [claude-config-skills-facts.md](.memory/claude-config-skills-facts.md) FINDING-18

**Keywords:** convention, knowledge, reference, skill, standard

**Verified:** [NOT YET VERIFIED - derived from other findings, requires verification workflow]

**What:**
Reference Skills (also called "Reference content skills") are skills that supply information on conventions and domain knowledge rather than performing procedural tasks.

**Characteristics:**
- Load on-demand based on skill description matching user's request
- Can be explicitly invoked by user (`/skill-name`) or loaded by Claude when determined relevant
- Do not consume context until loaded
- Subject to progressive disclosure and character budget limits
- May use supporting files for detailed reference content

**Use case:**
Provide standards, conventions, or domain knowledge that Claude can reference when relevant to a task.

**Example applications:**
- Code style standards
- API design patterns
- Security guidelines
- Testing conventions

**Loading trigger:**
- User explicitly invokes the skill
- Claude determines the skill description matches the current task

---

## FINDING-2026-03-05-83: Rules Overview for Standards

**Source:** [claude-config-rules-facts.md](.memory/claude-config-rules-facts.md) FINDING-68, FINDING-71

**Keywords:** convention, enforcement, rule, scope, standard

**Verified:** [NOT YET VERIFIED - derived from other findings, requires verification workflow]

**What:**
Rules are modular project instructions stored in `.claude/rules/` that can be unconditional (always loaded) or path-scoped (load when matching files opened).

**Characteristics:**
- Unconditional rules: loaded at session launch with same priority as CLAUDE.md
- Path-scoped rules: load when Claude reads files matching specified glob patterns
- All rules consume context when loaded
- Plain Markdown files, no character budget concept
- High priority context (authoritative)

**Use case:**
Enforce standards and conventions consistently across a project or specific file types.

**Example applications:**
- General code style (unconditional)
- API endpoint standards (path-scoped to `src/api/**/*.ts`)
- Test conventions (path-scoped to `**/*.test.js`)
- Security requirements (unconditional)

**Loading trigger:**
- Unconditional: at session launch
- Path-scoped: when Claude reads matching files

---

## FINDING-2026-03-05-84: Loading Behavior Comparison

**Source:** User discussion 2026-03-05, derived from FINDING-18 and FINDING-78

**Keywords:** behavior, loading, rule, skill

**Verified:** [NOT YET VERIFIED - derived from other findings, requires verification workflow]

**What:**
Reference Skills and Rules have fundamentally different loading behaviors that affect when standards are available to Claude.

**Comparison table:**

| Aspect | Reference Skills | Rules (Unconditional) | Rules (Path-Scoped) |
|--------|------------------|----------------------|---------------------|
| **Load timing** | On-demand | Session launch | When reading matching files |
| **Load trigger** | Description match or explicit invocation | Always | File read matching glob pattern |
| **Context presence** | Only when loaded | From session start | When working with matching files |
| **Context cost** | Only when relevant | Always | Only when relevant |
| **Discovery mechanism** | Skill description matching | Automatic | Automatic (path-based) |
| **User control** | Can invoke explicitly | No control (always loaded) | No control (automatic when opening files) |

**Key distinction:**
- Skills: Opt-in loading (either by Claude's judgment or user invocation)
- Rules (unconditional): Opt-out not possible (always present)
- Rules (path-scoped): Automatic loading based on file paths (no discovery needed)

---

## FINDING-2026-03-05-85: Trade-offs and Risk Analysis

**Source:** User discussion 2026-03-05

**Keywords:** context, efficiency, risk, rule, skill

**Verified:** [NOT YET VERIFIED - derived from other findings, requires verification workflow]

**What:**
Choosing between Reference Skills and Rules involves trading off between guaranteed enforcement and context efficiency.

**Rules advantages:**
- **Guaranteed availability**: Unconditional rules always present (at least initially)
- **No discovery risk**: Don't depend on Claude recognizing relevance
- **Consistent enforcement**: Claude always has access to the standards
- **Path-scoped precision**: Can target specific file types without description matching

**Rules disadvantages:**
- **Context consumption**: Unconditional rules always occupy context space
- **Compaction risk**: May be pushed out during context compaction (see FINDING-81)
- **No persistence guarantee**: Not documented whether rules reload after compaction
- **Less flexible**: Can't be selectively applied beyond path scoping

**Skills advantages:**
- **Context efficiency**: Only loaded when needed
- **Selective application**: Can be invoked for specific tasks
- **Explicit control**: User can ensure loading via explicit invocation
- **Progressive disclosure**: Can use supporting files for detailed content

**Skills disadvantages:**
- **Discovery dependency**: Claude must recognize skill is relevant
- **Non-guaranteed loading**: May not load if description doesn't match well
- **User burden**: May require explicit invocation to ensure presence
- **Loading delay**: Not present from session start

**Summary trade-off:**
- Rules: "Always there (initially) but consume context and may be compacted"
- Skills: "Context-efficient but might not be discovered when needed"

---

## FINDING-2026-03-05-86: Use Case Decision Framework

**Source:** User discussion 2026-03-05, synthesized from verified findings

**Keywords:** decision, framework, rule, skill, use-case

**Verified:** [NOT YET VERIFIED - derived from other findings, requires verification workflow]

**What:**
Guidelines for choosing between Reference Skills and Rules based on use case requirements.

**Use Rules when:**
- Standards MUST be enforced consistently (security, compliance)
- Standards apply to all work in the project (general code style)
- Standards are specific to file types (path-scoped rules)
- Context cost is acceptable for the value provided
- You want automatic enforcement without user intervention

**Use Reference Skills when:**
- Standards are relevant only for specific tasks (e.g., API design when building APIs)
- Context efficiency is important (large standard documents)
- You want user control over when standards apply
- Standards might evolve frequently (easier to update skills than rules)
- You need progressive disclosure of detailed information

**Use both when:**
- Rules provide core, non-negotiable standards (security, must-haves)
- Skills provide detailed guidance for specific domains (optional deep-dives)
- Example: Rule for "APIs must validate input", Skill for "API design patterns and examples"

**Example scenarios:**

| Scenario | Recommendation | Rationale |
|----------|---------------|-----------|
| Security requirements for all code | Unconditional Rule | Must always be enforced |
| API design patterns and examples | Reference Skill | Only needed when building APIs |
| TypeScript code style standards | Unconditional Rule or path-scoped Rule | Should apply consistently |
| Detailed testing framework documentation | Reference Skill | Detailed, only needed during test work |
| Git commit message format | Unconditional Rule | Should apply to all commits |
| Database migration procedures | Reference Skill | Only needed when writing migrations |

---

## FINDING-2026-03-05-87: Context Persistence Uncertainty

**Source:** User discussion 2026-03-05, relates to FINDING-81

**Keywords:** compaction, context, persistence, rule, skill

**Verified:** [REQUIRES FURTHER EXPLORATION]

**What:**
Both Rules and Skills face uncertainty about context persistence during long conversations.

**Rules context persistence:**
- Unconditional rules described as "always in context" but may be compacted
- No documentation on whether rules reload after compaction
- Creates uncertainty: are standards still enforced after compaction?
- See FINDING-81 for details

**Skills context persistence:**
- Once loaded, skills may also be compacted in long conversations
- No documentation on whether skills reload after compaction
- User may need to re-invoke skill if compacted

**Unknown:**
- Whether either Rules or Skills are preserved during compaction
- Whether either are automatically reloaded after compaction
- Priority of Rules vs Skills during compaction decisions

**Implication for choice:**
Neither mechanism guarantees persistent enforcement in very long conversations. The difference is:
- Rules: Start in context, may be removed
- Skills: May or may not be loaded, may be removed if loaded

**Research needed:**
Empirical testing of both Rules and Skills behavior across long conversations with context compaction.

---

## Notes

**Verification Status:** All 6 findings (FINDING-82 through FINDING-87) NOT YET VERIFIED - require formal verification workflow. These findings are synthesized from verified Skills and Rules findings but have not themselves been verified.

**Sources:**
- Skills findings: [claude-config-skills-facts.md](.memory/claude-config-skills-facts.md)
- Rules findings: [claude-config-rules-facts.md](.memory/claude-config-rules-facts.md)
- User discussion: 2026-03-05

**Key insight:** The choice between Reference Skills and Rules is fundamentally a trade-off between guaranteed initial availability (Rules) and context efficiency (Skills), with both facing uncertainty about persistence through context compaction.
