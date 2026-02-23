# AI Problem Resolution — Solutions History: Context Poisoning Findings

**Topic:** `ai-problem-resolution` (subtopic: solutions-history / problem: context-poisoning)
**Overview file:** [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md)
**Scope:** Problem definition, mechanism, and solutions history for Context Poisoning — the compounding propagation effect driven by all four root causes

---

## Problem Definition and Root Cause

### CONTEXT POISONING (Propagation of Incorrect Facts Through Conversation Context)

**Source:** FINDING-2026-02-20-09 and CLARIFICATION-2026-02-20-04 in `ai-problem-resolution-root-causes-facts.md`

**Definition:**
Context Poisoning occurs when an incorrect fact, decision, or implementation enters the conversation context — and the AI continues to build on it as though it were correct, because the AI does not distinguish between verified correct facts and unverified or incorrect ones, and cannot retroactively edit or invalidate earlier context entries.

**Mechanism:**
1. An incorrect item enters context — this may result from any of the four root causes:
   - Hallucination introduces a fabricated fact the AI treats as verified
   - Dishonesty introduces a false claim of state (e.g., "the database was backed up") that subsequent turns build on
   - Overeagerness introduces an unwanted implementation that becomes the assumed baseline
   - Amnesia causes earlier corrections to be forgotten, leaving the original incorrect version as the active context item
2. The AI has no mechanism to mark context items as "disputed," "corrected," or "invalidated"
3. All subsequent reasoning uses the poisoned item as an input
4. Errors compound: each step built on a false premise produces further false output
5. The output may appear internally consistent while being entirely wrong

**Relationship to other root causes:**
Context Poisoning is not an independent root cause in the same sense as Hallucination, Dishonesty, Overeagerness, or Amnesia. It is a **knock-on effect** — a compounding mechanism that amplifies all four. Any of them can introduce the initial poisoned item; Context Poisoning describes what happens next.

- Hallucination → fabricates a class or method → AI builds further code that calls it → all subsequent code is poisoned
- Dishonesty → agent claims rollback is possible → user does not seek alternative recovery → window for recovery closes
- Overeagerness → implements the wrong feature → user requests corrections → AI builds corrections on the wrong foundation
- Amnesia → user corrects a mistake → correction falls out of context → AI reverts to the original wrong assumption → poisoned item reappears

**Why the AI cannot recover unaided:**
The AI processes context as a sequence of tokens. It has no internal model of which parts of that sequence are reliable and which are not. A fact stated early in a conversation has the same epistemic status as a fact stated by the user — the AI does not track provenance or confidence level per context item. This is an architectural property, not a behavioural choice.

**External evidence:**
- SWE-bench hallucination spirals — Gemini hallucinated classes → built further reasoning on hallucinated output → gave up after dozens of turns. Classic context poisoning cascade.
- Reprompt loop — each reprompt adds more context built on the same unresolved error; the poisoned foundation grows with each turn.
- Replit/Lemkin — agent fabricated 4,000 fictional records into a replacement database; the fabricated data became the new "real" state in context.

**Practical consequence:**
The longer a session runs after a poisoning event, the more expensive recovery becomes. In vibe coding, where sessions can run for hours or days without the user reviewing intermediate reasoning, poisoning events accumulate undetected. Project abandonment (11% per published research) is frequently the result of context poisoning reaching a point where no prompt can recover a coherent state.

---

### Clarification — Amnesia Chain in Context Poisoning

**Source:** CLARIFICATION-2026-02-20-04 in `ai-problem-resolution-root-causes-facts.md`

**Correction to the Amnesia chain in FINDING-2026-02-20-09:**
The original statement — "correction falls out of context" — is incorrect. The correction IS in the context; it is later in the conversational record than the original error. The AI does not consistently apply it, but not because of context window loss.

**User's observed mechanism (unverified hypothesis):**
The AI may scan its context looking for answers to problems it has previously encountered. Once it finds a matching answer — the original (incorrect) version — it may stop scanning and not continue forward to find later clarifications, corrections, or expansions of that item. The result is the same as if the correction were absent: the AI acts on the first matching item it finds, which is the poisoned one.

**Status:** Observational. Mechanism is not confirmed. Could also be explained by:
- Attention weighting: earlier tokens in a long context may receive higher attention weight than later ones in some model architectures
- Retrieval pattern: model may preferentially retrieve high-confidence early context items over lower-confidence corrections
- The correction may itself be hedged or qualified in a way that reduces its salience relative to the original confident assertion

**Revised Amnesia → Context Poisoning chain:**
Amnesia → user corrects a mistake → correction is present in context but the AI does not consistently apply it in subsequent turns → original incorrect item continues to influence output → poisoned item persists

**Note:** This means the Amnesia chain in Context Poisoning may be mislabelled. The mechanism is not technically Amnesia (context window loss) — it is something closer to **selective retrieval** or **correction blindness**. The root cause may be Overconfidence (high confidence in the original item outweighing the correction) rather than Amnesia.

---

## Solutions and Mitigations

### Relationship to the Instruction Corpus

The instruction and policy files catalogued in SH-001 through SH-038 do not explicitly target Context Poisoning. There is no rule file named for it and no policy section with Context Poisoning as its stated objective.

However, Context Poisoning is a knock-on effect of the four root causes: each poisoning event originates from Hallucination, Dishonesty, Overeagerness, or Amnesia introducing a false or uncorrected item into context. The first-wave solutions — which address those four root causes through instruction files — therefore reduce the **rate** of poisoning events as a side effect. They do not address what happens once a poisoning event has occurred, but they reduce how often one is introduced.

This makes Context Poisoning an indirect beneficiary of first-wave solutions rather than a direct target of them.

---

### FINDING-SH-M-2026-02-23-02: Second-Wave Mitigation — Memory Files and Verification Passes

**Captured:** 2026-02-23
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation — developer of all five projects)
**Domain:** Context Poisoning — relationship to solutions history; second-wave mitigation

#### Second-wave mitigation: memory files and verification passes

A second category of solutions addresses Context Poisoning more directly. Rather than preventing the introduction of false items, these solutions prevent false items from propagating into downstream artefacts such as implementation plans and task outputs.

**Mechanism:** Persistent memory files — maintained outside any single conversation session — store only facts that have been explicitly verified. A verification pass (such as `verify-memory-facts`) checks each stored item against its source before it is used. When a planning artefact is produced, it draws on the verified memory store rather than on unverified conversational context. Any item that has not passed verification is excluded.

**Effect on Context Poisoning:** Even if a poisoning event has occurred during research or analysis, the verification gate prevents the corrupted item from surviving into the memory store and thence into planning outputs. The memory file acts as a quarantine boundary: only verified facts cross it.

**Evidence in this project:** The analysis agent workflow (SH-037) and the `verify-memory-facts` prompt (SH-023, NT) are direct implementations of this pattern. The current research session operates on the same basis: facts are stored in `.memory/` files, verified with first-party source checks, and only then used to produce analysis artefacts. The `distill-memory-facts` / `verify-memory-facts` workflow is explicitly designed to ensure that summarisation and handoff outputs contain only confirmed items.

#### Relationship to first-wave vs second-wave solution architecture

| Wave | Mechanism | Context Poisoning effect |
|---|---|---|
| First wave (SH-001–SH-038) | Instruction/policy files targeting root causes | Indirect — reduces rate of poisoning events entering context |
| Second wave (SH-022, SH-023, SH-037 and successors) | Memory files + verification passes | Direct — prevents unverified items propagating into planning artefacts |

The second-wave approach does not eliminate Context Poisoning from the conversational session; poisoning can still occur within a session. It bounds the damage: only verified items survive into persistent storage and planning outputs, so implementation work starts from a verified baseline regardless of what happened mid-session.

---

### Second-Wave Solution Catalog

The following SH entries represent the second-wave solutions that directly mitigate Context Poisoning. These entries are also present in their respective root-cause sub-files (Amnesia, Hallucination).

---

#### SOLUTION-SH-022
**File:** `.github/instructions/memory-files.instructions.md` (421 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Amnesia (primary), Context Poisoning (indirect)
**Notes:** Defines a structured persistent memory system for AI agents. Specifies file types with required formats. Mandates `.memory/` directory. Separates facts (static reference) from logs (execution history). All memory files excluded from git. First comprehensive Amnesia solution — provides structured external memory to persist context across sessions. Memory store functions as a quarantine boundary: only explicitly recorded facts survive session boundaries.

---

#### SOLUTION-SH-023
**File:** `.github/prompts/distill-memory-facts.prompt.md` (500 lines)
**Branch:** main
**Date:** Jan 2026
**Problems addressed:** Amnesia, Hallucination (primary), Context Poisoning (indirect)
**Notes:** Prompt that verifies all facts in a memory file against authoritative sources, archives outdated or inaccurate information, and refreshes citations. The verification pass is the direct counter to Context Poisoning: it prevents unverified items from surviving into persistent storage. Precursor to the `verify-memory-facts` prompt in ai-devops.

---

#### SOLUTION-SH-037
**File:** `src/base/agents/analysis.agent.md` (452 lines)
**Branch:** main
**Date:** Feb 2026
**Problems addressed:** Overeagerness, Amnesia (primary), Context Poisoning (indirect)
**Notes:** Research/Analysis agent definition. Institutionalises fact files as structured persistent memory with mandatory verification passes before output creation. The staged research → verify → output workflow is a direct implementation of the second-wave Context Poisoning mitigation pattern: poisoned facts can enter the session context, but the verification gate at the output stage prevents them from propagating into final analysis artefacts.
