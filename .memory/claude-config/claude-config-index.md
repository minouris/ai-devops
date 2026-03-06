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
- **auto-compaction** (1 finding)
- **background** (1 finding)
- **behavior** (1 finding)
- **best-practice** (1 finding)
- **built-in** (2 findings)
- **claudemd** (1 finding)
- **cli** (1 finding)
- **command** (8 findings)
- **compaction** (2 findings)
- **comparison** (1 finding)
- **conditional** (1 finding)
- **configuration** (7 findings)
- **content** (1 finding)
- **context** (5 findings)
- **control** (1 finding)
- **convention** (2 findings)
- **custom** (1 finding)
- **decision** (1 finding)
- **directory** (2 findings)
- **efficiency** (1 finding)
- **enforcement** (1 finding)
- **environment** (1 finding)
- **event** (1 finding)
- **exclusion** (1 finding)
- **execution** (1 finding)
- **exploration** (1 finding)
- **field** (1 finding)
- **file** (3 findings)
- **foreground** (1 finding)
- **format** (2 findings)
- **framework** (1 finding)
- **frontmatter** (2 findings)
- **git** (1 finding)
- **guideline** (1 finding)
- **hook** (1 finding)
- **interface** (1 finding)
- **isolation** (1 finding)
- **json** (1 finding)
- **knowledge** (1 finding)
- **legacy** (1 finding)
- **lifecycle** (1 finding)
- **loading** (5 findings)
- **management** (1 finding)
- **markdown** (1 finding)
- **memory** (1 finding)
- **migration** (2 findings)
- **mode** (2 findings)
- **model** (1 finding)
- **modular** (1 finding)
- **monorepo** (1 finding)
- **organization** (2 findings)
- **pattern** (2 findings)
- **persistence** (3 findings)
- **permission** (1 finding)
- **placeholder** (1 finding)
- **precedence** (1 finding)
- **preference** (1 finding)
- **priority** (4 findings)
- **project** (1 finding)
- **reference** (1 finding)
- **resumption** (1 finding)
- **risk** (1 finding)
- **rule** (20 findings)
- **scope** (9 findings)
- **security** (2 findings)
- **session** (2 findings)
- **setting** (1 finding)
- **sharing** (1 finding)
- **size** (1 finding)
- **skill** (8 findings)
- **specification** (1 finding)
- **standard** (3 findings)
- **storage** (2 findings)
- **structure** (4 findings)
- **subagent** (13 findings)
- **substitution** (1 finding)
- **symlink** (1 finding)
- **system** (2 findings)
- **team** (1 finding)
- **temporary** (1 finding)
- **testing** (1 finding)
- **timing** (1 finding)
- **tool** (3 findings)
- **transcript** (2 findings)
- **unconditional** (1 finding)
- **uncertainty** (1 finding)
- **unification** (1 finding)
- **use-case** (1 finding)
- **user** (1 finding)
- **variable** (1 finding)
- **worktree** (1 finding)

---

## Findings

| Finding | Topic | Name | Keywords |
|---------|-------|------|----------|
| [FINDING-2026-03-04-43](#finding-2026-03-04-43) | Commands | Built-in Commands (Not Custom Commands) | built-in, command, custom |
| [FINDING-2026-03-04-39](#finding-2026-03-04-39) | Commands | Commands File Structure (Legacy Format) | command, file, format, legacy, structure |
| [FINDING-2026-03-04-38](#finding-2026-03-04-38) | Commands | Commands Merged into Skills System | command, migration, skill, system, unification |
| [FINDING-2026-03-04-42](#finding-2026-03-04-42) | Commands | Commands Priority and Precedence | command, precedence, priority, skill |
| [FINDING-2026-03-04-40](#finding-2026-03-04-40) | Commands | Commands Support $ARGUMENTS Placeholder | argument, command, placeholder, substitution |
| [FINDING-2026-03-04-41](#finding-2026-03-04-41) | Commands | Commands Support Frontmatter (Same as Skills) | command, configuration, frontmatter |
| [FINDING-2026-03-04-44](#finding-2026-03-04-44) | Commands | Migrating Commands to Skills | command, migration, skill |
| [FINDING-2026-03-04-76](#finding-2026-03-04-76) | Rules | Excluding Specific Rules (Monorepos) | configuration, exclusion, monorepo, rule, setting |
| [FINDING-2026-03-04-70](#finding-2026-03-04-70) | Rules | Path-Specific Rules (Conditional Loading) | conditional, loading, pattern, rule, scope |
| [FINDING-2026-03-04-79](#finding-2026-03-04-79) | Rules | Rules Best Practices | best-practice, guideline, rule, size, standard |
| [FINDING-2026-03-04-72](#finding-2026-03-04-72) | Rules | Rules Content Structure | content, format, markdown, rule, structure |
| [FINDING-2026-03-05-81](#finding-2026-03-05-81) | Rules | Rules Context Compaction Behavior | compaction, context, persistence, rule, uncertainty |
| [FINDING-2026-03-04-69](#finding-2026-03-04-69) | Rules | Rules File Structure and Locations | configuration, file, priority, rule, scope |
| [FINDING-2026-03-04-80](#finding-2026-03-04-80) | Rules | Rules in Additional Directories | directory, environment, loading, rule, variable |
| [FINDING-2026-03-04-78](#finding-2026-03-04-78) | Rules | Rules Loading Behavior | context, loading, rule, scope, timing |
| [FINDING-2026-03-04-73](#finding-2026-03-04-73) | Rules | Rules Organization Patterns | directory, organization, pattern, rule, structure |
| [FINDING-2026-03-04-68](#finding-2026-03-04-68) | Rules | Rules Overview and Introduction | configuration, modular, rule, scope, system |
| [FINDING-2026-03-04-77](#finding-2026-03-04-77) | Rules | Rules vs CLAUDE.md | claudemd, comparison, organization, rule, structure |
| [FINDING-2026-03-04-71](#finding-2026-03-04-71) | Rules | Rules Without Paths (Always Loaded) | loading, priority, rule, session, unconditional |
| [FINDING-2026-03-04-74](#finding-2026-03-04-74) | Rules | Sharing Rules Across Projects with Symlinks | project, rule, sharing, symlink, team |
| [FINDING-2026-03-04-75](#finding-2026-03-04-75) | Rules | User-Level Rules (Personal Preferences) | preference, priority, rule, scope, user |
| [FINDING-2026-03-05-87](#finding-2026-03-05-87) | Skills vs Rules | Context Persistence Uncertainty | compaction, context, persistence, rule, skill |
| [FINDING-2026-03-05-84](#finding-2026-03-05-84) | Skills vs Rules | Loading Behavior Comparison | behavior, loading, rule, skill |
| [FINDING-2026-03-05-82](#finding-2026-03-05-82) | Skills vs Rules | Reference Skills Overview for Standards | convention, knowledge, reference, skill, standard |
| [FINDING-2026-03-05-83](#finding-2026-03-05-83) | Skills vs Rules | Rules Overview for Standards | convention, enforcement, rule, scope, standard |
| [FINDING-2026-03-05-85](#finding-2026-03-05-85) | Skills vs Rules | Trade-offs and Risk Analysis | context, efficiency, risk, rule, skill |
| [FINDING-2026-03-05-86](#finding-2026-03-05-86) | Skills vs Rules | Use Case Decision Framework | decision, framework, rule, skill, use-case |
| [FINDING-2026-03-04-27](#finding-2026-03-04-27) | Subagents | Built-in Subagents | built-in, exploration, model, subagent, tool |
| [FINDING-2026-03-04-36](#finding-2026-03-04-36) | Subagents | CLI-Defined Subagents (JSON Format) | cli, configuration, json, subagent, temporary |
| [FINDING-2026-03-04-34](#finding-2026-03-04-34) | Subagents | Subagent Auto-Compaction | auto-compaction, context, subagent, transcript |
| [FINDING-2026-03-04-31](#finding-2026-03-04-31) | Subagents | Subagent Execution Modes | background, execution, foreground, mode, subagent |
| [FINDING-2026-03-04-26](#finding-2026-03-04-26) | Subagents | Subagent Frontmatter Fields Complete Specification | configuration, field, frontmatter, specification, subagent |
| [FINDING-2026-03-04-37](#finding-2026-03-04-37) | Subagents | Subagent Hooks | event, hook, lifecycle, scope, subagent |
| [FINDING-2026-03-04-32](#finding-2026-03-04-32) | Subagents | Subagent Isolation with Git Worktrees | git, isolation, subagent, testing, worktree |
| [FINDING-2026-03-04-35](#finding-2026-03-04-35) | Subagents | Subagent Management with /agents Command | command, interface, management, subagent |
| [FINDING-2026-03-04-28](#finding-2026-03-04-28) | Subagents | Subagent Permission Modes | mode, permission, security, subagent |
| [FINDING-2026-03-04-30](#finding-2026-03-04-30) | Subagents | Subagent Persistent Memory | memory, persistence, scope, storage, subagent |
| [FINDING-2026-03-04-33](#finding-2026-03-04-33) | Subagents | Subagent Resumption and Transcripts | resumption, session, storage, subagent, transcript |
| [FINDING-2026-03-04-29](#finding-2026-03-04-29) | Subagents | Subagent Tool Access Control | control, security, subagent, tool |
| [FINDING-2026-03-04-25](#finding-2026-03-04-25) | Subagents | Subagents File Structure and Locations | configuration, file, priority, scope, subagent |

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
