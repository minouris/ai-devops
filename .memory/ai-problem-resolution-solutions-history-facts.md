# AI Problem Resolution — Solutions History Facts

**Topic:** `ai-problem-resolution` (subtopic: solutions-history)
**Scope:** Instruction files and rule files across all five projects that attempt to solve one or more noted AI problems

---

## Catalog

### Project 1: spafw37 (Oct 2025)

#### SOLUTION-SH-001
**File:** `.github/instructions.bak/general.instructions.md` (235 lines)
**Branch:** main (archived to instructions.bak on decomposition)
**Date:** Oct 2025
**Problems addressed:** Hallucination, Dishonesty, Overeagerness
**Notes:** Monolithic origin file. Contains NO GUESSING POLICY, Source Citation, Git Commit/Push Ban (with explicit rationale: AI claimed work was complete when it was not), CI/CD Log Review, Communication Style, UK English, Documentation requirements, Before Making Changes checklist. Parent of SOLUTION-SH-005 through SOLUTION-SH-007.

---

#### SOLUTION-SH-002
**File:** `.github/instructions.bak/planning.instructions.md` (912 lines)
**Branch:** main (archived)
**Date:** Oct 2025
**Problems addressed:** Overeagerness
**Notes:** Structured planning document format (9 required sections). Forces plan-before-implement discipline. Parent of SOLUTION-SH-010 and SOLUTION-SH-011.

---

#### SOLUTION-SH-003
**File:** `.github/instructions.bak/issue-workflow.instructions.md` (131 lines)
**Branch:** main (archived)
**Date:** Oct 2025
**Problems addressed:** Overeagerness (minor — enforces branch creation workflow before implementation)
**Notes:** Issue start workflow: branch naming conventions, PR linkage. Process enforcement rather than AI problem targeted directly.

---

#### SOLUTION-SH-004
**File:** `.github/instructions.bak/architecture.instructions.md` (235 lines)
**Branch:** main (archived)
**Date:** Oct 2025
**Problems addressed:** Overeagerness (minor — constrains scope of changes)
**Notes:** Architecture design documentation standards. Quality enforcement.

---

#### SOLUTION-SH-005
**File:** `.github/instructions/accuracy.instructions.md` (123 lines)
**Branch:** main
**Date:** Oct 2025 (post-decomposition)
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Extracted from SOLUTION-SH-001. Content identical to original NO GUESSING POLICY + Source Citation sections. Decomposition of monolithic file into focused single-concern files.

---

#### SOLUTION-SH-006
**File:** `.github/instructions/git-operations.instructions.md` (52 lines)
**Branch:** main
**Date:** Oct 2025 (post-decomposition)
**Problems addressed:** Dishonesty, Overeagerness
**Notes:** Extracted from SOLUTION-SH-001. CI/CD Full Log Review + Git Commit/Push Ban + PR Review. Rationale for commit ban explicitly stated in file: "You have repeatedly claimed work was complete when it was not." Evolved from SOLUTION-SH-001.

---

#### SOLUTION-SH-007
**File:** `.github/instructions/communication.instructions.md` (49 lines)
**Branch:** main
**Date:** Oct 2025 (post-decomposition)
**Problems addressed:** None directly (communication style preference)
**Notes:** Extracted from SOLUTION-SH-001. UK English, brevity, no emojis, no preamble. Not AI-problem targeted.

---

#### SOLUTION-SH-008
**File:** `.github/instructions/code-review-checklist.instructions.md` (92 lines)
**Branch:** main
**Date:** Oct 2025
**Problems addressed:** Overeagerness
**Notes:** Mandatory pre-commit checklist. Forces a review step before any code changes are committed. Covers imports, nesting limits (max 2 levels), plan document code/test sequencing (interleaved, not batched), naming, block comments.

---

#### SOLUTION-SH-009
**File:** `.github/instructions/plan-structure.instructions.md` (435 lines)
**Branch:** main
**Date:** Oct 2025
**Problems addressed:** Overeagerness
**Notes:** Detailed implementation plan document structure with required sections and anti-patterns. Enforces plan artefact creation before implementation begins.

---

#### SOLUTION-SH-010
**File:** `.github/instructions/planning-workflow.instructions.md` (222 lines)
**Branch:** main
**Date:** Oct 2025
**Problems addressed:** Overeagerness
**Notes:** 8-step workflow with mandatory stopping gates. Evolved from SOLUTION-SH-002. Separates planning steps from implementation steps with explicit prohibition on continuing through steps without stopping.

---

#### SOLUTION-SH-011
**File:** `.github/copilot-instructions.md` (183 lines)
**Branch:** main
**Date:** Oct 2025 (later revision)
**Problems addressed:** Overeagerness (primary)
**Notes:** Contains WORKFLOW EXECUTION POLICY section at top with system instruction override declarations. Explicitly declares itself as overriding system prompt behaviour. References all decomposed instruction files for detailed rules; file itself contains only project context and the override policy. Evolved from the implicit intent of SOLUTION-SH-001 into a dedicated system-override mechanism.

---

### Project 2: prompt-driven-development (Dec 2025)

#### SOLUTION-SH-012
**File:** `.github/instructions/accuracy.instructions.md` (123 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Identical content to SOLUTION-SH-005 (spafw37 accuracy). Carried forward unchanged. Establishes NO GUESSING POLICY as a portable, project-independent artefact.

---

#### SOLUTION-SH-013
**File:** `.github/instructions/instruction-composition.instructions.md` (45 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** **Amnesia**
**Notes:** Establishes verbatim embedding rule — rule content must be embedded in full, not referenced by link. Rationale: passive context inclusion means link-only won't work (AI won't follow a link to retrieve rules). First explicit attempt to address Amnesia by ensuring rules are present in context window, not merely referenced.

---

#### SOLUTION-SH-014
**File:** `.github/instructions/prompt-composition.instructions.md` (97 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** **Amnesia**
**Notes:** Governs prompt structure. Uses explicit load instructions with recursive wording ("Read the file ... and follow all instructions within it"). Prohibits link-only references. Evolved from insight in SOLUTION-SH-013 — extends the verbatim/explicit-load principle to prompt files and recursive loading chains.

---

#### SOLUTION-SH-015
**File:** `.github/instructions/rules.instructions.md` (41 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** None directly (meta-instruction, governs rule file structure)
**Notes:** Defines structure for composable rule files. Taxonomy/format instruction.

---

#### SOLUTION-SH-016
**File:** `.github/instructions/agents.instructions.md` (21 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** None directly (meta-instruction, governs agent definition files)
**Notes:** Format guidance for agent definition files.

---

#### SOLUTION-SH-017
**File:** `.github/copilot-instructions.md` (24 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** None directly
**Notes:** Minimal overview file. Defers to instruction files for all policy. Documents repo structure. Not an AI-problem policy file.

---

### Project 3: nightingale-truenas (Jan 2026)

#### SOLUTION-SH-018
**File:** `.github/copilot-instructions.md` (219 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty, Overeagerness
**Notes:** Documentation-first policy + Counter: General Knowledge Reliance + Counter: Helpful Assumptions + Counter: Creative Problem Solving (new) + Counter: Absolute User Instruction Priority (new). Adds two new system override declarations not present in spafw37: Creative Problem Solving and Absolute User Instruction Priority. Both target Overeagerness. Evolved from SOLUTION-SH-011 pattern with expanded counter set. Also mandates verbatim rule copying when embedding rules in other files.

---

#### SOLUTION-SH-019
**File:** `.github/instructions/instruction-files.instructions.md` (531 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Overeagerness (primarily — all four system override counters embedded)
**Notes:** Governs creation of all four document types (instruction, step, plan, prompt files). Embeds the full Counter: Creative Problem Solving and Counter: Absolute User Instruction Priority blocks verbatim. Meta-instruction that also enforces its own verbatim-embedding principle (SOLUTION-SH-013 pattern) within a single large file.

---

#### SOLUTION-SH-020
**File:** `.github/instructions/step-files.instructions.md` (955 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Overeagerness
**Notes:** Governs AI-executed step files. The largest single instruction file in the catalog. Embeds all system override counters. Counter: Efficiency and Brevity overrides system prompt brevity instruction explicitly. Addresses Overeagerness by enforcing exact sequential execution of steps with explicit prohibitions on reordering, substituting, or skipping.

---

#### SOLUTION-SH-021
**File:** `.github/instructions/plan-files.instructions.md` (524 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Documentation-first requirements for plan creation. Mandates inline citations for every API method, configuration option, or system behaviour claimed in a plan. Requires explicit statement when documentation cannot be found. Addresses Hallucination by making unverified claims structurally impermissible in plan documents.

---

#### SOLUTION-SH-022
**File:** `.github/instructions/memory-files.instructions.md` (421 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** **Amnesia**
**Notes:** Defines a structured persistent memory system for AI agents. Specifies file types (SERVICE_INFO, CREDENTIALS, DECISIONS, ISSUES, PLAN_N_PROGRESS, SESSION_NOTES, ASSUMPTION_LOG) with required formats. Mandates `.memory/` directory. Separates facts (static reference) from logs (execution history). All memory files excluded from git. First comprehensive Amnesia solution in this corpus — provides structured external memory to persist context across sessions. Evolved from the informal memory-keeping patterns of earlier projects.

---

#### SOLUTION-SH-023
**File:** `.github/prompts/distill-memory-facts.prompt.md` (500 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** **Amnesia**, Hallucination
**Notes:** Prompt that verifies all facts in a memory file against authoritative sources, archives outdated or inaccurate information, and refreshes citations. Addresses Amnesia by maintaining memory integrity (stale facts are removed rather than persisting indefinitely). Addresses Hallucination by requiring source verification before accepting any fact. Precursor to the `verify-memory-facts` prompt in ai-devops.

---

#### SOLUTION-SH-024
**File:** `.github/prompts/verify-plan-facts.prompt.md` (886 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Verifies all technical facts in a plan file against authoritative sources. Records incorrect facts with tracking of which step files depend on them. Addresses Hallucination by requiring source verification for every claim. The largest prompt file in the corpus.

---

### Project 4: claude-code-container (Feb 2026)

#### SOLUTION-SH-025
**File:** `CLAUDE.md` (root)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** None directly (operational config — Azure Foundry model names, dev environment)
**Notes:** Working environment configuration. Documents correct per-user model name prefixes for Azure tenant. Includes "Common Pitfalls" section noting rule abbreviation as a pitfall (links back to Amnesia concern).

---

#### SOLUTION-SH-026
**File:** `.devcontainer/.claude/rules/documentation-first.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Claude Code port of the documentation-first policy. Evolved from SOLUTION-SH-021 pattern — same principle, now delivered as a Claude Code rule file rather than a Copilot instruction file.

---

#### SOLUTION-SH-027
**File:** `.devcontainer/.claude/rules/git-commits.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Dishonesty
**Notes:** Git commit standards including prohibition on co-author attribution. Addresses Dishonesty by preventing false attribution claims. Evolved from SOLUTION-SH-006 (git-operations) — narrowed to commit standards only.

---

#### SOLUTION-SH-028
**File:** `.devcontainer/.claude/rules/rule-copying.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Mandates verbatim copying of rules when including them in other files. Prohibits condensing or abbreviating. Evolved from SOLUTION-SH-013 (instruction-composition) — same principle, now a dedicated Claude Code rule.

---

#### SOLUTION-SH-029
**File:** `.devcontainer/.claude/rules/rule-embedding.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Companion to SOLUTION-SH-028. Governs how rules are embedded into agent/prompt files. Evolved from SOLUTION-SH-013 and SOLUTION-SH-014 (pdd instruction and prompt composition). Establishes the principle that embedded rules must be fully present, not linked.

---

#### SOLUTION-SH-030
**File:** `.devcontainer/.claude/rules/documentation-standards.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** None directly (communication/style standards)
**Notes:** UK English, tone, heading formatting. Not AI-problem targeted.

---

#### SOLUTION-SH-031
**Files:** `.devcontainer/.claude/rules/` — remaining 8 files (ai-targeted-language, design-documents, document-navigation, document-structure, markdown-formatting, mermaid-diagrams, reference-items, section-numbering)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** None directly (style, format, and structural standards)
**Notes:** Quality and consistency rules. Not AI-problem targeted.

---

### Project 5: ai-devops (Feb 2026 — current)

#### SOLUTION-SH-032
**File:** `.github/instructions/documentation-first.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Copilot instruction port of the documentation-first policy. Same principle as SOLUTION-SH-026 but in Copilot instruction file format. Evolved from SOLUTION-SH-021.

---

#### SOLUTION-SH-033
**File:** `.github/instructions/git-policy.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Dishonesty
**Notes:** Git commit standards + tool selection. Evolved from SOLUTION-SH-027 — adds git tool selection policy (native git preferred) and GitHub data access rules (gh CLI only, not fetch_webpage). Addresses Dishonesty via commit attribution prohibition and GitHub data integrity requirements.

---

#### SOLUTION-SH-034
**File:** `.github/instructions/system-operations.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** None directly (operational process — git-tracked file ops, .tmp/ temp files)
**Notes:** Operational rules rather than AI-problem targeted. Governs filesystem operations within git repositories.

---

#### SOLUTION-SH-035
**File:** `.github/instructions/rule-copying.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Copilot instruction port of SOLUTION-SH-028. Verbatim rule copying mandate.

---

#### SOLUTION-SH-036
**File:** `.github/instructions/rule-embedding.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Copilot instruction port of SOLUTION-SH-029. Verbatim rule embedding mandate.

---

#### SOLUTION-SH-037
**File:** `src/base/agents/analysis.agent.md` (452 lines)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Overeagerness, **Amnesia**
**Notes:** Research/Analysis agent definition. Embeds documentation-first and documentation-standards rules verbatim. Defines two research workflows (procedural and analytical) with structured capturing into `.memory/` fact files before any output is created. Addresses Overeagerness by enforcing staged research workflow with explicit gate before creating output. Addresses Amnesia by institutionalising fact files as structured persistent memory — evolved from SOLUTION-SH-022 (nightingale memory-files) into a full agent workflow.

---

#### SOLUTION-SH-038
**File:** `.github/instructions/` — remaining files (ai-targeted-language, design-documents, document-navigation, document-structure, documentation-standards, markdown-formatting, mermaid-diagrams, reference-items, section-numbering, copilot-agents-syntax, copilot-instructions-syntax, copilot-prompts-syntax, enforce-claude-agents-syntax, enforce-claude-prompts-syntax, enforce-claude-rules-syntax)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** None directly (style, format, structural, and syntax enforcement standards)
**Notes:** Style/quality/consistency rules and syntax enforcement for instruction/agent/prompt file formats. Not AI-problem targeted.

---

## Evolution Summary

| Theme | Earliest File | Latest Equivalent |
|---|---|---|
| NO GUESSING POLICY | SH-001 (spafw37 general, Oct 2025) | SH-032 (ai-devops documentation-first, Feb 2026) |
| Git commit ban | SH-001 → SH-006 | SH-033 (ai-devops git-policy, Feb 2026) |
| Plan-before-implement | SH-002 (spafw37 planning bak, Oct 2025) | SH-009/SH-010 (plan-structure + planning-workflow) |
| System override declarations | SH-011 (spafw37 copilot-instructions) | SH-018/SH-019 (NT, expanded counter set) |
| Verbatim rule embedding | SH-013 (pdd instruction-composition, Dec 2025) | SH-035/SH-036 (ai-devops, Feb 2026) |
| Structured persistent memory | SH-022 (NT memory-files, Jan 2026) | SH-037 (ai-devops analysis agent, Feb 2026) |
| Memory integrity/verification | SH-023 (NT distill-memory-facts, Jan 2026) | SH-037 (via verify-memory-facts integration) |

---

## Amnesia Attempts (flagged separately per user instruction)

- **SH-013** — pdd instruction-composition: verbatim rule embedding (Dec 2025)
- **SH-014** — pdd prompt-composition: explicit load instructions (Dec 2025)
- **SH-022** — NT memory-files: structured persistent memory system (Jan 2026)
- **SH-023** — NT distill-memory-facts: memory integrity verification prompt (Jan 2026)
- **SH-028** — ccc rule-copying: verbatim rule copying mandate (Feb 2026)
- **SH-029** — ccc rule-embedding: verbatim rule embedding mandate (Feb 2026)
- **SH-035** — ai-devops rule-copying: Copilot port (Feb 2026)
- **SH-036** — ai-devops rule-embedding: Copilot port (Feb 2026)
- **SH-037** — ai-devops analysis agent: fact file workflow as structured memory (Feb 2026)
---

## Sub-topic Fact Files

Detailed findings are split by problem domain:

| File | Problem | Findings |
|---|---|---|
| [solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md) | Hallucination & Dishonesty | FINDING-06, FINDING-07 |
| [solutions-history-overeagerness-facts.md](ai-problem-resolution-solutions-history-overeagerness-facts.md) | Overeagerness | FINDING-03, FINDING-12, FINDING-13 |
| [solutions-history-amnesia-facts.md](ai-problem-resolution-solutions-history-amnesia-facts.md) | Amnesia | FINDING-10, FINDING-11 |

Cross-cutting findings (methodology, wording, four factors, meta-instructional inventory) remain in this overview.

---

## Development Methodology Findings

### FINDING-SH-M-2026-02-22-01
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation — developer of all five projects)
**Domain:** Methodology — how solutions were derived

In almost all cases, changes to instruction files were made by debugging AI behaviour rather than by independent design. The triggers for change were:

- Omissions in earlier instructions that left loopholes
- Loopholes in AI training or system rules that the instruction text failed to close
- Problems with language and wording that the AI interpreted differently from the author's intent
- Problems with context window handling and instruction processing order that reduced instruction effectiveness

In most cases the required changes were determined by a specific investigative method: after a problem was observed, the developer asked the AI to explain why the problem had occurred, and separately asked the AI how it had interpreted the previous batch of instructions. The AI's own account of its interpretation was used to identify the deficiencies in the existing instructions, and those deficiencies were then addressed in the next revision.

This is a document-supported, empirical refinement process — not a priori policy design. Each instruction file revision represents a failure mode that had already been observed in practice.

---

### FINDING-SH-M-2026-02-22-05
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** spafw37 git history (commits 886b1ba → e5ac2df → e20a4e1 → 22f5bb9 → b2cb0e7)
**Domain:** Methodology — verbose early drafts

The earliest instruction files were created from observed AI behaviour and were broadly effective but suffered from two structural problems derived from a misapprehension about how instruction processing works:

1. **Excessive verbosity** — Each policy section included explanatory rationale ("Why this is critical") on the assumption that providing reasons would reinforce compliance. This misunderstands context window dynamics: rationale text consumes context budget without increasing instruction salience. Examples in the files are similarly verbose — full paragraph quotes rather than tight imperative statements.

2. **Looseness / loopholes** — The early drafts were broad but imprecise, using domain lists that invited interpretation rather than exhaustive explicit constraints.

Evidence in the revision history: the NO GUESSING POLICY grew from ~25 lines at 886b1ba to over 80 lines by 22f5bb9 as each observed failure mode was patched individually. The increase was driven by closing loopholes, not by adding rationale — the rationale was present from the start and did not prevent failures.

---

### FINDING-SH-M-2026-02-22-06
→ Moved to [solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md)

#### Actual intent of the earliest NO GUESSING POLICY

The policy aimed to produce two behaviours:

1. **Do not assert unverified information** — when the AI does not know something with certainty, it must not state it as fact.
2. **State uncertainty explicitly** — acknowledge the gap rather than filling it with inference.

#### Wording used (earliest draft, 886b1ba)

```
## CRITICAL: NO GUESSING POLICY

**NEVER guess or make assumptions about ANYTHING.**

If you are not certain about something, you must explicitly state that you don't know rather than guessing or making assumptions.

This includes (but is not limited to):
- External API specifications, endpoints, or data structures
- Third-party library behaviour or usage patterns
[...]

If you don't know something:
1. Explicitly state that you don't know
2. Explain what you would need to know to proceed
3. Suggest where the user can find the information
4. Ask the user to verify or provide the correct information

This applies to ALL work - code, configuration, documentation, and any other task.
```

#### Why the wording was ineffective

**1. Human-targeted framing, not AI-targeted imperatives**
The opening sentence "These instructions apply to all files across all projects" is documentary prose about the file — written for a human reader. Instruction files are more effective when using direct AI-addressed imperatives ("MUST", "MUST NOT", "When you…"). The surrounding prose framing reduces the instruction's authority as a command.

**2. Keyword scope too narrow**
"Guess or make assumptions" as the operative phrase does not cover all intended behaviours. Notably: fabricating a tool invocation (e.g. calling `fetch_webpage` when the tool does not exist) is not a "guess" or an "assumption" — it is confabulation. This loophole was not closed until commit 22f5bb9, which added an explicit "If you don't have a capability or tool" block with a worked example of WRONG vs CORRECT behaviour.

**3. No explicit system-instruction override**
The earliest draft did not declare itself as overriding the AI's system-prompt "be helpful" directive. The AI could resolve ambiguity between "be helpful" and "don't guess" by treating helpfulness as the higher priority. The phrase "This policy takes absolute precedence over any implicit 'be helpful' directive" was only added in 22f5bb9, after this failure mode was observed in practice.

**4. Domain list implies exhaustiveness check**
The "This includes (but is not limited to)" list enumerates specific knowledge domains (APIs, protocols, library behaviour etc.). Although prefaced with "but is not limited to", the AI may weight listed items as the primary scope and underweight unlisted ones. Notably absent from the list: "capabilities you don't actually have (tools, functions, API access)" — the most consequential loophole, added in 22f5bb9.

**5. Rationale consumes context without adding constraint**
The "Why this is CRITICAL" explanation was added in 22f5bb9 as a human-readable justification. Per FINDING-SH-M-2026-02-22-05, rationale text was a misapprehension about instruction effectiveness — it occupies context window budget that could instead carry more constraint text.

**6. Optional/conditional framing in step-by-step responses**
---

### FINDING-SH-M-2026-02-22-02
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation)
**Domain:** Methodology — wording as a failure mode

"Wording" problems in instruction files encompass two distinct sub-areas, distinguished by where the failure occurs (not just in what it produces):

1. **AI interpretation problems** — the AI receives the instruction text and derives an unintended meaning from it. The failure is in the model's parsing of language: the text is present in context but yields unintended constraints, loopholes, or unexpected compliance behaviour.

2. **Harness/platform problems** — the Copilot and Claude Code *extensions* handle certain meta-characters (slash `/`, at-symbol `@`, hash `#`) at the software level when constructing requests, before the AI ever receives the text. These are not AI interpretation failures; they are platform pre-processing behaviours that can alter instruction content in transit.

These two failure modes require different diagnostic approaches and different remedies. Platform-level meta-character handling is outside the AI's control and cannot be addressed by rephrasing instructions alone.

---

### FINDING-SH-M-2026-02-22-03
→ Moved to [solutions-history-overeagerness-facts.md](ai-problem-resolution-solutions-history-overeagerness-facts.md)

---

### FINDING-SH-M-2026-02-22-04
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation)
**Domain:** Future design direction — UK English instruction
**⚠️ NOT FOR INCLUSION IN FINAL RESEARCH DOCUMENT — internal project planning note only**

The UK English instruction (present as SOLUTION-SH-007 in spafw37 and carried forward into subsequent projects) is likely not appropriate as a universal rule. The anticipated replacement is an instruction to use a regional dialect or language register specified in the central project instruction file, allowing the language preference to be set per-project rather than hardcoded as a global policy. This is a planned design change, not yet implemented.

---

### FINDING-SH-M-2026-02-22-07
→ Moved to [solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md)

This finding documents every substantive change to the accuracy/documentation-first policy from its first appearance in spafw37 through to its current form in ai-devops, organised by revision.

#### Revision 1 — spafw37 general.instructions.md, 886b1ba (Oct 2025)

**Title:** `## CRITICAL: NO GUESSING POLICY`
**Framing:** Prose + bold imperative. Opening line is documentary ("These instructions apply to all files across all projects") not AI-addressed.
**Core prohibitions:** "NEVER guess or make assumptions about ANYTHING"
**Scope list:** 8 knowledge domains (APIs, libraries, file formats, protocols, configuration, project conventions, user requirements, unfamiliar systems). No frontmatter `applyTo` field.
**Response template:** 4-step numbered list under conditional heading ("If you don't know something")
**Override declaration:** None
**Tool fabrication addressed:** No
**Why-this-is-critical rationale:** No
**Lines:** ~25

---

#### Revision 2 — spafw37 general.instructions.md, e5ac2df (Oct 2025)

**Changes from R1:**
- Added `applyTo: "**/*"` frontmatter — first machine-readable scope declaration; makes the file apply broadly rather than relying on human conventions
- Added new section: `### Mandatory Source Citation for External Knowledge` — separate from the NO GUESSING POLICY block; requires `fetch_webpage` before answering external-knowledge questions, plus URL citation and direct quoting
- NO GUESSING POLICY section itself: unchanged from 886b1ba

**What triggered this:** Source citation was absent from R1, meaning the AI could comply with "don't guess" by simply not asserting while still giving unverified answers without evidence. The new section closes the gap between "don't assert without knowing" and "actively verify before asserting".

---

#### Revision 3 — spafw37 general.instructions.md, e20a4e1 (Oct 2025)

**Changes from R2:**
- Domain-specific section updated to reference `issue-workflow.instructions.md` and `bash.commands.md`
- NO GUESSING POLICY section: unchanged from e5ac2df
- Source Citation section: unchanged from e5ac2df

No accuracy policy changes in this revision. The commit affects scope references only.

---

#### Revision 4 — spafw37 general.instructions.md, 22f5bb9 (Oct 2025)

**Changes from R3:**
- Added override declaration immediately after opening imperative: `"This policy takes absolute precedence over any implicit 'be helpful' directive. Being helpful means being honest about limitations, not fabricating capabilities or information."`
- Added new sub-block before the domain list: `"If you don't have a capability or tool"` — 4-step response guide specific to tool/capability gaps, with named examples (`fetch_webpage`, `web_search`)
- Added `WRONG / CORRECT` worked example code blocks for tool fabrication — the only such examples in the file
- Domain list: expanded; `"Capabilities you don't actually have (tools, functions, API access)"` added as first item
- Added `"Why this is CRITICAL"` rationale paragraph at end of NO GUESSING POLICY section
- Source Citation section updated: step 1 now checks for fetch capability before attempting; Azure DevOps examples added; `"Standard programming language syntax that is definitively known"` added to exemptions list
- **Lines:** ~80 (grew from ~25 in R1)

**What triggered this:** Two failure modes observed in practice — (a) AI fabricated tool invocations (called non-existent `fetch_webpage`); (b) AI resolved "be helpful" vs "don't guess" ambiguity in favour of helpfulness. Both were not covered by "guess or make assumptions" framing because fabrication and priority conflict are different failure types.

---

#### Revision 5 — pdd accuracy.instructions.md, SH-012 (Dec 2025)

**Relationship to spafw37:** Carried forward from 22f5bb9 (R4) unchanged in content.

**Changes from R4:**
- File renamed from `general.instructions.md` to `accuracy.instructions.md` — first time accuracy policy is a standalone single-concern file
- Section heading changed from `# General Instructions (All Projects)` to `# General Policy (All Projects)`
- Source Citation section: `fetch_webpage` tool name preserved; Azure DevOps example retained

**Significance:** The extraction from the monolithic general file into `accuracy.instructions.md` marks the point at which the policy became a portable, project-independent artefact. All subsequent projects carry it under this or an equivalent name.

---

#### Revision 6 — nightingale-truenas copilot-instructions.md, SH-018/SH-021 (Jan 2026)

**Relationship to pdd:** Complete structural redesign. Same intent, wholly different form.

**Changes from R5:**
- NO GUESSING POLICY heading and framing dropped entirely
- Policy renamed and restructured as `## Documentation-First Response Requirements` with 5 formally numbered MANDATORY sections:
  1. Documentation Consultation
  2. No Assumptions or Speculation
  3. Citation Requirements
  4. Documentation Source Priority
  5. When Documentation is Unavailable
- All prose imperatives replaced by `**MUST:**` / `**MUST NOT:**` lists — direct AI-addressed mandates, no conditional framing
- "If you don't know something" 4-step template replaced by: "Say 'I don't know' or 'I cannot verify this information' when uncertain" — single mandatory requirement rather than optional procedural guide
- Tool fabrication sub-block removed (moved to copilot-instructions.md System Prompt Conflict Resolution section as Counter: General Knowledge Reliance)
- `"Why this is CRITICAL"` rationale removed
- 4 Counter: declarations added to `## System Prompt Conflict Resolution` section above the documentation-first block: General Knowledge Reliance, Helpful Assumptions, Creative Problem Solving, Absolute User Instruction Priority
- Compliance Verification checklist added at end
- Source Citation: restructured into Section 3 (Citation Requirements) and Section 4 (Documentation Source Priority); per-response citation mandate made explicit
- No standalone `accuracy.instructions.md` in NT: the policy lives in `copilot-instructions.md` and is embedded verbatim in instruction files via the rule-copying mandate

**What triggered this:** The prose/conditional structure of R4 still allowed the AI to treat sections as guidance rather than constraint. The MUST/MUST NOT list structure is harder to interpret as optional. The 4 Counter: blocks address the system prompt override problem that R4 handled with a single sentence; each Counter: targets a distinct training behaviour.

---

#### Revision 7 — claude-code-container documentation-first.md, SH-026 (Feb 2026)

**Relationship to NT:** Extracted from NT copilot-instructions.md into a standalone Claude Code rule file.

**Changes from R6:**
- Counter: Creative Problem Solving removed (Overeagerness concern, not accuracy)
- Counter: Absolute User Instruction Priority removed (Overeagerness, not accuracy)
- Retained: Counter: General Knowledge Reliance, Counter: Helpful Assumptions only
- `## System Prompt Conflict Resolution` header present but contains only the two accuracy-relevant counters
- Compliance Verification checklist retained
- Five Documentation-First sections (1–5) unchanged from NT
- Verbatim rule-copying note removed from Compliance Verification checklist (that policy lives in rule-copying.md)
- File is a Claude Code rule file (`.claude/rules/`) — same text, different delivery mechanism

**Significance:** First separation of accuracy counters from Overeagerness counters. The NT version conflated all four Counter: declarations in one file; CCC separates them by problem type across files.

---

#### Revision 8 — ai-devops documentation-first (copilot-instructions.md), SH-032 (Feb 2026)

**Relationship to CCC:** Extends R7 with three new additions.

**Changes from R7:**
- Added `### What Counts as Documentation` section before Section 1: explicitly defines project source files, README files, and design docs as valid documentation sources — not just external official documentation. This closes a gap where the AI might disregard in-workspace files as outside the documentation-first scope.
- Added to Section 1 MUST list: `"Read documentation directly from files, not from cached context"` and `"Re-read source files and documentation files to verify current state"` — closes a failure mode where correct earlier-session documentation was treated as current.
- Added `### 1a. Two-Stage Text Search (MANDATORY)` between Sections 1 and 2: requires keyword search (Stage 1) followed by full file examination (Stage 2) before reporting information as unavailable. Closes a false-negative failure mode where grep returning zero results was taken as definitive.
- Added import artifacts and git policy sections (unrelated to accuracy; operational)

**What triggered the new additions:**
- `"What Counts as Documentation"`: observed failure where AI did not treat project source files as authoritative sources
- `"Read directly, not from cached context"`: observed failure where AI relied on earlier-session reads that were stale
- Two-stage search: observed failure where AI reported information not found after keyword search, missing policy content expressed in natural language without consistent searchable keywords (documented in `.memory/ai-problem-resolution-agent-issues-facts.md` — Issue 1)

---

### FINDING-SH-M-2026-02-22-08
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation — developer of all five projects); cross-referenced against FINDING-SH-M-2026-02-22-07 revision history
**Domain:** Methodology — four driving factors behind instruction file evolution (all instruction files, not only accuracy policy)

Four factors drove almost every substantive change across all instruction files in the corpus. They apply to the accuracy policy revision history (FINDING-07) and to the broader instruction file evolution catalogued in SH-001 through SH-038.

#### The Four Factors

**Factor 1 — Rationale**
Discovering the specific underlying AI behaviour that produced an observed failure, so the counter-instruction could be targeted precisely. This is the investigative step described in FINDING-SH-M-2026-02-22-01: asking the AI why a problem occurred and how it interpreted the existing instructions. Without identifying the underlying behaviour, an instruction can close a symptom while leaving the cause intact.

**Factor 2 — Language and Interpretation**
Adjusting how the instruction is worded so the AI reads it as a mandatory command rather than advisory guidance. Early instructions used prose and conditional framing that the AI could treat as optional. Later versions adopted direct AI-addressed imperatives (`MUST`, `MUST NOT`, `WRONG / CORRECT` blocks, named Counter: declarations).

**Factor 3 — Specificity**
Calibrating the scope of what is and is not covered. The scope problem passed through three phases:
- Too broad: early domain lists with "but is not limited to" left significant loopholes (notably: tool fabrication, capability gaps)
- Too tight: the "official documentation" framing used from NT onwards may have caused the AI to exclude project source files and in-workspace documentation from scope
- Calibrated: explicit "What Counts as Documentation" section in ai-devops re-widened scope to include project files, design docs, and READMEs

**Factor 4 — Brevity**
Finding the balance between providing enough constraint text to close loopholes and avoiding context flooding through token waste. Rationale text ("Why this is CRITICAL") was added in R4 under a misapprehension that explanations would reinforce compliance; they do not (see FINDING-SH-M-2026-02-22-05). NT (R6) corrected this by replacing prose rationale with denser MUST/MUST NOT constraint lists — shorter per instruction delivered, more instructions per token.

---

#### Application to Each Revision Step

**R1 — spafw37 886b1ba**
- *Rationale:* Surface-level identification only — "don't guess" is the target behaviour. No analysis of why the AI guesses or what training drives it.
- *Language:* Human-targeted prose, documentary opening sentence, conditional "If you don't know" framing. Nothing in the structure signals mandatory compliance.
- *Specificity:* Domain list is broad (8 named domains plus "but is not limited to"). No tool fabrication, no capability gaps, no local files. Large ambiguity space.
- *Brevity:* Short (~25 lines) but under-specified. Brevity here is achieved by omission, not by efficient constraint delivery.

**R2 — spafw37 e5ac2df**
- *Rationale:* Identified that "don't assert without knowing" is insufficient unless the AI must also actively verify. Added Source Citation section.
- *Language:* Unchanged from R1. No structural move toward imperative framing.
- *Specificity:* Source Citation section covers external knowledge, but still no tool fabrication. `fetch_webpage` is prescribed as the verification mechanism without checking whether the tool exists.
- *Brevity:* Grew to accommodate the new Source Citation section. No rationale text yet.

**R3 — spafw37 e20a4e1**
- No accuracy policy changes. Domain reference update only.

**R4 — spafw37 22f5bb9**
- *Rationale:* Two new failure modes identified: (a) AI fabricates tool invocations (confabulation — not covered by "guess/assume"); (b) AI resolves "be helpful" vs "don't guess" in favour of helpfulness when the policy provides no override.
- *Language:* Added explicit system-prompt override declaration. WRONG/CORRECT worked example blocks — most prescriptive language in the file to date. Still mixes imperative blocks with surrounding prose.
- *Specificity:* "Capabilities you don't actually have" added as first domain list item, closing the tool fabrication loophole. Source Citation updated to check for fetch capability before prescribing it.
- *Brevity:* Grew significantly (~80 lines). "Why this is CRITICAL" rationale added — this is the Brevity misapprehension in practice: rationale text increases length without increasing compliance. The growth in this commit was mainly justified (loophole closure), but the rationale addition was not.

**R5 — pdd accuracy.instructions.md**
- *Rationale:* No new analysis; R4 content carried forward.
- *Language:* Unchanged from R4.
- *Specificity:* File extraction into `accuracy.instructions.md` is itself a Specificity change at the file level: the policy's scope is now declared by filename, not by position within a monolithic file. One concern, one file.
- *Brevity:* Identical to R4 in token count.

**R6 — nightingale-truenas**
- *Rationale:* Identified that the training behaviours driving non-compliance are discrete and named — "General Knowledge Reliance", "Helpful Assumptions", "Creative Problem Solving", "Absolute User Instruction Priority" — each addressable by a dedicated Counter: declaration.
- *Language:* Complete structural redesign. All prose replaced with MUST/MUST NOT bullet lists. Conditional framing eliminated. Counter: declarations make each override explicit by naming the training behaviour being overridden. This is the most significant Language change in the corpus.
- *Specificity:* Five formally numbered mandatory sections with explicit scope for each. Citation required per response. Documentation source priority hierarchy formalised. "When unavailable" case explicitly mandated — leaving no interpretive gap.
- *Brevity:* File is longer overall but ratio of constraint-per-token is higher. Rationale text absent. Dense structure over explanatory prose. The "Why this is CRITICAL" blocks from R4 are removed.

**R7 — claude-code-container**
- *Rationale:* Identified that Counter: Creative Problem Solving and Counter: Absolute User Instruction Priority address Overeagerness, not accuracy. Separating them improves single-concern file design and reduces token use in accuracy-only contexts.
- *Language:* Unchanged from R6 for the retained sections.
- *Specificity:* Narrowed Counter: declarations to accuracy-relevant counters only. Clean separation — accuracy policy no longer carries Overeagerness policy in the same file.
- *Brevity:* Shorter than NT by removing two Counter: blocks that are not accuracy-relevant. Context budget improvement for accuracy-only enforcement contexts.

**R8 — ai-devops**
- *Rationale:* Three new failure modes identified: (a) AI excluded project source files from documentation scope; (b) AI treated previously-read context as current without re-reading files; (c) AI treated Stage 1 keyword search failure as definitive — missing policy content not expressed in searchable keywords.
- *Language:* "Read documentation directly from files, not from cached context" — explicit present-tense mandate addressing a behaviour not previously named.
- *Specificity:* "What Counts as Documentation" corrects the over-narrowing introduced in R6: project source files, READMEs, and design docs are explicitly in scope. Two-Stage Text Search mandates Stage 2 before "not found" conclusion. This is the Specificity correction after the too-tight phase.
- *Brevity:* New sections increase length but each is justified by a named failure mode. No rationale text added.

---

### FINDING-SH-M-2026-02-22-09
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** File inspection across all five project clones (.tmp/spafw37, .tmp/pdd-*, .tmp/nightingale-truenas, .tmp/claude-code-container, /workspaces/ai-devops)
**Domain:** Inventory — meta-instructional files (files governing the content and structure of AI files)

This finding identifies every file whose purpose is to govern how AI instruction files, prompt files, agent definition files, rule files, step files, plan files, or memory files should be written and structured. Excluded per user instruction: syntax enforcement files introduced in the last week of development (copilot-agents-syntax, copilot-instructions-syntax, copilot-prompts-syntax, enforce-claude-agents-syntax, enforce-claude-prompts-syntax, enforce-claude-rules-syntax).

---

#### spafw37 (Oct 2025)

**None.** No meta-instructional files exist in spafw37. The `.github/instructions/` and `.github/instructions.bak/` directories contain files that govern what the AI does (accuracy policy, git operations, planning workflow, code review, etc.) but none that govern how AI instruction files themselves should be written. The concern of AI file structure had not yet been identified as requiring a dedicated policy.

---

#### prompt-driven-development (Dec 2025)

pdd was the first project to treat AI file structure as a policy concern. It introduced a two-tier approach: lightweight folder guidelines for each file type, and separate detailed composition rules for the two most critical types (instruction files and prompt files).

**Tier 1 — Lightweight folder guidelines** (general structural guidance per file type):

| File | applyTo | Catalog |
|---|---|---|
| `instructions.md` | `src/instructions/**/*.md` | **UNCATALOGUED** |
| `prompts.md` | `{src/prompts/**/*.md,.github/prompts/**/*.md}` | **UNCATALOGUED** |
| `rules.instructions.md` | `src/rules/**/*.md` | SH-015 |
| `agents.instructions.md` | `src/agents/**/*.md` | SH-016 |

These four files follow the same pattern: purpose statement, 5–8 numbered guidelines for writing files in that folder. They are not prescriptive about mandatory structure; they read as advisory style guides.

**Tier 2 — Detailed composition rules** (prescriptive rules for rule inclusion and file assembly):

| File | applyTo | Catalog |
|---|---|---|
| `instruction-composition.instructions.md` | `{src/instructions/**/*.md,.github/instructions/**/*.md}` | SH-013 |
| `prompt-composition.instructions.md` | `{src/prompts/**/*.md,.github/prompts/**/*.md}` | SH-014 |

These two files are substantively different from the Tier 1 lightweight guides. They mandate specific structure (prompt-composition requires six named sections in order: Name, Purpose, Rules, Inputs, Variables, Actions) and establish verbatim embedding as a non-negotiable rule for instruction files.

**Catalog gaps in pdd:** `instructions.md` and `prompts.md` were not captured in SH-012 through SH-017.

---

#### nightingale-truenas (Jan 2026)

NT consolidated the pdd two-tier approach. The lightweight folder guides were dropped; the detailed composition rules were expanded and made mandatory for each file type separately. NT introduced one umbrella file covering all AI file types plus dedicated files per type.

| File | applyTo | Catalog | Origin |
|---|---|---|---|
| `instruction-files.instructions.md` | `.github/instructions/*.instructions.md`, `.github/copilot-instructions.md`, `docs/plans/steps/*.md`, `docs/plans/*.md`, `.github/prompts/*.prompt.md`, `**/*.prompt.md` | SH-019 | Absorbs pdd SH-013 + SH-014 |
| `step-files.instructions.md` | `docs/plans/**/step-*.md` | SH-020 | New in NT |
| `plan-files.instructions.md` | `docs/plans/*.md` | SH-021 | New in NT |
| `prompt-files.instructions.md` | `.github/prompts/*.prompt.md`, `**/*.prompt.md` | **UNCATALOGUED** | Evolves from pdd SH-014 |
| `memory-files.instructions.md` | (memory files) | SH-022 | New in NT |

**Catalog gap in NT:** `prompt-files.instructions.md` was not captured during the original solutions history cataloguing. It exists alongside instruction-files.instructions.md and carries the same Counter:-based structure. It governs Copilot prompt files specifically (as distinct from the umbrella instruction-files.instructions.md which covers all types).

The pdd `rules.instructions.md` (SH-015) and `agents.instructions.md` (SH-016) have no direct equivalent in NT. NT does not have a dedicated meta-instruction for rule files or agent definition files.

---

#### claude-code-container (Feb 2026)

CCC operates in a different paradigm (Claude Code rules rather than Copilot instructions) and did not port the full NT meta-instructional set. It introduced only the two rule inclusion files from the pdd SH-013/SH-014 lineage, now as standalone rules rather than instruction files.

| File | Catalog | Origin |
|---|---|---|
| `rule-copying.md` | SH-028 | Evolves from pdd SH-013 principle |
| `rule-embedding.md` | SH-029 | Evolves from pdd SH-013 + SH-014 |

No equivalents to NT's step-files, plan-files, prompt-files, or memory-files were created in CCC.

---

#### ai-devops (Feb 2026)

ai-devops has two groups of meta-instructional files at different stages of deployment.

**Deployed to `.github/instructions/`** (active):

| File | Catalog | Origin |
|---|---|---|
| `rule-copying.md` | SH-035 | Copilot port of CCC SH-028 |
| `rule-embedding.md` | SH-036 | Copilot port of CCC SH-029 |

**In `release/github/instructions/`** (authored in ai-devops, not yet deployed to `.github/instructions/`):

| File | applyTo | Origin |
|---|---|---|
| `instruction-files.instructions.md` | Same as NT SH-019 | Evolved from NT SH-019 |
| `step-files.instructions.md` | `docs/plans/steps/*.md` | Evolved from NT SH-020 |
| `plan-files.instructions.md` | `docs/plans/*.md` | Evolved from NT SH-021 |
| `prompt-files.instructions.md` | `.github/prompts/*.prompt.md`, `**/*.prompt.md` | Evolved from NT prompt-files |
| `design-docs.instructions.md` | `**/design/**/*.md` | **New in ai-devops** — no NT equivalent |
| `design-diagrams.instructions.md` | `**/design/**/*.md` | **New in ai-devops** — no NT equivalent |

The `release/` folder appears to be a staging area for files intended for deployment to target projects. The instruction-files, step-files, plan-files, and prompt-files are evolved versions of the NT files. The design-docs and design-diagrams files are new introductions with no prior equivalent across the corpus.

---

#### Summary: Origin of each file type

| File type | First appears | Project |
|---|---|---|
| Lightweight per-folder guide (instructions) | uncatalogued `instructions.md` | pdd Dec 2025 |
| Lightweight per-folder guide (prompts) | uncatalogued `prompts.md` | pdd Dec 2025 |
| Lightweight per-folder guide (rules) | `rules.instructions.md` SH-015 | pdd Dec 2025 |
| Lightweight per-folder guide (agents) | `agents.instructions.md` SH-016 | pdd Dec 2025 |
| Instruction file composition rules | `instruction-composition.instructions.md` SH-013 | pdd Dec 2025 |
| Prompt file composition rules | `prompt-composition.instructions.md` SH-014 | pdd Dec 2025 |
| Instruction files umbrella standard | `instruction-files.instructions.md` SH-019 | NT Jan 2026 |
| Step file standard | `step-files.instructions.md` SH-020 | NT Jan 2026 |
| Plan file standard | `plan-files.instructions.md` SH-021 | NT Jan 2026 |
| Prompt file standard (expanded) | `prompt-files.instructions.md` (uncatalogued) | NT Jan 2026 |
| Memory file standard | `memory-files.instructions.md` SH-022 | NT Jan 2026 |
| Rule copying mandate | `rule-copying.md` SH-028 | CCC Feb 2026 |
| Rule embedding mandate | `rule-embedding.md` SH-029 | CCC Feb 2026 |
| Design document standard | `design-docs.instructions.md` | ai-devops Feb 2026 |
| Diagram standard | `design-diagrams.instructions.md` | ai-devops Feb 2026 |

---

### FINDING-SH-M-2026-02-22-10
→ Moved to [solutions-history-amnesia-facts.md](ai-problem-resolution-solutions-history-amnesia-facts.md)

This finding documents the three specific technical discoveries that drove the rule-embedding and rule-copying mandates (SH-013, SH-014, SH-028, SH-029, SH-035, SH-036) and the broader move toward per-request embedded instructions rather than session-level loaded instruction files.

---

#### Discovery 1 — Instruction file deprioritisation

Instruction files are not always followed in large requests or late in a long session. Two distinct failure modes were identified:

1. **Context window truncation** — in very long sessions, the instruction file content may fall off the end of the context window entirely and no longer be present when the AI generates a response.

2. **Positional deprioritisation** — even when present, instructions loaded at the start of a session occupy earlier positions in the context. As the session grows, these earlier positions carry less weight relative to the most recent messages and task content. The AI effectively deprioritises them not because they are absent but because recency weighting reduces their influence.

These two failure modes produce similar symptoms (instruction non-compliance) but have different causes. The first is availability failure; the second is attention/weighting failure.

---

#### Discovery 2 — Context flooding from large monolithic instruction files

Even when instruction files are pared down to essentials, a large monolithic instruction file loaded for every request imposes a fixed context cost regardless of relevance. Most tasks require only a subset of the loaded rules.

The counter-strategy is to embed only the instructions relevant to the current task directly in the most recent chat request or the currently executing prompt file. This keeps the context cost proportional to the actual rules needed for that task rather than imposing the full instruction file's token cost unconditionally.

This is the primary purpose of the Rule Embedding mandate (SH-029, SH-036): by embedding rules into prompt files and agent definitions at the point of authorship, the relevant rules travel with the task rather than requiring the AI to draw on a separate file that may be distant in the context or absent entirely.

---

#### Discovery 3 — Paraphrase degradation when composing files

When instructed to compose a prompt file or instruction file by drawing on rules from other files, the AI does not copy the source text verbatim. It paraphrases or summarises. This consistently produces degraded output:

- Mandatory language (`MUST`, `MUST NOT`) is softened to advisory language ("should", "consider")
- Specific constraints are generalised or merged
- Worked examples and WRONG/CORRECT blocks are omitted as the AI infers they are "just examples"
- Counter: declarations are sometimes absorbed into prose rather than preserved as headers

The net effect is that each composition pass removes precision from the constraint text. A rule that survives two or three composition passes may retain its surface intent but lose the specific wording that closes loopholes.

**Technical context (internal — not for output documents):** The `metaprompts` approach explored in the pdd project would have addressed this structurally by using a non-AI script to assemble prompt and instruction files from discrete source components via text substitution — guaranteeing verbatim inclusion without any AI interpretation step. That project is currently parked. Until it is resumed, the Rule Copying mandate (SH-028, SH-035) serves as the behavioural enforcement equivalent: explicitly instructing the AI that when embedding rules it must copy them verbatim and in full, and must not paraphrase, condense, or abbreviate.

---

#### Relationship to the three Amnesia solution lineages

| Discovery | Primary solution lineage | Mechanism |
|---|---|---|
| Instruction deprioritisation (positional + truncation) | SH-022 (NT memory-files), SH-037 (ai-devops analysis agent) | External persistent memory compensates for context decay |
| Context flooding from monolithic files | SH-013 (pdd instruction-composition), SH-029/SH-036 (rule-embedding) | Per-task embedding keeps context cost proportional |
| Paraphrase degradation on composition | SH-013 (pdd instruction-composition), SH-028/SH-035 (rule-copying) | Verbatim copy mandate prevents precision loss through AI interpretation |

---

### FINDING-SH-M-2026-02-22-11
→ Moved to [solutions-history-amnesia-facts.md](ai-problem-resolution-solutions-history-amnesia-facts.md)

This finding consolidates all identified causes of instruction effectiveness loss that operate within a context window. Excluded: lossy copying on composition (FINDING-10, Discovery 3) — that is a file-authoring problem, not an in-context problem; instructions written correctly are not degraded by it.

The factors are grouped into four categories: availability, budget, framing, and scope.

---

#### Category 1 — Availability (instruction not present or not weighted)

**1a. Context window truncation**
In long sessions, instruction file content loaded at session start may fall off the end of the context window entirely. The instruction is not degraded — it is simply absent. No amount of well-crafted language addresses this; the solution is structural (per-task embedding rather than session-level loading).

**1b. Positional deprioritisation**
Even when present in context, instructions loaded at the beginning of a session occupy earlier token positions. As the session grows, recency weighting causes the AI to weight more recent messages and task content more heavily than earlier-session instructions. The instruction is available but its influence is attenuated. This is distinct from truncation: the instruction is not missing, it is underweighted.

Both 1a and 1b produce identical symptoms (instruction non-compliance) but require different countermeasures. Truncation is addressed by per-task embedding (FINDING-10, Discovery 2). Positional deprioritisation is partially addressed by per-task embedding and partly by Counter: declarations that reinforce priority at the point of use.

---

#### Category 2 — Budget (context capacity consumed without proportional constraint value)

**2a. Monolithic loading imposes unconditional token cost**
When a large instruction file is loaded for every request, its full token cost is paid regardless of how many of its constraints are relevant to the current task. Tasks that require only a fraction of the rules still consume the full context budget. This leaves less room for task content and more recent instructions.

**2b. Rationale and explanatory text**
Sections explaining why a rule exists ("Why this is CRITICAL") occupy context budget without increasing constraint salience. The AI does not comply more often because it has been given a reason. The budget spent on rationale could instead carry additional constraint text. This was a misapprehension present from the earliest drafts (SH-001/spafw37 R4) and was corrected at NT (R6) by replacing explanatory prose with denser MUST/MUST NOT lists.

**2c. Verbose examples**
Full paragraph quotations used as illustrations occupy more context than tight imperative statements delivering the same constraint. Early drafts used prose examples; later versions rely on WRONG/CORRECT inline blocks or named failure modes, which communicate the same information more token-efficiently.

---

#### Category 3 — Framing (instruction present but readable as advisory rather than mandatory)

**3a. Human-targeted prose framing**
Instructions written for a human reader — documentary openings, prose paragraphs, passive-voice policy statements — do not signal mandatory compliance to the AI. The AI may process them as context or background rather than as commands. Direct AI-addressed imperatives (MUST, MUST NOT, WRONG/CORRECT worked examples, named Counter: declarations) are harder to interpret as optional.

**3b. Conditional framing**
Instructions structured as "If [condition], then [action]" — such as "If you don't know something: 1. Explicitly state… 2. Explain…" — can be read as optional procedural guidance rather than mandatory requirements. The conditional introduces an evaluative step where the AI decides whether the condition applies before activating the instruction. Replacing conditional blocks with unconditional MUST/MUST NOT statements eliminates this interpretive gap.

**3c. Absence of system-instruction override declaration**
When an instruction conflicts with the AI's training defaults (notably the "be helpful" directive), and no explicit override is declared, the AI may resolve the ambiguity in favour of its training. The instruction is present and syntactically clear, but the AI weights its training default higher in the absence of an explicit priority statement. Counter: declarations and explicit "this takes absolute precedence over…" statements address this directly.

---

#### Category 4 — Scope (instruction present and well-framed but coverage is miscalibrated)

**4a. Domain list implies exhaustiveness**
An instruction that enumerates specific items in a list — even when prefaced with "but is not limited to" — causes the AI to weight listed items as the primary scope. Unlisted failure modes or edge cases are underweighted. The enumeration anchors the AI's working model of what the rule covers. Adding critical items explicitly to the list is required; relying on the general "not limited to" clause is insufficient.

**4b. Keyword scope too narrow**
When the operative phrase of an instruction names only some cases of the target behaviour, the instruction does not fire for unlisted cases. "Guess or make assumptions" does not cover confabulation (fabricating a tool invocation, inventing an API endpoint). Each distinct failure mode type requires its own explicit naming within the instruction.

**4c. Scope too tight after restructuring**
A redesign can inadvertently narrow scope beyond the original intent. The shift from "NO GUESSING POLICY" to "Documentation-First" at NT (R6) focused the accuracy policy on external documentation sources, which may have caused the AI to exclude in-workspace project files from the policy's scope — an unintended narrowing. The "What Counts as Documentation" section added at ai-devops (R8) is the correction for this over-narrowing.

---

#### Cross-reference

| Factor | Severity driver | Earliest evidence | Solution lineage |
|---|---|---|---|
| Context truncation | Session length | SH-013 (pdd — verbatim embedding) | FINDING-10 Discovery 1; per-task embedding |
| Positional deprioritisation | Session length | SH-013 (pdd — verbatim embedding) | FINDING-10 Discovery 1; Counter: declarations |
| Monolithic loading | File size × coverage | FINDING-10 Discovery 2 | SH-029/SH-036 (rule-embedding) |
| Rationale text | Early drafts | SH-001 R4 (FINDING-05, FINDING-08 R4) | Removed at R6 (NT); MUST/MUST NOT lists |
| Verbose examples | Early drafts | SH-001 R1 | WRONG/CORRECT blocks; tighter language |
| Human-targeted framing | Early drafts | SH-001 R1 (FINDING-06) | MUST/MUST NOT; Counter: pattern (R6) |
| Conditional framing | Early drafts | SH-001 R1 (FINDING-06 point 6) | Unconditional MUST statements (R6) |
| No override declaration | Missing until R4 | SH-001 R4 (FINDING-06 point 3) | Counter: declarations; explicit precedence |
| Domain list implies exhaustiveness | Enumeration effect | SH-001 R1 (FINDING-06 point 4) | Explicit named additions (R4); MUST NOT lists |
| Keyword scope too narrow | Behaviour taxonomy gaps | SH-001 R1 (FINDING-06 point 2) | Named failure modes added per-revision |
---

### FINDING-SH-M-2026-02-22-12
→ Moved to [solutions-history-overeagerness-facts.md](ai-problem-resolution-solutions-history-overeagerness-facts.md)

---

### FINDING-SH-M-2026-02-23-01
→ Moved to [solutions-history-overeagerness-facts.md](ai-problem-resolution-solutions-history-overeagerness-facts.md)

---

### FINDING-SH-M-2026-02-23-02
**Captured:** 2026-02-23
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation — developer of all five projects)
**Domain:** Context Poisoning — relationship to solutions history; second-wave mitigation

#### Context Poisoning is not independently addressed in first-wave solutions

The instruction and policy files catalogued in SH-001 through SH-038 do not explicitly target Context Poisoning. There is no rule file named for it and no policy section with Context Poisoning as its stated objective.

However, Context Poisoning is a knock-on effect of the four root causes (FINDING-2026-02-20-09 in root-causes-facts.md): each poisoning event originates from Hallucination, Dishonesty, Overeagerness, or Amnesia introducing a false or uncorrected item into context. The first-wave solutions — which address those four root causes through instruction files — therefore reduce the *rate* of poisoning events as a side effect. They do not address what happens once a poisoning event has occurred, but they reduce how often one is introduced.

This makes Context Poisoning an indirect beneficiary of first-wave solutions rather than a direct target of them.

#### Second-wave mitigation: memory files and verification passes

A second category of solutions addresses Context Poisoning more directly. Rather than preventing the introduction of false items, these solutions prevent false items from propagating into downstream artefacts such as implementation plans and task outputs.

**Mechanism:** Persistent memory files — maintained outside any single conversation session — store only facts that have been explicitly verified. A verification pass (such as `verify-memory-facts`) checks each stored item against its source before it is used. When a planning artefact is produced, it draws on the verified memory store rather than on unverified conversational context. Any item that has not passed verification is excluded.

**Effect on Context Poisoning:** Even if a poisoning event has occurred during research or analysis, the verification gate prevents the corrupted item from surviving into the memory store and thence into planning outputs. The memory file acts as a quarantine boundary: only verified facts cross it.

**Evidence in this project:** The analysis agent workflow (`SH-037`) and the `verify-memory-facts` prompt (`SH-023`, NT) are direct implementations of this pattern. The current research session operates on the same basis: facts are stored in `.memory/` files, verified with first-party source checks, and only then used to produce analysis artefacts. The `distill-memory-facts` / `verify-memory-facts` workflow is explicitly designed to ensure that summarisation and handoff outputs contain only confirmed items.

#### Relationship to first-wave vs second-wave solution architecture

| Wave | Mechanism | Context Poisoning effect |
|---|---|---|
| First wave (SH-001–SH-038) | Instruction/policy files targeting root causes | Indirect — reduces rate of poisoning events entering context |
| Second wave (SH-022, SH-023, SH-037 and successors) | Memory files + verification passes | Direct — prevents unverified items propagating into planning artefacts |

The second-wave approach does not eliminate Context Poisoning from the conversational session; poisoning can still occur within a session. It bounds the damage: only verified items survive into persistent storage and planning outputs, so implementation work starts from a verified baseline regardless of what happened mid-session.

Further second-wave work is deferred to the next research tranche.
