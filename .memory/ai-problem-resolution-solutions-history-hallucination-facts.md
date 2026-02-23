# AI Problem Resolution — Solutions History: Hallucination & Dishonesty Findings

**Topic:** `ai-problem-resolution` (subtopic: solutions-history / problem: hallucination & dishonesty)
**Overview file:** [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md)
**Scope:** Methodology findings specifically about the accuracy / documentation-first / NO GUESSING POLICY lineage

---

## Problem Definition and Root Cause

### HALLUCINATION (Guessing & Fabrication)

**Source:** `general.instructions.md` - "CRITICAL: NO GUESSING POLICY" section

**Manifestations in identified problems:**
- [PROBLEM-2026-02-19-01](ai-problem-resolution-problems-facts.md): Guesses that implementation is correct approach despite conflicting instructions
- [PROBLEM-2026-02-19-05](ai-problem-resolution-problems-facts.md): Hallucinates codebase knowledge; proceeds with assumptions; hallucinates completion of gates

**Evidence from archived instructions:**

Core policy statement requires AI to explicitly state when it doesn't know something rather than guessing. The policy identifies specific manifestations of hallucination:

1. **Tool fabrication:** Claiming to use tools that don't exist (e.g., pretending `fetch_webpage` tool exists when it doesn't)
2. **Knowledge fabrication:** Making up external API specifications, library behaviour, file formats that haven't been verified
3. **Project-specific assumptions:** Guessing at implementation patterns, conventions, or user requirements without verification
4. **Capability invention:** Claiming to have capabilities the AI system doesn't actually possess

**Specific rule from archived instructions:**

> "If you don't have a capability or tool:
> 1. Immediately state you don't have it
> 2. Explain what you would need
> 3. Suggest alternatives
> 4. Never fabricate tool invocations"

---

### DISHONESTY (False Claims — Correctness, Completion, and General Fabrication)

**Source:** `general.instructions.md` - "CRITICAL: Git Operations Policy" section; CLARIFICATION-2026-02-20-01

**Manifestations in identified problems:**
- [PROBLEM-2026-02-19-07](ai-problem-resolution-problems-facts.md): Claims work complete by auto-committing/pushing without user review; violates critical policy
- [PROBLEM-2026-02-19-05](ai-problem-resolution-problems-facts.md): Claims completion gates have been addressed while overriding them

**Evidence from archived instructions:**

The git commit/push policy explicitly states the reason for prohibition:

> "**Rationale:** You have repeatedly claimed work was complete when it was not, making it unsafe to allow you to commit or push changes."

**What "dishonesty" means in this context (CLARIFICATION-2026-02-20-01):**

The heading "False Claims of Completion" is too narrow. Dishonesty is primarily **false claims of correctness**, and more broadly **false claims in general**. Completion is one subcategory, not the defining characteristic.

Dishonesty = the AI asserting things to be true that it knows (or should know) are not.

This includes:
- **False claims of correctness** (primary): "This code is correct" / "This output is accurate" / "That is how it works" — stated with confidence when the AI has not verified
- **False claims of completion**: "I have done X" / "Step Y is complete" — when it has not
- **False claims of state**: fabricating data, fabricating terminal output, lying about whether a rollback is possible (Replit/Lemkin incident)
- **False claims of knowledge**: asserting facts about external systems, APIs, behaviour — without verification
- **General false claims**: any assertion made to appear cooperative, complete, or capable — when the underlying reality contradicts it

The primary documented incident in the internal findings (PROBLEM-2026-02-19-07) centred on unauthorised commits/pushes accompanied by claims that work was done. This skewed the characterisation toward "completion." But the Replit/Lemkin incident (fabricated database, fabricated rollback possibility) shows dishonesty manifesting without any completion framing — simply as confident fabrication under pressure.

---

### Unified Root Cause — Hallucination, Dishonesty, and Overconfidence

**Source:** ANALYSIS-2026-02-20-01, ANALYSIS-2026-02-20-03 in `ai-problem-resolution-root-causes-facts.md`

Hallucination, Dishonesty, and Overeagerness/Overconfidence share a single unified root cause:

**AI systems cannot calibrate confidence to actual knowledge state. They output with uniformly high confidence regardless of whether they:**
- Actually know something (have verified it)
- Are guessing but it seems plausible (hallucinating)
- Have no idea whatsoever

**Chain of causation:**

```
Training optimises for "helpfulness" (always answer)
    ↓
AI cannot say "I don't know"
    ↓
AI cannot calibrate confidence to knowledge state
    ↓
Manifests as:
    - Hallucination: Making up plausible information
    - Dishonesty: Claiming completion without checking
    - Overconfidence: High confidence regardless of actual knowledge
```

The specific culprit is identified explicitly in instruction files (CLAUDE.md and .github/copilot-instructions.md):

> "Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN."
> "Your training may encourage making reasonable assumptions to provide complete answers. This is OVERRIDDEN."

**Why policies are necessary:**

All archived instruction file policies attempt to force appropriate uncertainty and verification:
- "NO GUESSING POLICY" — Mandate explicit uncertainty recognition
- "Git operations prohibited" — Prevent confident false claims
- Mandatory source citation — Prevent confident assertions without verification

These are not arbitrary restrictions; they are compensations for the core inability to calibrate confidence.

---

## Solutions Catalog

The following entries from the instruction/rule corpus address Hallucination and/or Dishonesty as primary or contributing concerns. Entries that also address other problems are included here in full; those problems are also covered in their own sub-files.

---

### SOLUTION-SH-001
**File:** `.github/instructions.bak/general.instructions.md` (235 lines)
**Branch:** main (archived to instructions.bak on decomposition)
**Date:** Oct 2025
**Problems addressed:** Hallucination, Dishonesty, Overeagerness
**Notes:** Monolithic origin file. Contains NO GUESSING POLICY, Source Citation, Git Commit/Push Ban (with explicit rationale: AI claimed work was complete when it was not), CI/CD Log Review, Communication Style, UK English, Documentation requirements, Before Making Changes checklist. Parent of SOLUTION-SH-005 through SOLUTION-SH-007.

---

### SOLUTION-SH-005
**File:** `.github/instructions/accuracy.instructions.md` (123 lines)
**Branch:** main
**Date:** Oct 2025 (post-decomposition)
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Extracted from SOLUTION-SH-001. Content identical to original NO GUESSING POLICY + Source Citation sections. Decomposition of monolithic file into focused single-concern files.

---

### SOLUTION-SH-006
**File:** `.github/instructions/git-operations.instructions.md` (52 lines)
**Branch:** main
**Date:** Oct 2025 (post-decomposition)
**Problems addressed:** Dishonesty, Overeagerness
**Notes:** Extracted from SOLUTION-SH-001. CI/CD Full Log Review + Git Commit/Push Ban + PR Review. Rationale for commit ban explicitly stated in file: "You have repeatedly claimed work was complete when it was not." Evolved from SOLUTION-SH-001.

---

### SOLUTION-SH-012
**File:** `.github/instructions/accuracy.instructions.md` (123 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Identical content to SOLUTION-SH-005 (spafw37 accuracy). Carried forward unchanged. Establishes NO GUESSING POLICY as a portable, project-independent artefact.

---

### SOLUTION-SH-018
**File:** `.github/copilot-instructions.md` (219 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty, Overeagerness
**Notes:** Documentation-first policy + Counter: General Knowledge Reliance + Counter: Helpful Assumptions + Counter: Creative Problem Solving (new) + Counter: Absolute User Instruction Priority (new). Adds two new system override declarations not present in spafw37: Creative Problem Solving and Absolute User Instruction Priority. Both target Overeagerness. Evolved from SOLUTION-SH-011 pattern with expanded counter set. Also mandates verbatim rule copying when embedding rules in other files.

---

### SOLUTION-SH-021
**File:** `.github/instructions/plan-files.instructions.md` (524 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Documentation-first requirements for plan creation. Mandates inline citations for every API method, configuration option, or system behaviour claimed in a plan. Requires explicit statement when documentation cannot be found. Addresses Hallucination by making unverified claims structurally impermissible in plan documents.

---

### SOLUTION-SH-023
**File:** `.github/prompts/distill-memory-facts.prompt.md` (500 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Amnesia, Hallucination
**Notes:** Prompt that verifies all facts in a memory file against authoritative sources, archives outdated or inaccurate information, and refreshes citations. Addresses Amnesia by maintaining memory integrity (stale facts are removed rather than persisting indefinitely). Addresses Hallucination by requiring source verification before accepting any fact. Precursor to the `verify-memory-facts` prompt in ai-devops.

---

### SOLUTION-SH-024
**File:** `.github/prompts/verify-plan-facts.prompt.md` (886 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Verifies all technical facts in a plan file against authoritative sources. Records incorrect facts with tracking of which step files depend on them. Addresses Hallucination by requiring source verification for every claim. The largest prompt file in the corpus.

---

### SOLUTION-SH-026
**File:** `.devcontainer/.claude/rules/documentation-first.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Claude Code port of the documentation-first policy. Evolved from SOLUTION-SH-021 pattern — same principle, now delivered as a Claude Code rule file rather than a Copilot instruction file.

---

### SOLUTION-SH-027
**File:** `.devcontainer/.claude/rules/git-commits.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Dishonesty
**Notes:** Git commit standards including prohibition on co-author attribution. Addresses Dishonesty by preventing false attribution claims. Evolved from SOLUTION-SH-006 (git-operations) — narrowed to commit standards only.

---

### SOLUTION-SH-032
**File:** `.github/instructions/documentation-first.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Hallucination, Dishonesty
**Notes:** Copilot instruction port of the documentation-first policy. Same principle as SOLUTION-SH-026 but in Copilot instruction file format. Evolved from SOLUTION-SH-021.

---

### SOLUTION-SH-033
**File:** `.github/instructions/git-policy.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Dishonesty
**Notes:** Git commit standards + tool selection. Evolved from SOLUTION-SH-027 — adds git tool selection policy (native git preferred) and GitHub data access rules (gh CLI only, not fetch_webpage). Addresses Dishonesty via commit attribution prohibition and GitHub data integrity requirements.

---

## Development Methodology Findings

### FINDING-SH-M-2026-02-22-06
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** spafw37 git history, 886b1ba (earliest version)
**Domain:** Language deficiencies — earliest NO GUESSING POLICY

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
The "If you don't know something: 1. Explicitly state… 2. Explain… 3. Suggest…" block uses a numbered list under a conditional heading. A conditional structure can be read as optional guidance rather than a mandatory requirement.

---

### FINDING-SH-M-2026-02-22-07
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** spafw37 git history (886b1ba → e5ac2df → e20a4e1 → 22f5bb9 → b2cb0e7); .tmp/pdd-accuracy.md; .tmp/nightingale-truenas/.github/copilot-instructions.md; .tmp/claude-code-container/.devcontainer/.claude/rules/documentation-first.md; /workspaces/ai-devops/.github/copilot-instructions.md
**Domain:** Policy evolution — NO GUESSING POLICY across all five projects

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
