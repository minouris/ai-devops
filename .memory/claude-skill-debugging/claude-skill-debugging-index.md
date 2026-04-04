# Claude Skill Debugging and Flow Analysis

**Topic:** claude-skill-debugging
**Last Updated:** 2026-04-04 08:10

## Knowledge Summary

| Category | Count | Status |
|----------|-------|--------|
| Total Findings | 9 | In Progress |
| Verified | 0 | Pending |
| Not Yet Verified | 9 | Awaiting Verification |
| Disproven | 0 | — |

## Fact Files

- [claude-skill-debugging-facts.md](claude-skill-debugging-facts.md) — Core findings on skill debugging issues
  - Last updated: 2026-04-04 10:00

---

## Findings

| Finding | Topic | Name | Terms |
|---------|-------|------|-------|
| [FINDING-2026-04-04-1](claude-skill-debugging-facts.md#finding-2026-04-04-1) | Flow Design | Second-Person Pronoun Ambiguity in Chained Flows | [Chained Flows](#chained-flows), [AI-Targeted Language](#ai-targeted-language) |
| [FINDING-2026-04-04-2](claude-skill-debugging-facts.md#finding-2026-04-04-2) | Subagent Invocation | Synchronous Subagent Invocation Requires `background: false` Frontmatter | [Synchronous Execution](#synchronous-execution), [Subagent Configuration](#subagent-configuration) |
| [FINDING-2026-04-04-3](claude-skill-debugging-facts.md#finding-2026-04-04-3) | Subagent Invocation | Complete Subagent Frontmatter Field Specification | [Frontmatter Fields](#frontmatter-fields), [Subagent Configuration](#subagent-configuration) |
| [FINDING-2026-04-04-4](claude-skill-debugging-facts.md#finding-2026-04-04-4) | Skill Configuration | Skill Frontmatter Fields Controlling Sub-Agent Invocation and Execution | [Skill Frontmatter](#skill-frontmatter), [Context Forking](#context-forking) |
| [FINDING-2026-04-04-5](claude-skill-debugging-facts.md#finding-2026-04-04-5) | Skill Configuration | Skills Automatically Spawn Sub-Agents When `context: fork` is Set | [Automatic Spawning](#automatic-spawning), [Context Forking](#context-forking) |
| [FINDING-2026-04-04-6](claude-skill-debugging-facts.md#finding-2026-04-04-6) | Architecture | Architectural Root Cause: Single Skill with Multiple Chained Flows Causes Governance Ambiguity | [Architecture](#architecture), [Modular Design](#modular-design), [Skill Governance](#skill-governance) |
| [FINDING-2026-04-04-7](claude-skill-debugging-facts.md#finding-2026-04-04-7) | Plugin Architecture | Explicit Subagent Definitions Provide Comprehensive Control Over Plugin-Based Skills | [Subagent Control](#subagent-control), [Plugin Architecture](#plugin-architecture) |
| [FINDING-2026-04-04-8](claude-skill-debugging-facts.md#finding-2026-04-04-8) | Architecture | Skill Design Principle: Multiple Flows Within Same Responsibility vs. Separate Responsibilities | [Flow Design](#flow-design), [Single Responsibility](#single-responsibility), [Skill Architecture](#skill-architecture) |
| [FINDING-2026-04-04-9](claude-skill-debugging-facts.md#finding-2026-04-04-9) | Architecture | Architectural Principle: Skills Should Be Consigned to Rigidly Defined Subagents with Persona-Driven Capabilities | [Skill Distribution](#skill-distribution), [Persona-Driven Design](#persona-driven-design), [Subagent Architecture](#subagent-architecture) |
