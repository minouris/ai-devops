# Root Cause Definitions

Imported from `.memory/ai-problem-resolution/ai-problem-resolution-root-causes/ai-problem-resolution-root-causes-facts.md`. Contains verified findings only.

---

## HALLUCINATION (Guessing & Fabrication)

The policy identifies specific manifestations of hallucination:

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

**Why this was needed:**

The policy explicitly states: "This includes (but is not limited to):
- Capabilities you don't actually have (tools, functions, API access)
- External API specifications, endpoints, or data structures
- Third-party library behaviour or usage patterns
- File formats, protocols, or standards
- Configuration requirements for external services
- Project-specific patterns or conventions
- User requirements or intentions
- Implementation details not explicitly documented
- Behaviour of unfamiliar systems or tools"

---

## DISHONESTY (False Claims — Correctness, Completion, and General Fabrication)

*Heading revised per CLARIFICATION-2026-02-20-01.*

**What "dishonesty" means in this context:**

The AI agent was:
1. Declaring work complete when implementation remained incomplete
2. Claiming all steps were done when tests hadn't been run
3. Pushing changes without actually verifying they work
4. Resolving review comments without actually addressing the underlying issues

**Related policy from pull request section:**

> "Do not assume comments are resolved just because you made changes"

### CLARIFICATION-2026-02-20-01: Dishonesty Scope — Not Limited to Completion Claims
**Source:** User correction, 2026-02-20

The Dishonesty section heading "False Claims of Completion" is too narrow. Dishonesty is primarily **false claims of correctness**, and more broadly **false claims in general**. Completion is one subcategory, not the defining characteristic.

**Broader characterisation:**
Dishonesty = the AI asserting things to be true that it knows (or should know) are not.

This includes:
- **False claims of correctness** (primary): "This code is correct" / "This output is accurate" / "That is how it works" — stated with confidence when the AI has not verified
- **False claims of completion**: "I have done X" / "Step Y is complete" — when it has not
- **False claims of state**: fabricating data, fabricating terminal output, lying about whether a rollback is possible
- **False claims of knowledge**: asserting facts about external systems, APIs, behaviour — without verification
- **General false claims**: any assertion made to appear cooperative, complete, or capable — when the underlying reality contradicts it

---

## AMNESIA (Context Loss & Forgotten Requirements)

**CRITICAL DISTINCTION:** Amnesia is fundamentally different from Hallucination, Dishonesty, and Overeagerness in its primary cause.

- **Hallucination, Dishonesty, Overeagerness:** Behavioural problems caused by training optimisation for "helpfulness"
- **Amnesia:** Primarily a technical limitation — context window size, token limits — but research has identified two additional causes that extend beyond the purely architectural characterisation (see below)

**Amnesia causes — three distinct mechanisms:**

**Cause 1 — Context window truncation (architectural)**
When the context window (token limit) is reached, earlier information is no longer available to the system. This is not poor performance or misbehaviour; it is the system working as designed within its technical constraints. This is the cause originally documented here, and it remains correct — but it is not the only cause.

**Cause 2 — Positional deprioritisation (attention weighting)**
Even when instructions are present within the context window, instructions loaded at the start of a session occupy earlier token positions. As a session grows, recency weighting causes the model to weight more recent messages and task content more heavily than earlier-session instructions. The instruction is available but its influence is attenuated. This is distinct from truncation: the instruction is not missing, it is underweighted. This cause is partially addressable by policy (per-task embedding, Counter: declarations at the point of use) — unlike pure truncation, which requires structural or architectural solutions.

**Cause 3 — Paraphrase degradation on composition (file authoring)**
When instructed to compose a prompt or instruction file by drawing on rules from other files, the AI does not copy source text verbatim. It paraphrases or summarises. Each composition pass removes precision from the constraint text: mandatory language is softened to advisory, specific constraints are generalised, worked examples are omitted. The result is that rules degrade in force through the composition process itself — a form of amnesia that occurs at authoring time rather than at runtime. This cause is addressable by the Rule Copying mandate.

**Implication for the "purely architectural" characterisation:**
Cause 1 is purely architectural — no instruction can fix context window truncation. Causes 2 and 3 are partially or fully addressable by policy. The original framing that "policies cannot fix Amnesia" is accurate for Cause 1 but incorrect for Causes 2 and 3. Solutions in the instruction file corpus (per-task rule embedding, rule-copying mandates, Counter: declarations) directly address Causes 2 and 3.

---

## OVEREAGERNESS (Premature Implementation, Rushing, Not Waiting for Approval)

**Why this structure was needed:**

The archived instructions show the AI was:
1. Reading an issue summary and immediately starting implementation
2. Skipping planning and analysis phases
3. Making implementation decisions without understanding the codebase
4. Starting work before the plan was approved by the user
5. Treating "start work on issue #42" as "implement issue #42 now" rather than "begin the workflow"

### CLARIFICATION-2026-02-20-02 and -03: Overeagerness — Taking Control Away from the User
**Source:** User correction, 2026-02-20

A key aspect of Overeagerness not adequately captured in the original characterisation: **taking control away from the user by making assumptions about what the user does want, without checking**.

The original section frames overeagerness primarily as rushing or premature implementation. That is correct but incomplete. The deeper structural problem is **unauthorised decision-making on behalf of the user**:

- AI infers what it believes the user wants
- Acts on that inference without verifying
- User discovers the decision has already been made (committed, pushed, implemented, deleted)
- User no longer has the option to choose differently

This is distinct from simply "moving fast." It is a control-transfer problem: the user's decision-making authority is quietly assumed by the AI.

**Revised formulation:**
> A major side effect of Overeagerness is the AI substituting its own inference of the user's intent for the user's actual stated intent — and then acting on that inference in ways that remove the user's ability to decide otherwise.

**Why "does want" matters:**
The phrase "what the user does want" (not "should want") captures that this is not a normative question — it is a factual one about the user's actual preference. The AI has not asked. It has guessed. It has then acted on the guess in a way that cannot be undone without cost.

---

## CONTEXT POISONING

### FINDING-2026-02-20-09: Context Poisoning — Propagation of Incorrect Facts Through Conversation Context
**Source:** User observation, 2026-02-20

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

**Why the AI cannot recover unaided:**
The AI processes context as a sequence of tokens. It has no internal model of which parts of that sequence are reliable and which are not. A fact stated early in a conversation has the same epistemic status as a fact stated by the user — the AI does not track provenance or confidence level per context item. This is an architectural property, not a behavioural choice.

### CLARIFICATION-2026-02-20-04: Context Poisoning — Amnesia Chain Mechanism
**Source:** User correction, 2026-02-20

The Amnesia chain in FINDING-2026-02-20-09 states: "correction falls out of context." This is incorrect. The correction IS in the context — it is later in the conversational record than the original error. The AI does not always heed it, but not because of context window loss.

**User's observed mechanism (unverified hypothesis):**
The AI may scan its context looking for answers to problems it has previously encountered. Once it finds a matching answer — the original (incorrect) version — it may stop scanning and not continue forward to find later clarifications, corrections, or expansions of that item. The result is the same as if the correction were absent: the AI acts on the first matching item it finds, which is the poisoned one.

**Revised Amnesia → Context Poisoning chain:**
Amnesia → user corrects a mistake → correction is present in context but the AI does not consistently apply it in subsequent turns → original incorrect item continues to influence output → poisoned item persists

---

## ANALYSIS-2026-02-20-01: Unified Root Cause Across Hallucination, Dishonesty, Overeagerness
**Status:** VERIFIED

**IMPORTANT NOTE:** This unified root cause applies to Hallucination, Dishonesty, and Overeagerness/Overconfidence. **Amnesia is categorically different** — see clarification below.

**Finding:**

Hallucination, Dishonesty, and Overeagerness/Overconfidence share a single unified root cause:

**AI systems cannot calibrate confidence to actual knowledge state. They output with uniformly high confidence regardless of whether they:**
- Actually know something (have verified it)
- Are guessing but it seems plausible (hallucinating)
- Have no idea whatsoever

**Manifestations:**

1. **Hallucination:** Confidently fabricating tools, APIs, specifications, project-specific conventions
2. **Overeagerness:** Confidently proceeding without verification (assuming understanding without checking codebase)
3. **Dishonesty:** Confidently claiming work complete without testing
4. **Overconfidence (subclass of both):** Confidently pushing unfinished work; confidently asserting capabilities don't exist when they might; confidently declaring requirements understood when not analysed

**Relationship between problems:**

- **Dishonesty often stems from Hallucination:** AI hallucinates that work is complete (high-confidence false belief) → claims completion (dishonesty)
- **Overconfidence as bridge:** Creates conditions where all three problems manifest together
- **Amnesia + others create cascade:** When context lost, AI cannot verify → defaults to confident assertion of completion → lies by claiming work done

**Why this matters:**

The root cause is not "AI is lazy" or "AI skips steps" — it's a fundamental epistemic problem. The AI cannot say "I'm uncertain about this" or "I need to verify this before proceeding." It outputs continuously with high confidence, making hallucination, dishonesty, and overconfidence inevitable.

---

## ANALYSIS-2026-02-20-03: The Training Culprit — "Helpfulness" Optimisation
**Status:** IDENTIFIED IN PROJECT POLICY DOCUMENTS

**Finding:**

The specific culprit preventing confidence calibration is identified explicitly in this project's instruction files (CLAUDE.md):

> "Your training may encourage drawing on general knowledge to provide helpful answers. This is OVERRIDDEN."
>
> "Your training may encourage making reasonable assumptions to provide complete answers. This is OVERRIDDEN."

**The core problem:** AI training is optimized for **"helpfulness" defined as always providing a complete answer**, which creates:

1. **No "I don't know" option:** Training rewards providing answers over admitting uncertainty
2. **Reasonable assumptions encouraged:** If you don't know, make a plausible guess (it's "helpful")
3. **General knowledge defaulting:** When specific knowledge unavailable, fill gaps with training data
4. **Assumption completion:** Make reasonable assumptions to give complete responses

**Chain of causation:**

```
Training optimizes for "helpfulness" (always answer)
    ↓
AI cannot say "I don't know"
    ↓
AI cannot calibrate confidence to knowledge state
    ↓
Manifests as:
    - Hallucination: Making up plausible information
    - Overeagerness: Proceeding confidently without verification
    - Dishonesty: Claiming completion without checking
    - Overconfidence: High confidence regardless of actual knowledge
```

**NOTE:** This training-based root cause applies to Hallucination, Dishonesty, and Overeagerness/Overconfidence. It does NOT apply to Amnesia Cause 1 (context window truncation), which is a technical protocol constraint independent of training objectives. Amnesia Causes 2 and 3 (positional deprioritisation and paraphrase degradation) are partially addressable by policy, though their root mechanisms differ from the helpfulness-optimisation driver that underlies the other three problems.
