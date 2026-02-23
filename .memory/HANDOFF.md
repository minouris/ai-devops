# Project Handoff

**Last Updated:** 2026-02-23 (session 8)
**Current State:** Solutions history subtopic verification complete. All 12 methodology findings tagged `[VERIFIED on 2026-02-23 by first-party research synthesis]`. CLARIFICATION-02a, 12a, 12b merged into base findings and removed. Fact file 1,065 lines. Log current through LOG-2026-02-23-01. Pending: SH-039/040/041 catalog entries; SH-038/031 miscategorisation correction; evolution analysis of meta-instructional files; consolidate-clarifications prompt.

---

## Environment

**Project:** ai-devops  
**Location:** /home/mnorr001/src/github/minouris/ai-devops  
**Purpose:** Unified AI-driven DevOps methodology framework

The local filesystem has an active login to the `minouris` account on GitHub for accessing our repos.

---

## Project Context

### Source Projects Analyzed
Five projects examined for rule evolution:
1. **spafw37** (Oct 2025) - Origin of plan-based approach, 9 instruction files
2. **prompt-driven-development** (Dec 2025) - Composition patterns, 9+ instruction files  
3. **nightingale-truenas** (Jan 2026) - Step-files discovery, memory-based approach, 5 instruction files
4. **claude-code-container** (Feb 2026) - Latest consolidation, 7+ instruction files; contains custom modes research documentation
5. **simbox** (Sept 2025) - Documentation format examples

### Current ai-devops State
- **13 instruction files** in `.github/instructions/`
- **2 prompt files** in `.github/prompts/`
- **1 agent** in `.github/agents/`
- Missing: Quality standards (accuracy, communication, code review), memory-files, step-files, composition patterns

---

## Key Files

```
ai-devops/
├── .github/
│   ├── agents/
│   │   └── analysis.agent.md            # Analytical/procedural research agent (overhauled 2026-02-20)
│   ├── copilot-instructions.md          # Project-wide Copilot rules
│   ├── instructions/
│   │   ├── documentation-first.md       # Two-stage text search policy added
│   │   └── git-policy.md                # GitHub Data Access policy + .tmp/ fix added
│   └── prompts/
│       ├── consolidate-session.prompt.md # Session handoff consolidation
│       ├── record-operation.prompt.md    # NEW: append operation record to topic log
│       └── verify-memory-facts.prompt.md # Fact verification for .memory files
├── .gitignore                            # Excludes .memory/
└── .memory/                              # Session memory (not committed)
    ├── HANDOFF.md
    ├── ai-problem-resolution-log.md       # Operation log — see for full topic history
    ├── ai-problem-resolution-problems-facts.md
    ├── ai-problem-resolution-problems-facts-disproven.md
    ├── ai-problem-resolution-root-causes-facts.md
    ├── ai-problem-resolution-agent-issues-facts.md
    ├── ai-problem-resolution-solutions-history-facts.md # Catalog SH-001–SH-038 + Findings 01–09
    ├── ai-problem-resolution-PENDING.md              # Draft executive summary — PENDING USER APPROVAL
    ├── ai-problem-resolution-external-evidence-facts.md # 7 external findings (Replit incident, Fawzy et al., Pearce et al., SWE-bench, vulnerable developer, reprompt loop)
    ├── vibe-coding-pitfalls-PENDING.md                  # Draft vibe coding pitfalls guide — APPROVED
    ├── ai-problem-resolution-index.md
    ├── ai-devops-chatmodes-skills-facts.md          # 24 verified findings (all tagged)
    ├── ai-devops-chatmodes-skills-facts-archive-2026-02-19.md  # 12 rejected claims
    ├── ai-devops-ai-programming-problems-facts.md   # 5 findings (earlier session)
    └── verification_log.md               # Log of all verify-memory-facts runs
```

---

## Prompts

### verify-memory-facts.prompt.md
**Source:** Imported and adapted from `minouris/nightingale-truenas` (`distill-memory-facts.prompt.md`)  
**Purpose:** Verify all facts in a nominated `.memory/` file against authoritative sources  
**Invoke:** `/verify-memory-facts memoryFilePath=.memory/{filename}.md`  
**What it does:**
- Fetches every cited source to verify fact accuracy and currency
- Separates facts into ACCEPTED (verified) and REJECTED (outdated/unverifiable)
- Tags each accepted fact: `**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}]` after `**Captured:**`
- Skips facts already tagged within the last 30 days (say "force re-verify" to override)
- Creates archive file: `.memory/{basename}_archive_{date}.md` for rejected facts
- Updates original file with verified facts, refreshed citations, and verification tags
- Logs run to `.memory/verification_log.md`

### record-operation.prompt.md
**Purpose:** Append a compact record of the latest AI operation to a rolling topic log  
**Invoke:** `/record-operation topic={slug}`  
**What it does:**
- Reads `.memory/[topic]-log.md` to avoid duplicating the previous entry
- Extracts only what changed in the current operation (not a full session review)
- Appends a timestamped entry: operation type, files changed, findings, commands, issues, next step
- Creates `.memory/[topic]-log.md` if it does not exist
- Called automatically by the analysis agent after each significant operation

---

## Custom Agents

### analysis.agent.md
**Purpose:** Systematic research — procedural (find/test/verify procedures) and analytical (examine artifacts, capture findings)  
**Location:** `.github/agents/analysis.agent.md`  
**Tools:** execute, read, edit, search, web, ms-vscode.vscode-websearchforcopilot/websearch  
**Usage:** Switch to `@analysis` agent in Copilot Chat

**On first load:** Prompts for topic slug → reads `.memory/[topic]-log.md` → summarises last 1–3 entries to restore context

**Memory file naming:** All session files share `[topic]-` prefix:
- `.memory/[topic]-facts.md` — research findings (or `[topic]-[subtopic]-facts.md` for distinct areas)
- `.memory/[topic]-facts-disproven.md` — archived disproven findings
- `.memory/[topic]-index.md` — analysis index (lists all subtopic files)
- `.memory/[topic]-log.md` — operation log (append-only)

**Workflow (Procedural):** Confirm topic → capture findings in fact file → test and refine → log each operation → wait for user request → create draft in `.memory/` → user approves → publish

**Workflow (Analytical):** Confirm topic → capture findings in fact file → maintain index → archive disproven findings immediately → log each operation → wait for user request → run `verify-memory-facts` → create draft in `.memory/` → user approves → publish

**Key policies embedded in agent:**
- Two-stage text search: keyword search first; direct file reading before reporting not found
- GitHub data access: `gh` CLI only; `fetch_webpage` against github.com prohibited
- Temp files: `.tmp/` in workspace root only; `/tmp/` prohibited
- Fact clarification: new info appended as new findings with `Clarifies:` reference; no merging until verification; clarifications applied in reverse chronological order at verification
- File boundary: pending/draft files read-only during research; all new findings go to fact files only
- Completeness gate: state coverage and gaps before synthesising any draft; wait for instruction if gaps exist

---

## Research Status: Chatmodes vs Skills

**Fact file:** `.memory/ai-devops-chatmodes-skills-facts.md` — 24 findings, all tagged `[VERIFIED on 2026-02-19]`
**Archive:** `.memory/ai-devops-chatmodes-skills-facts-archive-2026-02-19.md` — 12 rejected claims
**Ready for:** Analysis output on request (tags expire 2026-03-21; 30-day skip applies until then)

**Key verified facts:**
- Claude Code subagents: `.claude/agents/*.md` (plain `.md`; NOT `.agent.md`, NOT `.claude/modes/`)
- Copilot custom agents: `.github/agents/*.agent.md`
- Slash commands merged into skills — `.claude/commands/` and `.claude/skills/` are identical
- `.chatmode.md` files require manual rename to `.agent.md`; no backward compatibility
- Thinking phrases ("think", "ultrathink") do NOT allocate thinking tokens
- Effort level (`CLAUDE_CODE_EFFORT_LEVEL`) controls Opus 4.6 reasoning depth
- 5 permission modes only: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan`
- `version:` field not supported in Claude Code subagent frontmatter
- Copilot agents can link to `.prompt.md` files via Markdown links; Copilot includes linked content (empirical, FINDING-2026-02-19-1)

---

## Verified Technical Facts (Prior Sessions)

### #file: references do not work in agent/prompt bodies
`#file:` is a chat input variable for users to attach files interactively. It is not processed when embedded in `.agent.md` or `.prompt.md` file bodies. Use relative Markdown links instead. Confirmed against [VS Code custom agents docs](https://code.visualstudio.com/docs/copilot/customization/custom-agents) and [prompt files docs](https://code.visualstudio.com/docs/copilot/customization/prompt-files) (both accessed 2026-02-19).

### Markdown links in agent/prompt bodies ARE supported
Both `.agent.md` and `.prompt.md` bodies support Markdown links to reference other workspace files. The linked file's content is included by Copilot.

### ASCII flow diagrams in agent files serve no AI purpose
Workflow diagrams (arrows, indentation) are human-readable. An AI processes tokens sequentially and gets the same information more reliably from imperative prose or numbered lists.

### GitKraken/GitLens MCP tools require active login
Third-party git MCP tools are permitted if an authenticated login exists; must fall back to native tools (`git`, `gh`, VS Code built-in) otherwise. Confirmed by user. Documented in both `git-commits.md` and `copilot-instructions.md`.

---

## Research Status: AI Problem Resolution — Solutions History

**Fact file:** `.memory/ai-problem-resolution-solutions-history-facts.md` — 1,065 lines, verified
**Log:** `.memory/ai-problem-resolution-log.md` — current through LOG-2026-02-23-01
**Source clones:** `.tmp/spafw37/`, `.tmp/nightingale-truenas/`, `.tmp/claude-code-container/`, `.tmp/pdd-*.md`

**Catalog:** SH-001 to SH-038 complete. All five projects covered (spafw37, pdd, NT, CCC, ai-devops).

**Methodology findings — all verified `[VERIFIED on 2026-02-23 by first-party research synthesis]`:**
- FINDING-01: Empirical refinement methodology (debugging AI behaviour + querying AI interpretation)
- FINDING-02: Wording failure modes — two sub-types: AI interpretation problems (ambiguous phrasing, conflicting directives) and harness/platform problems (meta-character pre-processing by Copilot/Claude Code extensions before AI receives text). CLARIFICATION-02a merged in.
- FINDING-03: Language directives — dual purpose (annoyance removal + Overeagerness counter)
- FINDING-04: UK English replacement plan — ⚠️ NOT FOR FINAL DOCUMENT (internal planning note)
- FINDING-05: Verbose early drafts (rationale misapprehension, context budget waste)
- FINDING-06: Language deficiencies in earliest NO GUESSING POLICY
- FINDING-07: 8-revision cross-project accuracy/documentation-first policy history (R1=spafw37 886b1ba → R8=ai-devops)
- FINDING-08: Four-factor evolution framework (Rationale, Language, Specificity, Brevity) mapped to R1–R8
- FINDING-09: Meta-instructional file inventory across all five projects with provenance and catalog gaps
- FINDING-10: Three Amnesia root causes — instruction deprioritisation (truncation + positional), context flooding from monolithic files, paraphrase degradation on composition
- FINDING-11: Summary of all in-context instruction degradation factors — 11 factors across 4 categories (Availability, Budget, Framing, Scope); excludes lossy copying
- FINDING-12: `ai-targeted-language.md` is a structural compliance enabler, not a style rule. Two Counter: declarations — `Counter: Human-Targeted Documentation` and `Counter: Natural Language Variation`. Addresses FINDING-11 Framing factors 3a and 3b. Miscategorised as style/quality in SH-038 and SH-031 — correct category is compliance framing. Revised four-category taxonomy: compliance framing / rule presence and fidelity / file structure standards / documentation quality. Documentation quality serves four concurrent purposes (consistency, verification vector, AI navigation, scriptability — not human readability only). CLARIFICATION-12a and 12b merged in.

**Catalog gaps (not yet added):**
- SH-039: pdd `instructions.md` (`applyTo: src/instructions/**/*.md`) — lightweight instruction folder guide
- SH-040: pdd `prompts.md` (`applyTo: {src/prompts/**,.github/prompts/**}`) — lightweight prompt folder guide
- SH-041: NT `prompt-files.instructions.md` — full Counter:-based prompt file standard

**Key discovery (session 5):** `release/github/instructions/` in ai-devops is a staging area containing 6 meta-instructional files (instruction-files, step-files, plan-files, prompt-files evolved from NT; design-docs and design-diagrams are new with no prior equivalent). Not yet deployed to `.github/instructions/`.

**Pending:**
- Add SH-039 / SH-040 / SH-041 catalog entries for the three uncatalogued files
- Correct SH-038 and SH-031 catalog entries: `ai-targeted-language` miscategorised as style/quality; correct category is compliance framing
- Evolution analysis of meta-instructional files (FINDING-09 was identification only; lineage across projects not yet done)
- Create `consolidate-clarifications.prompt.md` — lightweight mid-session clarification merge prompt (identified gap; not yet implemented)

---

## Git Tool Policy (Current)

**Preferred:** VS Code built-in git, terminal `git`, `gh` CLI, `az repos`  
**Permitted:** Third-party MCP tools (e.g. GitKraken) only when an active, authenticated login is available  
**MUST NOT:** Use third-party tools as default when native tools are sufficient

---

## Critical Learnings (Carried Forward)

### File Type Roles
1. **Guard rails** (instruction-files.md, prompt-files.md) — use by AI not guaranteed
2. **Domain standards** (accuracy.md, communication.md, git-policy.md) — apply throughout all work
3. **Final implementation artifacts** (plan-files.md, step-files.md) — created at final stage only
4. **Design process support** (memory-files.md) — captures decisions before plans, prevents vibe coding

### Problem-Solving Gaps (Still Unresolved)
- Quality assurance (lost accuracy.instructions.md, code-review-checklist.instructions.md)
- User interaction (lost communication.instructions.md)
- Design process support (lost memory-files.instructions.md)
- Context overflow via self-contained steps (lost step-files.instructions.md)
- Full git workflow (only git-policy.md remains)

---

## Quick Reference

**Instruction files:** 13 in `.github/instructions/`  
**Prompt files:** `consolidate-session.prompt.md`, `record-operation.prompt.md`, `verify-memory-facts.prompt.md`  
**Agent:** `@analysis` — research capture and curated output with approval gate  
**Memory files:** `.memory/` directory (excluded from git via `.gitignore`)  
**Naming convention:** `[topic]-{facts|facts-disproven|index|log}.md` for all agent memory files  
**Importing from minouris repos:** Use `gh api` or `gh` CLI directly (active login confirmed)  
**Importing from other repos:** Clone to `.tmp/` (workspace root); do NOT use system `/tmp/`  
**Temporary cleanup outstanding:**
- `.tmp/spafw37/` — spafw37 clone (commits 886b1ba → b2cb0e7 examined); safe to delete when solutions-history analysis complete
- `.tmp/nightingale-truenas/` — NT clone; safe to delete when solutions-history analysis complete
- `.tmp/claude-code-container/` — CCC clone; safe to delete when solutions-history analysis complete
- `.tmp/pdd-*.md` — pdd snapshot files; safe to delete when solutions-history analysis complete
- `.memory/SESSION-2026-02-19-analysis-consolidation.md` — incorrectly created by Haiku; safe to delete

**Known agent issue (Issue 6):** Operation logging is skipped in practice — agent completes work and responds without appending the log entry. Cannot self-correct across sessions (amnesia). Mitigations proposed in `.memory/ai-problem-resolution-agent-issues-facts.md` Issue 6. User must prompt `@record-operations` or watch for omissions.
