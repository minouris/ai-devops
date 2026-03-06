# Claude Config Research Index

Research topic: All Claude Code and Claude SDK configuration and customization methods

**Session start:** 2026-03-04

---

## Research Scope

Discover all types of AI artifacts and customization methods for Claude Code and Claude SDK capabilities, including:
- All artifact types (skills, agents, rules, commands, hooks, prompts, etc.)
- Configuration files and methods
- Claude SDK customization options
- Integration points and extension mechanisms

---

## Fact Files

### Primary Fact File
- [claude-config-facts.md](claude-config-facts.md) — Core configuration methods and artifact types

### Subtopic Files
- [claude-config-skills-facts.md](claude-config-skills/claude-config-skills-facts.md) — Skills (findings 15-30) ✅ VERIFIED 2026-03-05
- [claude-config-subagents-facts.md](claude-config-subagents/claude-config-subagents-facts.md) — Subagents (findings 25-37) ✅ VERIFIED 2026-03-05
- [claude-config-commands-facts.md](claude-config-commands/claude-config-commands-facts.md) — Commands (findings 38-44) ✅ VERIFIED 2026-03-05
- [claude-config-hooks-facts.md](claude-config-hooks/claude-config-hooks-facts.md) — Hooks (findings 45-59) ✅ VERIFIED 2026-03-05
- [claude-config-rules-facts.md](claude-config-rules/claude-config-rules-facts.md) — Rules (findings 68-81) ✅ VERIFIED 2026-03-05 (13 verified, 1 requires exploration)
- [claude-config-skills-vs-rules-facts.md](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md) — Skills vs Rules comparison (findings 82-87) ✅ DERIVED 2026-03-05 (5 derived, 1 requires exploration)
- [claude-config-compaction-facts.md](claude-config-compaction/claude-config-compaction-facts.md) — Context compaction (findings 88-98) ✅ VERIFIED 2026-03-06 (8 fully verified, 3 partially verified with external sources)
- [claude-config-claudemd-facts.md](claude-config-claudemd/claude-config-claudemd-facts.md) — CLAUDE.md (findings 81-93) ✅ VERIFIED 2026-03-06 (12 verified, 1 mostly verified)
- [claude-config-plugins-facts.md](claude-config-plugins/claude-config-plugins-facts.md) — Plugins (findings 94-106) ⚠️ VERIFIED 2026-03-05 (5 full, 4 mostly, 4 partial)
- [claude-config-composition-official-facts.md](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md) — Prompt composition - Official docs (findings 1-20, 27-35) 🔄 PENDING VERIFICATION (29 official findings)
- [claude-config-composition-community-facts.md](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md) — Prompt composition - Community sources (findings 21-26, 36-41) 🔄 PENDING VERIFICATION (12 community findings requiring user review)

---

## Companion Files
- [claude-config-prompts-facts-disproven.md](claude-config-prompts-facts-disproven.md) — Prompts subtopic (findings 60-67) - DISPROVEN: Copilot feature, not Claude Code

---

## Keywords

- **argument** (1 finding)
- **behavior** (1 finding)
- **built-in** (1 finding)
- **command** (7 findings)
- **compaction** (1 finding)
- **configuration** (1 finding)
- **context** (2 findings)
- **convention** (2 findings)
- **custom** (1 finding)
- **decision** (1 finding)
- **efficiency** (1 finding)
- **enforcement** (1 finding)
- **file** (1 finding)
- **format** (1 finding)
- **framework** (1 finding)
- **frontmatter** (1 finding)
- **knowledge** (1 finding)
- **legacy** (1 finding)
- **loading** (1 finding)
- **migration** (2 findings)
- **persistence** (1 finding)
- **placeholder** (1 finding)
- **precedence** (1 finding)
- **priority** (1 finding)
- **reference** (1 finding)
- **risk** (1 finding)
- **rule** (6 findings)
- **scope** (1 finding)
- **skill** (8 findings)
- **standard** (2 findings)
- **structure** (1 finding)
- **substitution** (1 finding)
- **system** (1 finding)
- **unification** (1 finding)
- **use-case** (1 finding)

---

## Findings

| Finding | Name | Keywords |
|---------|------|----------|
| [FINDING-2026-03-04-43](#finding-2026-03-04-43) | Built-in Commands (Not Custom Commands) | built-in, command, custom |
| [FINDING-2026-03-04-39](#finding-2026-03-04-39) | Commands File Structure (Legacy Format) | command, file, format, legacy, structure |
| [FINDING-2026-03-04-38](#finding-2026-03-04-38) | Commands Merged into Skills System | command, migration, skill, system, unification |
| [FINDING-2026-03-04-42](#finding-2026-03-04-42) | Commands Priority and Precedence | command, precedence, priority, skill |
| [FINDING-2026-03-04-40](#finding-2026-03-04-40) | Commands Support $ARGUMENTS Placeholder | argument, command, placeholder, substitution |
| [FINDING-2026-03-04-41](#finding-2026-03-04-41) | Commands Support Frontmatter (Same as Skills) | command, configuration, frontmatter |
| [FINDING-2026-03-05-87](#finding-2026-03-05-87) | Context Persistence Uncertainty | compaction, context, persistence, rule, skill |
| [FINDING-2026-03-05-84](#finding-2026-03-05-84) | Loading Behavior Comparison | behavior, loading, rule, skill |
| [FINDING-2026-03-04-44](#finding-2026-03-04-44) | Migrating Commands to Skills | command, migration, skill |
| [FINDING-2026-03-05-82](#finding-2026-03-05-82) | Reference Skills Overview for Standards | convention, knowledge, reference, skill, standard |
| [FINDING-2026-03-05-83](#finding-2026-03-05-83) | Rules Overview for Standards | convention, enforcement, rule, scope, standard |
| [FINDING-2026-03-05-85](#finding-2026-03-05-85) | Trade-offs and Risk Analysis | context, efficiency, risk, rule, skill |
| [FINDING-2026-03-05-86](#finding-2026-03-05-86) | Use Case Decision Framework | decision, framework, rule, skill, use-case |

---

## Status

**Research phase:** Extended (composition split into official/community sub-subtopics)
**Total findings:** 162 findings (14 core + 148 subtopic)
**Verified findings:** 106 (skills: 16, rules: 13, hooks: 15, subagents: 13, commands: 7, plugins: 13, skills-vs-rules: 5 derived, claudemd: 13, compaction: 11)
**Pending verification:** 41 (composition-official: 29 official findings, composition-community: 12 community findings requiring user review)
**Unverified findings:** 0
**Documentation gaps identified:** 4 (rules reload behavior, skills vs rules context persistence, CLAUDE.md reload behavior, compaction reload behavior - all verified as not documented)
**Disproven findings:** 8 (prompts subtopic)
**Last updated:** 2026-03-06

---

## Notes

- Official documentation sources: code.claude.com, platform.claude.com
- Codebase examination: /workspaces/ai-devops
- Web search results from 2026 documentation

**Finding number note:** Some finding numbers overlap due to parallel research (e.g., CLAUDE.md findings 81-93 from 2026-03-04, Rules finding 81 from 2026-03-05). Each finding has a unique FINDING-YYYY-MM-DD-N identifier to prevent ambiguity.
