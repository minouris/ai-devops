# AI Problem Resolution — Solutions History: Amnesia Findings

**Topic:** `ai-problem-resolution` (subtopic: solutions-history / problem: amnesia)
**Overview file:** [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md)
**Scope:** Methodology findings about instruction degradation, context window behaviour, and rule fidelity as they address Amnesia

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
