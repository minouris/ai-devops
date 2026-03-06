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

Browse findings by keyword:

- [Keywords A-D](claude-config-index-keywords-a-d.md) - 73 keywords
- [Keywords E-L](claude-config-index-keywords-e-l.md) - 65 keywords
- [Keywords M-P](claude-config-index-keywords-m-p.md) - 64 keywords
- [Keywords Q-S](claude-config-index-keywords-q-s.md) - 63 keywords
- [Keywords T-Z](claude-config-index-keywords-t-z.md) - 34 keywords

**Total:** 299 unique keywords across all findings

---

## Findings

| Finding | Topic | Name | Keywords |
|---------|-------|------|----------|
| [FINDING-2026-03-04-43](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-43) | Commands | Built-in Commands (Not Custom Commands) | built-in, command, custom |
| [FINDING-2026-03-04-39](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-39) | Commands | Commands File Structure (Legacy Format) | command, file, format, legacy, structure |
| [FINDING-2026-03-04-38](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-38) | Commands | Commands Merged into Skills System | command, migration, skill, system, unification |
| [FINDING-2026-03-04-42](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-42) | Commands | Commands Priority and Precedence | command, precedence, priority, skill |
| [FINDING-2026-03-04-40](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-40) | Commands | Commands Support $ARGUMENTS Placeholder | argument, command, placeholder, substitution |
| [FINDING-2026-03-04-41](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-41) | Commands | Commands Support Frontmatter (Same as Skills) | command, configuration, frontmatter |
| [FINDING-2026-03-04-44](claude-config-commands/claude-config-commands-facts.md#finding-2026-03-04-44) | Commands | Migrating Commands to Skills | command, migration, skill |
| [FINDING-2026-03-05-95](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-95) | Compaction | CLAUDE.md and Rules Behavior During Compaction | claudemd, compaction, documentation, rule, uncertainty |
| [FINDING-2026-03-05-96](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-96) | Compaction | Claude Code Specific Compaction Behavior | automatic, claudecode, compaction, control, monitoring |
| [FINDING-2026-03-05-88](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-88) | Compaction | Context Compaction Overview and Purpose | api, compaction, context, overview, server-side |
| [FINDING-2026-03-05-97](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-97) | Compaction | Context Management Strategies Beyond Compaction | context, management, skill, strategy, subagent |
| [FINDING-2026-03-05-91](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-91) | Compaction | Default Summarization Instructions | compaction, default, instruction, pause, summarization |
| [FINDING-2026-03-05-90](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-90) | Compaction | How Compaction Works (Process Flow) | api, block, compaction, process, summarization |
| [FINDING-2026-03-05-98](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-98) | Compaction | Server-Side vs Client-Side Implementation | api, client-side, compaction, implementation, server-side |
| [FINDING-2026-03-05-92](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-92) | Compaction | What Gets Preserved During Compaction | cache, compaction, message, preservation, recent |
| [FINDING-2026-03-05-93](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-93) | Compaction | What Gets Removed During Compaction | compaction, history, loss, removal, tool |
| [FINDING-2026-03-05-94](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-94) | Compaction | What Is Reloaded After Compaction | compaction, documentation, reload, streaming, uncertainty |
| [FINDING-2026-03-05-89](claude-config-compaction/claude-config-compaction-facts.md#finding-2026-03-05-89) | Compaction | When Context Compaction Triggers | api, compaction, detection, threshold, trigger |
| [FINDING-2026-03-06-38](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-38) | Composition - Community | Blended Pattern Composition for Complex Tasks | blend, complex, composition, pattern, prompt |
| [FINDING-2026-03-06-36](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-36) | Composition - Community | Chain-of-Thought Pattern for Reasoning Tasks | chain-of-thought, pattern, prompt, reasoning |
| [FINDING-2026-03-06-26](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-26) | Composition - Community | Clarity Through Hierarchy and Visual Separation | clarity, hierarchy, prompt, separation, visual |
| [FINDING-2026-03-06-39](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-39) | Composition - Community | Completion-Style Prompts for Creative Tasks | completion, creative, generation, prompt, style |
| [FINDING-2026-03-06-41](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-41) | Composition - Community | Context-Rich Prompts for Document Analysis | analysis, context, document, prompt, rich |
| [FINDING-2026-03-06-22](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-22) | Composition - Community | Critical Information at Beginning or End (Lost-in-the-Middle Effect) | accuracy, information, lost-in-middle, placement, prompt |
| [FINDING-2026-03-06-21](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-21) | Composition - Community | General Prompt Structure Component Order | component, order, prompt, structure |
| [FINDING-2026-03-06-25](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-25) | Composition - Community | Iterative Composition Workflow | composition, iterative, prompt, testing, workflow |
| [FINDING-2026-03-06-24](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-24) | Composition - Community | Optimal Prompt Length Range | length, optimal, performance, prompt, token |
| [FINDING-2026-03-06-40](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-40) | Composition - Community | Role-Based Prompts for Voice and Behaviour Alignment | behavior, prompt, role, voice |
| [FINDING-2026-03-06-37](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-37) | Composition - Community | Self-Consistency Pattern for Arithmetic and Common Sense | arithmetic, consistency, pattern, prompt, reasoning |
| [FINDING-2026-03-06-23](claude-config-composition/claude-config-composition-community/claude-config-composition-community-facts.md#finding-2026-03-06-23) | Composition - Community | Static-to-Variable Sequencing for Prompt Caching | cache, dynamic, prompt, sequencing, static |
| [FINDING-2026-03-06-33](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-33) | Composition - Official | Balancing Autonomy and Safety Through Confirmation Prompts | autonomy, confirmation, prompt, risk, safety |
| [FINDING-2026-03-06-6](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-6) | Composition - Official | Clear and Direct Instructions | clarity, explicit, instruction, prompt, specificity |
| [FINDING-2026-03-06-19](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-19) | Composition - Official | Communication Style and Verbosity in Claude 4.x | communication, concise, style, verbosity, version |
| [FINDING-2026-03-06-29](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-29) | Composition - Official | Context Awareness and Multi-Window State Management | compaction, context, management, prompt, state |
| [FINDING-2026-03-06-7](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-7) | Composition - Official | Context Provision for Better Understanding | context, instruction, motivation, prompt, understanding |
| [FINDING-2026-03-06-16](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-16) | Composition - Official | Detailed Prompts for Specific Formatting Preferences | detail, format, markdown, preference, prompt |
| [FINDING-2026-03-06-3](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-3) | Composition - Official | Examples Placement and Structure | example, few-shot, format, prompt, structure |
| [FINDING-2026-03-06-27](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-27) | Composition - Official | Explicit Tool Use Instructions for Action-Taking | action, explicit, instruction, prompt, tool |
| [FINDING-2026-03-06-35](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-35) | Composition - Official | Frontend Design Aesthetic Guidance | aesthetic, design, frontend, guidance, prompt |
| [FINDING-2026-03-06-14](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-14) | Composition - Official | General Instructions Over Prescriptive Steps for Thinking | guidance, instruction, prompt, reasoning, thinking |
| [FINDING-2026-03-06-5](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-5) | Composition - Official | Ground Responses in Quotes for Long Documents | document, grounding, longform, prompt, quote |
| [FINDING-2026-03-06-18](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-18) | Composition - Official | LaTeX Output Default in Claude Opus 4.6 | default, latex, mathematical, output, version |
| [FINDING-2026-03-06-1](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-1) | Composition - Official | Long Context Prompting - Put Longform Data at Top | document, longform, performance, placement, prompt |
| [FINDING-2026-03-06-9](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-9) | Composition - Official | Match Prompt Style to Desired Output Style | format, match, output, prompt, style |
| [FINDING-2026-03-06-34](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-34) | Composition - Official | Minimizing Overengineering in Code Generation | code, minimal, overengineering, prompt, simplicity |
| [FINDING-2026-03-06-20](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-20) | Composition - Official | Model Self-Knowledge and Identity | identity, model, prompt, self-knowledge, system |
| [FINDING-2026-03-06-12](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-12) | Composition - Official | Multishot Examples Work With Thinking | example, few-shot, pattern, reasoning, thinking |
| [FINDING-2026-03-06-8](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-8) | Composition - Official | Output Format Control - Tell What To Do, Not What Not To Do | constraint, format, instruction, output, prompt |
| [FINDING-2026-03-06-28](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-28) | Composition - Official | Parallel Tool Calling Optimization | efficiency, optimization, parallel, prompt, tool |
| [FINDING-2026-03-06-10](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-10) | Composition - Official | Prefilled Responses Deprecated in Claude 4.6+ | deprecated, feature, prefill, prompt, version |
| [FINDING-2026-03-06-31](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-31) | Composition - Official | Research Task Structured Approach | confidence, hypothesis, prompt, research, structure |
| [FINDING-2026-03-06-4](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-4) | Composition - Official | Role Setting in System Prompt | behavior, prompt, role, system, tone |
| [FINDING-2026-03-06-13](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-13) | Composition - Official | Self-Check Instructions for Error Catching | error, prompt, self-check, validation, verification |
| [FINDING-2026-03-06-17](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-17) | Composition - Official | Sequential Instructions for Ordered Tasks | instruction, order, prompt, sequential, task |
| [FINDING-2026-03-06-30](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-30) | Composition - Official | State Management Structure for Long-Horizon Tasks | git, json, progress, state, structure |
| [FINDING-2026-03-06-32](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-32) | Composition - Official | Subagent Usage Guidance | guidance, isolation, prompt, subagent, usage |
| [FINDING-2026-03-06-11](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-11) | Composition - Official | Thinking Prompting for Step-by-Step Reasoning | chain-of-thought, prompt, reasoning, step-by-step, thinking |
| [FINDING-2026-03-06-15](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-15) | Composition - Official | XML Format Indicators for Output Control | format, indicator, output, prompt, xml |
| [FINDING-2026-03-06-2](claude-config-composition/claude-config-composition-official/claude-config-composition-official-facts.md#finding-2026-03-06-2) | Composition - Official | XML Structuring for Prompt Components | component, parsing, prompt, structure, xml |
| [FINDING-2026-03-04-13](claude-config-facts.md#finding-2026-03-04-13) | Configuration | Additional Configuration Methods | configuration, environment, method, permission, settings |
| [FINDING-2026-03-04-9](claude-config-facts.md#finding-2026-03-04-9) | Configuration | Auto Memory - Persistent Context Directory | auto-memory, context, memory, overview, persistent |
| [FINDING-2026-03-04-12](claude-config-facts.md#finding-2026-03-04-12) | Configuration | Claude SDK Configuration Options | api, configuration, option, permission, sdk |
| [FINDING-2026-03-04-7](claude-config-facts.md#finding-2026-03-04-7) | Configuration | CLAUDE.md - Project Instructions File | claudemd, configuration, instruction, overview, project |
| [FINDING-2026-03-04-5](claude-config-facts.md#finding-2026-03-04-5) | Configuration | Commands - User-Invocable Slash Commands | command, invocation, overview, slash, user |
| [FINDING-2026-03-04-3](claude-config-facts.md#finding-2026-03-04-3) | Configuration | Hooks - Event-Driven Automation | automation, event, hook, overview, validation |
| [FINDING-2026-03-04-10](claude-config-facts.md#finding-2026-03-04-10) | Configuration | MCP (Model Context Protocol) - External Tool Integration | external, integration, mcp, overview, protocol, tool |
| [FINDING-2026-03-04-11](claude-config-facts.md#finding-2026-03-04-11) | Configuration | Plugins - Packaged Distribution of Artifacts | artifact, distribution, overview, package, plugin |
| [FINDING-2026-03-04-4](claude-config-facts.md#finding-2026-03-04-4) | Configuration | Rules - Project-Level Instructions (NATIVE) | instruction, native, organization, project, rule |
| [FINDING-2026-03-04-8](claude-config-facts.md#finding-2026-03-04-8) | Configuration | settings.json - Configuration and Permissions | configuration, json, overview, permission, settings |
| [FINDING-2026-03-04-1](claude-config-facts.md#finding-2026-03-04-1) | Configuration | Skills - Primary Extension Mechanism | extension, mechanism, overview, primary, skill |
| [FINDING-2026-03-04-2](claude-config-facts.md#finding-2026-03-04-2) | Configuration | Subagents - Specialized Task Handlers | context, handler, overview, specialized, subagent |
| [FINDING-2026-03-04-14](claude-config-facts.md#finding-2026-03-04-14) | Configuration | This Project's Artifact Structure Conventions (PROJECT-SPECIFIC) | artifact, convention, project, standard, structure |
| [FINDING-2026-03-04-92](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-92) | CLAUDE.md | CLAUDE.md and Context Compaction | claudemd, compaction, persistence, reload, survival |
| [FINDING-2026-03-04-84](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-84) | CLAUDE.md | CLAUDE.md Best Practices | best-practice, claudemd, guideline, size, specificity |
| [FINDING-2026-03-04-87](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-87) | CLAUDE.md | CLAUDE.md Discovery and Loading | claudemd, discovery, hierarchy, loading, tree |
| [FINDING-2026-03-04-83](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-83) | CLAUDE.md | CLAUDE.md File Format and Content | claudemd, content, format, markdown, structure |
| [FINDING-2026-03-04-88](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-88) | CLAUDE.md | CLAUDE.md from Additional Directories | additional, claudemd, directory, environment, loading |
| [FINDING-2026-03-04-85](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-85) | CLAUDE.md | CLAUDE.md Import Syntax | claudemd, file, import, path, security |
| [FINDING-2026-03-04-90](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-90) | CLAUDE.md | CLAUDE.md in Monorepos - Exclusions | claudemd, exclusion, monorepo, policy, setting |
| [FINDING-2026-03-04-89](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-89) | CLAUDE.md | CLAUDE.md Initialization with /init | analysis, claudemd, generation, init, initialization |
| [FINDING-2026-03-04-82](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-82) | CLAUDE.md | CLAUDE.md Locations and Scope | claudemd, hierarchy, location, priority, scope |
| [FINDING-2026-03-04-81](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-81) | CLAUDE.md | CLAUDE.md Overview and Purpose | claudemd, configuration, context, overview, persistent |
| [FINDING-2026-03-04-93](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-93) | CLAUDE.md | CLAUDE.md Troubleshooting | claudemd, debug, issue, solution, troubleshooting |
| [FINDING-2026-03-04-86](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-86) | CLAUDE.md | CLAUDE.md vs Auto Memory | auto-memory, claudemd, comparison, memory, system |
| [FINDING-2026-03-04-91](claude-config-claudemd/claude-config-claudemd-facts.md#finding-2026-03-04-91) | CLAUDE.md | CLAUDE.md vs Rules vs Skills | claudemd, comparison, rule, skill, structure |
| [FINDING-2026-03-04-54](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-54) | Hooks | Agent-Based Hooks | agent, hook, multi-turn, subagent, verification |
| [FINDING-2026-03-04-46](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-46) | Hooks | Hook Configuration Structure | configuration, hierarchy, hook, scope, structure |
| [FINDING-2026-03-04-47](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-47) | Hooks | Hook Events Complete List | block, event, hook, lifecycle, session |
| [FINDING-2026-03-04-49](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-49) | Hooks | Hook Handler Types and Fields | field, handler, hook, http, type |
| [FINDING-2026-03-04-50](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-50) | Hooks | Hook Input and Output (Command Hooks) | command, hook, input, output, stdin |
| [FINDING-2026-03-04-51](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-51) | Hooks | Hook JSON Output and Decision Control | control, decision, hook, json, output |
| [FINDING-2026-03-04-58](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-58) | Hooks | Hook Management and Disabling | disable, hook, management, menu, setting |
| [FINDING-2026-03-04-48](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-48) | Hooks | Hook Matcher Patterns | event, filter, hook, matcher, pattern |
| [FINDING-2026-03-04-59](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-59) | Hooks | Hook Path References and Environment Variables | environment, hook, path, reference, variable |
| [FINDING-2026-03-04-45](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-45) | Hooks | Hooks Overview and Purpose | automation, event, hook, lifecycle, overview |
| [FINDING-2026-03-04-57](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-57) | Hooks | Hooks in Skills and Agents | agent, component, frontmatter, hook, skill |
| [FINDING-2026-03-04-52](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-52) | Hooks | HTTP Hooks Behavior | behavior, hook, http, request, response |
| [FINDING-2026-03-04-55](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-55) | Hooks | PreToolUse Hook - Most Powerful Event | control, hook, injection, modification, pretooluse |
| [FINDING-2026-03-04-53](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-53) | Hooks | Prompt-Based Hooks | evaluation, hook, llm, prompt, single-turn |
| [FINDING-2026-03-04-56](claude-config-hooks/claude-config-hooks-facts.md#finding-2026-03-04-56) | Hooks | SessionStart Hook for Environment Setup | environment, hook, session, sessionstart, setup |
| [FINDING-2026-03-04-76](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-76) | Rules | Excluding Specific Rules (Monorepos) | configuration, exclusion, monorepo, rule, setting |
| [FINDING-2026-03-04-70](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-70) | Rules | Path-Specific Rules (Conditional Loading) | conditional, loading, pattern, rule, scope |
| [FINDING-2026-03-04-79](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-79) | Rules | Rules Best Practices | best-practice, guideline, rule, size, standard |
| [FINDING-2026-03-04-72](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-72) | Rules | Rules Content Structure | content, format, markdown, rule, structure |
| [FINDING-2026-03-05-81](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-05-81) | Rules | Rules Context Compaction Behavior | compaction, context, persistence, rule, uncertainty |
| [FINDING-2026-03-04-69](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-69) | Rules | Rules File Structure and Locations | configuration, file, priority, rule, scope |
| [FINDING-2026-03-04-80](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-80) | Rules | Rules in Additional Directories | directory, environment, loading, rule, variable |
| [FINDING-2026-03-04-78](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-78) | Rules | Rules Loading Behavior | context, loading, rule, scope, timing |
| [FINDING-2026-03-04-73](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-73) | Rules | Rules Organization Patterns | directory, organization, pattern, rule, structure |
| [FINDING-2026-03-04-68](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-68) | Rules | Rules Overview and Introduction | configuration, modular, rule, scope, system |
| [FINDING-2026-03-04-77](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-77) | Rules | Rules vs CLAUDE.md | claudemd, comparison, organization, rule, structure |
| [FINDING-2026-03-04-71](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-71) | Rules | Rules Without Paths (Always Loaded) | loading, priority, rule, session, unconditional |
| [FINDING-2026-03-04-74](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-74) | Rules | Sharing Rules Across Projects with Symlinks | project, rule, sharing, symlink, team |
| [FINDING-2026-03-04-75](claude-config-rules/claude-config-rules-facts.md#finding-2026-03-04-75) | Rules | User-Level Rules (Personal Preferences) | preference, priority, rule, scope, user |
| [FINDING-2026-03-05-87](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-87) | Skills vs Rules | Context Persistence Uncertainty | compaction, context, persistence, rule, skill |
| [FINDING-2026-03-05-84](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-84) | Skills vs Rules | Loading Behavior Comparison | behavior, loading, rule, skill |
| [FINDING-2026-03-05-82](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-82) | Skills vs Rules | Reference Skills Overview for Standards | convention, knowledge, reference, skill, standard |
| [FINDING-2026-03-05-83](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-83) | Skills vs Rules | Rules Overview for Standards | convention, enforcement, rule, scope, standard |
| [FINDING-2026-03-05-85](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-85) | Skills vs Rules | Trade-offs and Risk Analysis | context, efficiency, risk, rule, skill |
| [FINDING-2026-03-05-86](claude-config-skills-vs-rules/claude-config-skills-vs-rules-facts.md#finding-2026-03-05-86) | Skills vs Rules | Use Case Decision Framework | decision, framework, rule, skill, use-case |
| [FINDING-2026-03-04-22](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-22) | Skills | Skills Advanced Features | advanced, feature, skill, subagent, thinking |
| [FINDING-2026-03-04-20](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-20) | Skills | Skills Bundled with Claude Code | built-in, bundled, claudecode, skill |
| [FINDING-2026-03-04-15](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-15) | Skills | Skills Directory Structure and File Organization | directory, file, organization, skill, structure |
| [FINDING-2026-03-04-23](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-23) | Skills | Skills Distribution Methods | distribution, plugin, project, scope, skill |
| [FINDING-2026-03-04-16](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-16) | Skills | Skills Frontmatter Fields Specification | field, frontmatter, skill, specification |
| [FINDING-2026-03-04-18](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-18) | Skills | Skills Invocation Control and Context Loading | context, control, invocation, loading, skill |
| [FINDING-2026-03-05-28](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-28) | Skills | Skills Optional Directories from Agent Skills Specification | agentskills, directory, optional, skill, standard |
| [FINDING-2026-03-04-19](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-19) | Skills | Skills Permission and Access Control | access, control, permission, security, skill |
| [FINDING-2026-03-05-30](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-30) | Skills | Skills Reference Files and Character Budget | budget, character, file, reference, skill |
| [FINDING-2026-03-05-29](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-29) | Skills | Skills Reference Files Frontmatter Requirements | file, frontmatter, reference, requirement, skill |
| [FINDING-2026-03-04-17](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-17) | Skills | Skills String Substitutions and Dynamic Content | dynamic, injection, skill, substitution, variable |
| [FINDING-2026-03-05-27](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-27) | Skills | Skills Subfolder Naming - No Explicit Conventions | convention, naming, skill, subfolder |
| [FINDING-2026-03-05-25](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-25) | Skills | Skills Supporting Files Loading Behavior | behavior, file, loading, progressive, skill |
| [FINDING-2026-03-05-26](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-05-26) | Skills | Skills Supporting File Types and Organization | file, organization, skill, supporting, type |
| [FINDING-2026-03-04-24](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-24) | Skills | Skills Troubleshooting | debug, issue, skill, solution, troubleshooting |
| [FINDING-2026-03-04-21](claude-config-skills/claude-config-skills-facts.md#finding-2026-03-04-21) | Skills | Skills Types and Patterns | pattern, reference, skill, task, type |
| [FINDING-2026-03-04-103](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-103) | Plugins | Plugin Development Workflow | development, plugin, testing, workflow |
| [FINDING-2026-03-04-95](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-95) | Plugins | Plugin Directory Structure | component, directory, manifest, plugin, structure |
| [FINDING-2026-03-04-102](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-102) | Plugins | Plugin Distribution via Marketplaces | distribution, marketplace, plugin, publishing, registry |
| [FINDING-2026-03-04-99](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-99) | Plugins | Plugin Environment and Path Resolution | environment, path, plugin, resolution, variable |
| [FINDING-2026-03-04-104](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-104) | Plugins | Plugin Hooks and Lifecycle Events | event, hook, lifecycle, plugin |
| [FINDING-2026-03-04-97](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-97) | Plugins | Plugin Installation and Management | cli, installation, management, plugin, scope |
| [FINDING-2026-03-04-101](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-101) | Plugins | Plugin LSP Server Configuration | configuration, integration, language, lsp, plugin |
| [FINDING-2026-03-04-96](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-96) | Plugins | Plugin Manifest Schema (plugin.json) | field, manifest, metadata, plugin, schema |
| [FINDING-2026-03-04-100](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-100) | Plugins | Plugin MCP Server Configuration | configuration, integration, mcp, plugin, server |
| [FINDING-2026-03-04-98](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-98) | Plugins | Plugin Namespacing and Resolution | conflict, namespace, plugin, precedence, resolution |
| [FINDING-2026-03-04-106](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-106) | Plugins | Plugin Security and Permissions | permission, plugin, security, trust, validation |
| [FINDING-2026-03-04-105](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-105) | Plugins | Plugin Versioning and Updates | dependency, plugin, semantic, update, version |
| [FINDING-2026-03-04-94](claude-config-plugins/claude-config-plugins-facts.md#finding-2026-03-04-94) | Plugins | Plugins Overview and Purpose | distribution, overview, package, plugin, sharing |
| [FINDING-2026-03-04-27](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-27) | Subagents | Built-in Subagents | built-in, exploration, model, subagent, tool |
| [FINDING-2026-03-04-36](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-36) | Subagents | CLI-Defined Subagents (JSON Format) | cli, configuration, json, subagent, temporary |
| [FINDING-2026-03-04-34](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-34) | Subagents | Subagent Auto-Compaction | auto-compaction, context, subagent, transcript |
| [FINDING-2026-03-04-31](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-31) | Subagents | Subagent Execution Modes | background, execution, foreground, mode, subagent |
| [FINDING-2026-03-04-26](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-26) | Subagents | Subagent Frontmatter Fields Complete Specification | configuration, field, frontmatter, specification, subagent |
| [FINDING-2026-03-04-37](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-37) | Subagents | Subagent Hooks | event, hook, lifecycle, scope, subagent |
| [FINDING-2026-03-04-32](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-32) | Subagents | Subagent Isolation with Git Worktrees | git, isolation, subagent, testing, worktree |
| [FINDING-2026-03-04-35](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-35) | Subagents | Subagent Management with /agents Command | command, interface, management, subagent |
| [FINDING-2026-03-04-28](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-28) | Subagents | Subagent Permission Modes | mode, permission, security, subagent |
| [FINDING-2026-03-04-30](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-30) | Subagents | Subagent Persistent Memory | memory, persistence, scope, storage, subagent |
| [FINDING-2026-03-04-33](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-33) | Subagents | Subagent Resumption and Transcripts | resumption, session, storage, subagent, transcript |
| [FINDING-2026-03-04-29](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-29) | Subagents | Subagent Tool Access Control | control, security, subagent, tool |
| [FINDING-2026-03-04-25](claude-config-subagents/claude-config-subagents-facts.md#finding-2026-03-04-25) | Subagents | Subagents File Structure and Locations | configuration, file, priority, scope, subagent |

---

## Status

**Research phase:** Extended (composition split into official/community sub-subtopics)
**Total findings:** 162 findings (13 core + 149 subtopic)
**Findings with keywords:** 162 (100%)
**Verified findings:** 106 (skills: 16, rules: 13, hooks: 15, subagents: 13, commands: 7, plugins: 13, skills-vs-rules: 5 derived, claudemd: 13, compaction: 11)
**Pending verification:** 41 (composition-official: 29 official findings, composition-community: 12 community findings requiring user review)
**Unverified findings:** 0
**Documentation gaps identified:** 4 (rules reload behavior, skills vs rules context persistence, CLAUDE.md reload behavior, compaction reload behavior - all verified as not documented)
**Disproven findings:** 8 (prompts subtopic)
**Keywords:** 320 unique keywords tracking usage across all findings
**Last updated:** 2026-03-06

---

## Notes

- Official documentation sources: code.claude.com, platform.claude.com
- Codebase examination: /workspaces/ai-devops
- Web search results from 2026 documentation

**Finding number note:** Some finding numbers overlap due to parallel research (e.g., CLAUDE.md findings 81-93 from 2026-03-04, Rules finding 81 from 2026-03-05). Each finding has a unique FINDING-YYYY-MM-DD-N identifier to prevent ambiguity.
