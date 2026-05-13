# Claude Skill Debugging - Operation Log

## Session 2026-04-04 08:10-08:20

**Operation:** Bootstrap topic, record initial finding, research synchronous invocation patterns, document skill frontmatter

**Files Created:**
- `.memory/claude-skill-debugging/claude-skill-debugging-index.md`
- `.memory/claude-skill-debugging/claude-skill-debugging-facts.md`
- `.memory/claude-skill-debugging/claude-skill-debugging-log.md` (this file)

**Persistent Reference:**
- Entire `claude-config` knowledge base cloned from `ai-artifact/batch/authoring-workflow` to `.tmp/.memory-claude-config/`
- Available for reference throughout session (git worktree at `.tmp/authoring-workflow`)

**Findings Captured:**
- FINDING-2026-04-04-1: Second-Person Pronoun Ambiguity in Chained Flows
- FINDING-2026-04-04-2: Synchronous Subagent Invocation Requires `background: false` Frontmatter
- FINDING-2026-04-04-3: Complete Subagent Frontmatter Field Specification
- FINDING-2026-04-04-4: Skill Frontmatter Fields Controlling Sub-Agent Invocation and Execution
- FINDING-2026-04-04-5: Skills Automatically Spawn Sub-Agents When `context: fork` is Set
- FINDING-2026-04-04-6: Architectural Root Cause—Single Skill with Multiple Chained Flows Causes Governance Ambiguity

**Critical Discovery (FINDING-2026-04-04-5):**
When a skill has `context: fork` in frontmatter, it **automatically spawns a new sub-agent**.
No pre-defined sub-agent configuration required. The skill content becomes the sub-agent's system prompt.

**Architectural Analysis (FINDING-2026-04-04-6):**
Multi-flow skills create unavoidable governance problems:
- Pronoun ambiguity (FINDINGs-2026-04-04-1, requirement from ai-targeted-language.md)
- Context forking affects entire skill, not individual flows
- Asynchronous spawning breaks synchronous invocation contracts
- Responsibility boundaries blur
- Invocation contracts become ambiguous

**Recommendation:** Build modular skills with one responsibility each:
- `analysis`: Orchestrate research (calls other skills)
- `fact-capture`: Record findings only (black-box)
- `verify-analysis`: Verify facts (can use `context: fork`)
- `term-capture`: Extract terms (can use `context: fork`)

Each skill invokes others via Skill tool. This eliminates ambiguity and provides independent context/async control.

**Actions Taken:**
- Comment posted to Issue #37: https://github.com/minouris/ai-devops/issues/37#issuecomment-4186817549
- Comment posted to PR #38: https://github.com/minouris/ai-devops/pull/38#issuecomment-4186817708
- Both comments reference architecture findings and modular skill recommendation

**Research Performed:**
- Located claude-config-skills subtopic with verified findings on skill frontmatter
- Extracted FINDING-2026-03-04-16 (Complete Frontmatter Fields) and FINDING-2026-03-04-18 (Invocation Control)
- Identified critical fields: `context: fork` and `agent: [type]` for sub-agent invocation
- Documented all frontmatter fields with defaults and descriptions

**Key Discoveries:**
- Skills use `context: fork` to run in subagent context (different from how subagents invoke themselves via `background` field)
- `agent` field specifies subagent type (Explore, Plan, general-purpose, or custom)
- Skill content becomes system prompt for the subagent when `context: fork` is set
- Execution mode (sync/async) for skills depends on invocation method, not frontmatter

**Status:** All 4 findings recorded with [NOT YET VERIFIED] status. Awaiting verification via /verify-analysis fact.

**Next Steps:**
1. Verify all findings
2. Investigate verify-analysis skill frontmatter to determine why it ran forked (async) instead of sync
3. Check if verify-analysis has implicit `background: true` or if Skill tool defaults to background execution


