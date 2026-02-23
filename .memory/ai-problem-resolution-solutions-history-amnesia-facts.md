# AI Problem Resolution — Solutions History: Amnesia Findings

**Topic:** `ai-problem-resolution` (subtopic: solutions-history / problem: amnesia)
**Overview file:** [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md)
**Scope:** Methodology findings about instruction degradation, context window behaviour, and rule fidelity as they address Amnesia

---

## Problem Definition and Root Cause

### AMNESIA (Context Loss & Forgotten Requirements)

**Source:** `general.instructions.md` - "Mandatory Source Citation for External Knowledge" and "Mandatory Full Log Review for CI/CD Failures" sections; FINDING-SH-M-2026-02-22-10

**CRITICAL DISTINCTION:** Amnesia is fundamentally different from Hallucination, Dishonesty, and Overeagerness in its primary cause.

- **Hallucination, Dishonesty, Overeagerness:** Behavioural problems caused by training optimisation for "helpfulness"
- **Amnesia:** Primarily a technical limitation — context window size, token limits — but research has identified two additional causes that extend beyond the purely architectural characterisation

**Amnesia causes — three distinct mechanisms (FINDING-SH-M-2026-02-22-10):**

**Cause 1 — Context window truncation (architectural)**
When the context window (token limit) is reached, earlier information is no longer available to the system. This is not poor performance or misbehaviour; it is the system working as designed within its technical constraints. This is the cause originally documented here, and it remains correct — but it is not the only cause.

**Cause 2 — Positional deprioritisation (attention weighting)**
Even when instructions are present within the context window, instructions loaded at the start of a session occupy earlier token positions. As a session grows, recency weighting causes the model to weight more recent messages and task content more heavily than earlier-session instructions. The instruction is available but its influence is attenuated. This is distinct from truncation: the instruction is not missing, it is underweighted. This cause is partially addressable by policy (per-task embedding, Counter: declarations at the point of use) — unlike pure truncation, which requires structural or architectural solutions.

**Cause 3 — Paraphrase degradation on composition (file authoring)**
When instructed to compose a prompt or instruction file by drawing on rules from other files, the AI does not copy source text verbatim. It paraphrases or summarises. Each composition pass removes precision from the constraint text: mandatory language is softened to advisory, specific constraints are generalised, worked examples are omitted. The result is that rules degrade in force through the composition process itself — a form of amnesia that occurs at authoring time rather than at runtime. This cause is addressable by the Rule Copying mandate (SH-028, SH-035).

**Implication for the "purely architectural" characterisation:**
Cause 1 is purely architectural — no instruction can fix context window truncation. Causes 2 and 3 are partially or fully addressable by policy. The original framing that "policies cannot fix Amnesia" is accurate for Cause 1 but incorrect for Causes 2 and 3. Solutions in the instruction file corpus (per-task rule embedding, rule-copying mandates, Counter: declarations) directly address Causes 2 and 3.

**Manifestations in identified problems:**
- [PROBLEM-2026-02-19-02](ai-problem-resolution-problems-facts.md): Large context loads force earlier information out; operational failures cascade
- [PROBLEM-2026-02-19-05](ai-problem-resolution-problems-facts.md) (Category 2): Monolithic 4000+ line plans; forgotten test constraints, field requirements across sections

**Evidence from archived instructions:**

Two policies address context loss and forgotten information:

1. **Forgotten specifications:** The "Source Citation" requirement was needed because the AI was:
   - Answering based on general knowledge of APIs without checking current documentation
   - Forgetting that specifications change between versions
   - Making outdated assumptions about how tools work

2. **Forgotten context in error diagnosis:** The "Mandatory Full Log Review" policy addresses amnesia in a different form. The AI was:
   - Focusing on the final error message without seeing what caused it
   - Missing context that would have revealed the root cause
   - Pattern-matching to familiar error types rather than understanding the actual flow

---

## Solutions Catalog

The following entries from the instruction/rule corpus address Amnesia as a primary or contributing concern. Entries that also address other problems are included here in full; those problems are also covered in their own sub-files.

---

### SOLUTION-SH-013
**File:** `.github/instructions/instruction-composition.instructions.md` (45 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** **Amnesia**
**Notes:** Establishes verbatim embedding rule — rule content must be embedded in full, not referenced by link. Rationale: passive context inclusion means link-only won't work (AI won't follow a link to retrieve rules). First explicit attempt to address Amnesia by ensuring rules are present in context window, not merely referenced.

---

### SOLUTION-SH-014
**File:** `.github/instructions/prompt-composition.instructions.md` (97 lines)
**Branch:** main
**Date:** Dec 2025
**Problems addressed:** **Amnesia**
**Notes:** Governs prompt structure. Uses explicit load instructions with recursive wording ("Read the file ... and follow all instructions within it"). Prohibits link-only references. Evolved from insight in SOLUTION-SH-013 — extends the verbatim/explicit-load principle to prompt files and recursive loading chains.

---

### SOLUTION-SH-022
**File:** `.github/instructions/memory-files.instructions.md` (421 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** **Amnesia**
**Notes:** Defines a structured persistent memory system for AI agents. Specifies file types (SERVICE_INFO, CREDENTIALS, DECISIONS, ISSUES, PLAN_N_PROGRESS, SESSION_NOTES, ASSUMPTION_LOG) with required formats. Mandates `.memory/` directory. Separates facts (static reference) from logs (execution history). All memory files excluded from git. First comprehensive Amnesia solution in this corpus — provides structured external memory to persist context across sessions. Evolved from the informal memory-keeping patterns of earlier projects.

---

### SOLUTION-SH-023
**File:** `.github/prompts/distill-memory-facts.prompt.md` (500 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** **Amnesia**, Hallucination
**Notes:** Prompt that verifies all facts in a memory file against authoritative sources, archives outdated or inaccurate information, and refreshes citations. Addresses Amnesia by maintaining memory integrity (stale facts are removed rather than persisting indefinitely). Addresses Hallucination by requiring source verification before accepting any fact. Precursor to the `verify-memory-facts` prompt in ai-devops.

---

### SOLUTION-SH-028
**File:** `.devcontainer/.claude/rules/rule-copying.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Mandates verbatim copying of rules when including them in other files. Prohibits condensing or abbreviating. Evolved from SOLUTION-SH-013 (instruction-composition) — same principle, now a dedicated Claude Code rule.

---

### SOLUTION-SH-029
**File:** `.devcontainer/.claude/rules/rule-embedding.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Companion to SOLUTION-SH-028. Governs how rules are embedded into agent/prompt files. Evolved from SOLUTION-SH-013 and SOLUTION-SH-014 (pdd instruction and prompt composition). Establishes the principle that embedded rules must be fully present, not linked.

---

### SOLUTION-SH-035
**File:** `.github/instructions/rule-copying.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Copilot instruction port of SOLUTION-SH-028. Verbatim rule copying mandate.

---

### SOLUTION-SH-036
**File:** `.github/instructions/rule-embedding.md`
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** **Amnesia**
**Notes:** Copilot instruction port of SOLUTION-SH-029. Verbatim rule embedding mandate.

---

### SOLUTION-SH-037
**File:** `src/base/agents/analysis.agent.md` (452 lines)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Overeagerness, **Amnesia**
**Notes:** Research/Analysis agent definition. Embeds documentation-first and documentation-standards rules verbatim. Defines two research workflows (procedural and analytical) with structured capturing into `.memory/` fact files before any output is created. Addresses Overeagerness by enforcing staged research workflow with explicit gate before creating output. Addresses Amnesia by institutionalising fact files as structured persistent memory — evolved from SOLUTION-SH-022 (nightingale memory-files) into a full agent workflow.

---

## Development Methodology Findings

### FINDING-SH-M-2026-02-22-10
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation — developer of all five projects)
**Domain:** Amnesia root causes — instruction deprioritisation, context flooding, and paraphrase degradation

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

The three discoveries are distinct in cause but converge on the same observable symptom: instruction non-compliance. Discovery 1 is a context management problem; Discovery 2 is a context efficiency problem; Discovery 3 is a language fidelity problem.

---

### FINDING-SH-M-2026-02-22-11
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** Synthesised from FINDING-SH-M-2026-02-22-05, 06, 08, 10 (user direct observation — developer of all five projects)
**Domain:** Summary — factors causing instruction performance degradation within a context

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
| Scope too tight post-redesign | Redesign side-effect | NT R6 (FINDING-07 R8) | "What Counts as Documentation" (R8) |
