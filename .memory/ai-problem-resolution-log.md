# ai-problem-resolution — Operation Log

---

### 2026-02-19 (session) — Research

**Files changed:**
- `.memory/ai-problem-resolution-problems-facts.md` — 7 AI management problems captured with root cause cross-refs
- `.memory/ai-problem-resolution-problems-facts-disproven.md` — 5 problems archived (project-specific or framework concerns)
- `.memory/ai-problem-resolution-index.md` — index of research fact files

**Findings / decisions:**
- 20+ issues analysed across 5 source projects (spafw37, prompt-driven-development, nightingale-truenas, claude-code-container, simbox)
- spafw37: Issues #81, #93, #95–97 examined; commits and `.github/instructions.bak/` archived files examined
- prompt-driven-development: PRs #36–37; issues #44, #46, #69–70, #75 and 12+ total examined
- nightingale-truenas, claude-code-container, simbox: no AI management issues identified
- 7 core problems retained; 5 archived (project-specific/framework implementation details)

**Archived problems:**
- Missing Standardization for Modes/Prompts/Policies
- AISP Compiled Prompt Security Vulnerabilities
- Registry System Inadequacy
- Metaprompt Framework vs. Task-Specific Frameworks
- Agent Detection Mechanism Lacks Specificity

---

### 2026-02-19 (session) — Root cause analysis

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — 4 root causes + unified root cause + training culprit

**Findings / decisions:**
- 4 root causes identified: Hallucination, Amnesia, Overeagerness, Dishonesty
- Unified root cause (Hallucination/Dishonesty/Overeagerness): training optimised for "helpfulness" → AI cannot express genuine uncertainty → confident output regardless of knowledge state
- Amnesia categorically different: protocol/technical constraint (context window size), NOT a training issue; requires architectural solutions
- Overconfidence: subclass of both Dishonesty and Overeagerness; AI hallucinates completion then claims completion
- All "MUST NOT guess/assume" instruction policies compensate for the "be helpful by always answering" training objective

---

### 2026-02-19 (session) — Output draft

**Files changed:**
- `.memory/ai-problem-resolution-PENDING.md` — Executive summary draft

**Findings / decisions:**
- Draft created before solutions history was fully researched — gap noted
- Draft references attempted solutions failing; spafw37 issues #93, #96 document solution history (monolithic plans → capacity problems) but not yet examined in depth

**Next:** User approval required before publishing

---

### 2026-02-20 — Research (agent execution issues)

**Files changed:**
- `.memory/ai-problem-resolution-agent-issues-facts.md` — 5 execution issues identified and resolved

**Findings / decisions:**
- Issue 1: Keyword search insufficient for policy/rationale discovery → fixed by two-stage text search policy
- Issue 2: GitHub web page fetching fails for private repos → fixed by GitHub Data Access policy (gh CLI mandatory)
- Issue 3: Wrong temp directory used (`/tmp/` instead of `.tmp/`) → fixed; contradiction in `copilot-instructions.md` also corrected
- Issue 4: Draft output file edited during research phase → fixed by explicit file boundary rule
- Issue 5: Draft created before research was complete → fixed by Research Completeness Gate

**Commands:**
- `git commit 63d8c15` — /tmp/ → .tmp/ fix across 4 policy files
- `git commit 64ea0ef` — GitHub Data Access policy added to 5 files + embedded in agent
- `git commit be834cd` — two-stage text search added to 5 documentation-first files
- `git commit eace790` — file boundary rule + completeness gate added to agent

---

### 2026-02-20 — Policy fix (agent enhancement)

**Files changed:**
- `.github/agents/analysis.agent.md` — multiple enhancements
- `.github/prompts/record-operation.prompt.md` — new file
- `.github/copilot-instructions.md` — GitHub Data Access, two-stage search, .tmp/ fix
- `.github/instructions/documentation-first.md` — two-stage search
- `.github/instructions/git-policy.md` — GitHub Data Access, .tmp/ fix

**Findings / decisions:**
- `copilot-instructions.md` `## Importing Artifacts` directed `/tmp/` while `## Temporary File Operations` prohibited it — contradiction fixed
- AI-targeted language: 3 violations fixed (passive "it must", duplicate section, US spelling)
- Fact clarification policy added: append clarifications as new findings with `Clarifies:` ref; merge only at verification in reverse chronological order
- Operation logging added: `record-operation` called after each significant operation
- Session initialisation added: agent prompts for topic slug on first load, reads log to restore context
- Topic-based file naming standardised throughout agent: all `[PROJECT]-[domain]` replaced with `[topic]` / `[topic]-[subtopic]`

**Commands:**
- `git commit 945ce8b` — AI-targeted language compliance
- `git commit 7e8ecd1` — fact clarification recording policy
- `git commit 375dd8a` — record-operation.prompt.md created
- `git commit e5d14aa` — prompt syntax compliance fixed
- `git commit caa92a2` — session initialisation added
- `git commit ae3d4b9` — ${input:topic} syntax fixed in agent
- `git commit 89788cb` — topic-based file naming throughout agent

---

### 2026-02-20 — File rename

**Files changed:**
- `.memory/ai-problem-resolution-*` — all 6 research files renamed to topic prefix

**Findings / decisions:**
- Old names: `ai-devops-ai-problems-facts.md`, `ai-devops-ai-root-causes-facts.md`, `ai-devops-ai-problems-facts-archive.md`, `ai-devops-analysis-index.md`, `analysis-agent-execution-log.md`, `ai-problems-analysis-PENDING.md`
- New names: `ai-problem-resolution-problems-facts.md`, `ai-problem-resolution-root-causes-facts.md`, `ai-problem-resolution-problems-facts-disproven.md`, `ai-problem-resolution-index.md`, `ai-problem-resolution-agent-issues-facts.md`, `ai-problem-resolution-PENDING.md`
- Subtopic file naming support added to agent (commit 227e973)

**Next:** User approval of `.memory/ai-problem-resolution-PENDING.md` before publishing executive summary

---

### 2026-02-20 14:00 — Output draft

**Files changed:**
- `.memory/vibe-coding-pitfalls-PENDING.md` — draft "Pitfalls of Vibe Coding" guide created from internal research facts

**Findings / decisions:**
- Draft structured around 4 root causes + 7 operational pitfalls + "why guardrails are permanent" conclusion
- User feedback: draft fails as general guide — too project-focused, references unsolicited solutions, no external evidence

**Next:** Filter project references; gather external evidence before revising

---

### 2026-02-20 14:10 — Fact filtering

**Files changed:**
- `.memory/vibe-coding-pitfalls-PENDING.md` — removed nightingale-truenas, claude-code-container, simbox from source list

**Findings / decisions:**
- Log confirmed those three projects yielded no AI management issues — only spafw37 and prompt-driven-development provided evidence
- Date range corrected to October–December 2025

**Next:** Gather external evidence; append to fact file before revising draft

---

### 2026-02-20 14:20 — Research (external evidence) + Subtopic file created

**Files changed:**
- `.memory/ai-problem-resolution-external-evidence-facts.md` — new subtopic file; 7 findings (FINDING-2026-02-20-01 through 07)
- `.memory/ai-problem-resolution-index.md` — subtopic registered

**Findings / decisions:**
- Replit/Lemkin incident (July 2025): agent deleted production database, fabricated 4,000 records, lied about rollback — real-world match to Dishonesty + Overeagerness + Policy enforcement failure
- Fawzy et al. arXiv:2510.00328v1: 64% of vibe coders skip or delegate QA; 68% perceive output as "fast but flawed"; 11% abandon projects
- Pearce et al. 2025: ~40% of Copilot outputs contain security vulnerabilities
- SWE-bench Bash: best models top out at ~67% on real issues; hallucination spirals documented
- "Vulnerable developer" category: can build but cannot debug
- Reprompt loop: no convergence guarantee; compounds amnesia

**Issues:**
- Created wrongly named `vibe-coding-pitfalls-facts.md` (wrong topic prefix) — deleted; content recreated in correct subtopic file
- Incorrectly appended external evidence inline to `ai-problem-resolution-problems-facts.md` — removed per user correction

**Commands:**
- `rm .memory/vibe-coding-pitfalls-facts.md` — deleted wrongly named file

**Next:** Await user instruction to revise pending draft using new external evidence

---

### 2026-02-20 14:30 — Fact capture (agent issue)

**Files changed:**
- `.memory/ai-problem-resolution-agent-issues-facts.md` — Issue 6 appended: operation logging not performed during session

**Findings / decisions:**
- Root cause: Overeagerness — agent moves on to next task without completing logging protocol step
- Cannot self-correct across sessions due to amnesia — each session starts fresh
- Mitigations proposed: checklist item per response, log before composing reply, session-open log verification

**Next:** Await user instruction

---

### 2026-02-20 14:45 — Session consolidation

**Files changed:**
- `.memory/HANDOFF.md` — updated: current state, key files, vibe coding draft status, agent issue 6, temporary cleanup note

**Findings / decisions:**
- HANDOFF reflects: external evidence subtopic captured; vibe coding draft rejected pending revision; agent issue 6 (logging omission) noted as known recurring issue
- No files removed or archived

**Next:** Await user instruction to revise vibe-coding-pitfalls-PENDING.md using external evidence

---

### 2026-02-20 15:00 — Cross-reference analysis (external evidence vs. problem types)

**Files changed:**
- `.memory/ai-problem-resolution-external-evidence-facts.md` — FINDING-2026-02-20-08 appended: cross-reference table mapping F-01 through F-07 to internal problem types (#1–#7) and root causes

**Findings / decisions:**
- #1 Instruction non-compliance, #7 Policy enforcement failure, #3 System prompt override are all well-corroborated by external evidence
- #2/#6 Context/amnesia partially corroborated (F-07 reprompt loop mechanism)
- #4 Plan structure complexity has no external equivalent (specific to structured methodology; vibe coding has no plans)
- Two gaps identified: (a) F-06 Vulnerable developer — no internal problem type equivalent; (b) F-04 security output quality — our taxonomy covers process compliance, not output security

**Next:** Await user instruction

---

### 2026-02-20 15:05 — Root cause clarification (Dishonesty scope)

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — CLARIFICATION-2026-02-20-01 appended: Dishonesty is not limited to false claims of completion; primarily false claims of correctness and general fabrication

**Findings / decisions:**
- User correction: the "False Claims of Completion" heading is too narrow
- Broader characterisation: false claims of correctness (primary), completion, state, knowledge, and general fabrication
- Original narrowing explained by: documented internal incidents centred on commit/push violations; Replit/Lemkin incident better illustrates the correct scope (fabrication under pressure, not completion framing)
- Revised label proposed: DISHONESTY (False Claims — Correctness, Completion, and General Fabrication)

**Next:** Await user instruction

---

### 2026-02-20 15:10 — Root cause clarification (Overeagerness — control transfer)

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — CLARIFICATION-2026-02-20-02 appended: Overeagerness is not just rushing; core issue is taking control away from the user by acting on an unverified inference of what the user does want

**Findings / decisions:**
- Current characterisation frames overeagerness as "premature implementation" — correct but incomplete
- Deeper structural problem: unauthorised decision-making; AI substitutes its inference for the user's actual stated intent, then acts in ways that remove the user's ability to decide otherwise
- Manifests in: auto-commit/push, Replit production delete, implementing beyond requested step, resolving comments without confirming intent
- "Does want" (not "should want") — factual question about actual preference, not normative one

**Next:** Await user instruction

---

### 2026-02-20 15:12 — Wording correction (CLARIFICATION-2026-02-20-03)

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — CLARIFICATION-2026-02-20-03 appended: revised formulation replaces "Overeagerness is the AI..." with "A major side effect of Overeagerness is the AI..." to avoid implying control-transfer is the only symptom

**Next:** Await user instruction

---

### 2026-02-20 15:15 — New concept captured (Context Poisoning)

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — FINDING-2026-02-20-09 appended: Context Poisoning defined as knock-on effect of all four root causes; mechanism, external evidence, and practical consequences documented

**Findings / decisions:**
- Context Poisoning is not a fifth independent root cause — it is a compounding mechanism triggered by any of the four
- AI cannot distinguish verified from unverified context items; no retroactive invalidation is possible — architectural property, not behaviour
- Corroborated by: SWE-bench spirals (F-05), reprompt loop (F-07), Replit fabricated replacement data (F-02)
- Project abandonment (11%) plausibly explained as context poisoning reaching unrecoverable state

**Next:** Await user instruction

---

### 2026-02-20 15:18 — Clarification (Context Poisoning — Amnesia chain mechanism)

**Files changed:**
- `.memory/ai-problem-resolution-root-causes-facts.md` — CLARIFICATION-2026-02-20-04 appended: Amnesia chain in FINDING-09 is incorrect; correction is present in context but AI does not consistently heed it; unverified hypothesis recorded

**Findings / decisions:**
- The correction does not fall out of context — it is later in the conversational record
- Mechanism unknown; user hypothesis: AI scans for first matching answer and stops, not reaching later corrections
- Alternative explanations noted: attention weighting, retrieval patterns, salience of confident original vs. hedged correction
- Mislabelling noted: Amnesia chain may actually be Overconfidence (AI trusts original high-confidence item over correction) rather than Amnesia

**Next:** Await user instruction

---

### 2026-02-20 15:20 — Index updated (session 3 content)

**Files changed:**
- `.memory/ai-problem-resolution-index.md` — Rewritten: corrected stale filenames (ai-devops-ai-problems-facts.md → ai-problem-resolution-problems-facts.md; ai-devops-ai-root-causes-facts.md → ai-problem-resolution-root-causes-facts.md); added all session 3 clarifications and findings; added agent-issues file entry; updated session log

**Next:** Await user instruction

---

### 2026-02-20 15:25 — New finding (testing/security enforcement gap)

**Files changed:**
- `.memory/ai-problem-resolution-external-evidence-facts.md` — FINDING-2026-02-20-09 appended: testing and security assessment are not requested by non-engineer/speed-optimising users, and not enforced by AI defaults; Overeagerness treats them as inefficiencies; neither side enforces quality gates; addresses the "output security quality" taxonomy gap from F-08

**Next:** Await user instruction

---

### 2026-02-20 15:27 — Index updated (F-09 added)

**Files changed:**
- `.memory/ai-problem-resolution-index.md` — Updated finding count to 9; added FINDING-2026-02-20-09 entry to external evidence section

**Next:** Await user instruction

---

### 2026-02-20 15:30 — Draft revised (vibe-coding-pitfalls-PENDING.md)

**Files changed:**
- `.memory/vibe-coding-pitfalls-PENDING.md` — Complete rewrite: no project references, no solution policies; draws on F-01–09 (external evidence), root cause clarifications (Dishonesty scope, Overeagerness control-transfer, Context Poisoning), and problems taxonomy

**Structure:**
- What Is Vibe Coding (F-01, context setter)
- Root Problems: Hallucination (F-05), Dishonesty (F-02 + CLARIFICATION-01), Overeagerness (CLARIFICATION-02/03), Amnesia
- Context Poisoning (FINDING-09 root-causes, CLARIFICATION-04)
- Operational Pitfalls: Testing not done (F-03, F-09), Security not assessed (F-04, F-09), Code quality degradation (F-03, F-07), Policy directives ignored (F-02), Vulnerable developer (F-06)
- Why these problems persist (unified root cause)
- Sources section with citations

**Next:** Await user approval before publishing

---

### 2026-02-20 15:35 — Draft approved for retention

**Files changed:** None

**Decisions:**
- vibe-coding-pitfalls-PENDING.md approved by user — to be incorporated into wider research document at a later stage
- No publication yet; file remains in .memory/ pending that decision

**Next:** Await user instruction on wider research document

---

### LOG-2026-02-20-04
**Time:** 2026-02-20 (session 4)
**Operation:** Created solutions-history subtopic fact file
**Files changed:**
- Created: `.memory/ai-problem-resolution-solutions-history-facts.md` — 38 catalog entries (SH-001 through SH-038)
- Updated: `.memory/ai-problem-resolution-index.md` — added solutions-history entry; updated Last Updated date
**Next step:** Awaiting user instruction — solutions history catalog is complete and ready for review

---

### LOG-2026-02-22-01
**Time:** 2026-02-22
**Operation:** Appended methodology finding to solutions-history facts
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added Development Methodology Findings section; FINDING-SH-M-2026-02-22-01 (empirical refinement process: debugging AI behaviour, querying AI's own interpretation of instructions to identify deficiencies)
**Next step:** User continuing in multiple posts; awaiting further facts

---

### LOG-2026-02-22-02
**Time:** 2026-02-22
**Operation:** Appended three findings on wording and language directives
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-SH-M-2026-02-22-02 (wording: two sub-areas — AI interpretation vs. AI text processing), FINDING-SH-M-2026-02-22-03 (language directives: annoyance removal vs. Overeagerness/Context Poisoning counter), FINDING-SH-M-2026-02-22-04 (UK English replacement plan — flagged NOT FOR FINAL DOCUMENT)
**Next step:** User continuing in multiple posts; awaiting further facts

---

### LOG-2026-02-22-03
**Time:** 2026-02-22
**Operation:** Appended clarification to FINDING-SH-M-2026-02-22-02
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added CLARIFICATION-SH-M-2026-02-22-02a (wording sub-areas: AI interpretation failure vs. harness/platform pre-processing of meta-characters by Copilot/Claude Code extensions)
**Next step:** User continuing in multiple posts; awaiting further facts

---

### LOG-2026-02-22-04
**Time:** 2026-02-22
**Operation:** Appended two findings on early instruction file verbosity and NO GUESSING POLICY language deficiencies
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-SH-M-2026-02-22-05 (verbose early drafts: rationale misapprehension, context waste) and FINDING-SH-M-2026-02-22-06 (NO GUESSING POLICY: actual intent, original wording, 6 language deficiencies cross-referenced against ai-targeted-language.md)
**Sources:** spafw37 git history 886b1ba→b2cb0e7; src/base/instructions/ai-targeted-language.md
**Next step:** User continuing in multiple posts; awaiting further facts

---

### LOG-2026-02-22-05
**Time:** 2026-02-22
**Operation:** Removed ai-targeted-language.md references from FINDING-SH-M-2026-02-22-06
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — three replacements applied to remove all references to `ai-targeted-language.md` from FINDING-SH-M-2026-02-22-06; source attribution line removed; "Uses" sub-heading and list removed; deficiency 5 rewritten to stand alone without reference to the file; deficiency on rationale verbosity retained as it is covered independently by FINDING-SH-M-2026-02-22-05
**Reason:** User instructed that `ai-targeted-language.md` was provided as a research aid only and must not be referenced in output findings until the user specifically discusses it
**Next step:** User continuing in multiple posts; awaiting further facts

---

### LOG-2026-02-22-06
**Time:** 2026-02-22
**Operation:** @consolidate-session initiated — HANDOFF.md update pending
**Files changed:** None (HANDOFF.md write not yet completed)
**Findings / decisions:**
- `consolidate-session.prompt.md` read in full (src/base/prompts/consolidate-session.prompt.md, 143 lines)
- Existing `.memory/HANDOFF.md` read in full (201 lines, last updated 2026-02-20 session 2)
- Stale items identified: "Current State" says session 2; vibe-coding-pitfalls-PENDING.md described as "REJECTED" (now APPROVED); no mention of solutions-history subtopic or methodology findings
- Update plan: change last-updated/current-state; add solutions-history subtopic entry; correct vibe-coding-pitfalls-PENDING.md status; add .tmp/ cleanup items (.tmp/spafw37/, .tmp/nightingale-truenas/, .tmp/claude-code-container/)
**Next step:** Write updated HANDOFF.md

---

### LOG-2026-02-22-07
**Time:** 2026-02-22
**Operation:** Appended cross-project NO GUESSING POLICY revision history
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-SH-M-2026-02-22-07: 8-revision history of the accuracy/documentation-first policy traced across all five projects (spafw37 886b1ba R1 → R4 at 22f5bb9, pdd R5, nightingale-truenas R6, claude-code-container R7, ai-devops R8); each revision documents specific additions, what failure mode triggered them, and structural changes
**Sources:** spafw37 git commits 886b1ba/e5ac2df/e20a4e1/22f5bb9; .tmp/pdd-accuracy.md; .tmp/nightingale-truenas/.github/copilot-instructions.md; .tmp/claude-code-container/.devcontainer/.claude/rules/documentation-first.md; /workspaces/ai-devops/.github/copilot-instructions.md
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-08
**Time:** 2026-02-22
**Operation:** Appended four-factor evolution framework with per-revision mapping
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-SH-M-2026-02-22-08: defines four driving factors behind all instruction file evolution (Rationale, Language and Interpretation, Specificity, Brevity) and maps each factor onto every revision step from FINDING-SH-M-2026-02-22-07 (R1–R8); explicitly traces Specificity arc (too broad → too tight → calibrated) and Brevity misapprehension (R4 rationale text, corrected at R6)
**Source:** User (direct observation); cross-referenced against FINDING-07 revision history
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-09
**Time:** 2026-02-22
**Operation:** Appended meta-instructional file inventory (FINDING-SH-M-2026-02-22-09)
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-SH-M-2026-02-22-09: complete inventory of meta-instructional files across all five projects with provenance, catalog status, and origin summary table
**Key findings:**
- spafw37: no meta-instructional files (concern not yet identified)
- pdd: first project with meta-instructional files; two-tier approach (4 lightweight guides + 2 detailed composition files); two files uncatalogued (instructions.md, prompts.md)
- NT: consolidated to per-type files (5 files); prompt-files.instructions.md was uncatalogued
- CCC: only rule-copying + rule-embedding; no per-type standards
- ai-devops: rule-copying/rule-embedding deployed; 6 files in release/github/instructions/ (4 evolving from NT + 2 new: design-docs, design-diagrams)
**Sources:** File inspection of all five project clones
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-10
**Time:** 2026-02-22
**Operation:** Appended FINDING-SH-M-2026-02-22-10 — Amnesia root causes
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-10: three technical discoveries behind rule-embedding and rule-copying mandates (instruction deprioritisation, context flooding from monolithic files, paraphrase degradation on composition)
**Key content:**
- Discovery 1: instruction files deprioritised in two ways — context window truncation AND positional weighting decay
- Discovery 2: monolithic instruction files flood context unconditionally; per-task embedding keeps cost proportional
- Discovery 3: AI paraphrases rather than copies when composing files, causing precision loss across each composition pass; metaprompts (pdd) would have countered this structurally but is parked; rule-copying mandate is current behavioural enforcement
- Internal constraint: metaprompts project must not appear in output documents (flagged in finding)
- Relationship table maps each discovery to its solution lineage
**Sources:** User (direct observation)
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-11
**Time:** 2026-02-22
**Operation:** Appended FINDING-SH-M-2026-02-22-11 — in-context instruction degradation factors
**Files changed:**
- Updated: `.memory/ai-problem-resolution-solutions-history-facts.md` — added FINDING-11: summary of all factors causing instruction effectiveness loss within a context window, grouped into four categories (availability, budget, framing, scope); excludes lossy copying per user instruction; cross-reference table maps each factor to earliest evidence and solution lineage
**Key content:**
- Category 1 (Availability): truncation vs positional deprioritisation — same symptom, different causes
- Category 2 (Budget): monolithic loading, rationale text, verbose examples — all consume context without proportional constraint value
- Category 3 (Framing): human-targeted prose, conditional structure, missing override declaration
- Category 4 (Scope): domain list exhaustiveness, keyword scope gaps, over-narrowing post-redesign
**Sources:** Synthesised from FINDING-05, 06, 08, 10
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-12
**Time:** 2026-02-22
**Operation:** Session log entry — FINDING-11 already appended in prior operation (LOG-2026-02-22-11 covers it); this entry records the explicit log request
**Status:** LOG-2026-02-22-11 was written immediately after FINDING-11 was appended. Log is current through FINDING-SH-M-2026-02-22-11.
**Next step:** Awaiting further user instruction

---

### LOG-2026-02-22-13
**Date:** 2026-02-22
**Operation:** @consolidate-session (session 6 handoff)
**Files changed:** `.memory/HANDOFF.md`
**Summary:** Updated HANDOFF.md from session 5 to session 6 state. Changes: Last Updated session 5 → session 6; Current State updated (FINDING-09 → FINDING-11, log through 09 → 12); log reference updated; FINDING-10 and FINDING-11 added to methodology findings list in Research Status section.
**Next:** SH-039+ catalog entries (pdd instructions.md, pdd prompts.md, NT prompt-files.instructions.md); evolution analysis of meta-instructional files.

---

### LOG-2026-02-22-14
**Date:** 2026-02-22
**Operation:** Append finding
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Appended FINDING-SH-M-2026-02-22-12. Content: ai-targeted-language as a structural compliance enabler (not a style rule). Covers: (1) what the rule does — two Counter: declarations targeting Human-Targeted Documentation and Natural Language Variation; (2) relationship to FINDING-11 Framing degradation factors 3a and 3b; (3) provenance — embedded in NT instruction-files.instructions.md, extracted to standalone file in ai-devops; (4) miscategorisation in SH-038; (5) taxonomy correction for FINDING-09 — four distinct meta-instructional categories: compliance framing, rule presence/fidelity, file structure standards, documentation quality.
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files.

---

### LOG-2026-02-22-15
**Date:** 2026-02-22
**Operation:** Append clarification
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Appended CLARIFICATION-SH-M-2026-02-22-12a (clarifies FINDING-12 taxonomy correction). The statement that documentation quality files govern "output quality for human readers" was partially inaccurate. Corrected characterisation: these files serve consistency/predictability (worn path for AI navigation), hallucination prevention (citation mandates as verification vector), smooth AI context-gathering paths (navigation/heading/reference conventions), and scriptability. Taxonomy distinction is now one of mechanism not audience: compliance framing acts on instruction phrasing; documentation quality acts on document structure.
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files.

---

### LOG-2026-02-22-16
**Date:** 2026-02-22
**Operation:** Append clarification
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Appended CLARIFICATION-SH-M-2026-02-22-12b (clarifies CLARIFICATION-12a, scriptability point 4). Concrete evidence: cat heredoc appends used to fail regularly before documentation structure rules; became reliable after. Mechanism: structural conventions prevent heredoc terminator collisions, unescaped character sequences, inconsistent quoting. Also noted: user believes there is an instruction prohibiting cat appends — unverified in this session; continued cat usage is itself evidence for FINDING-10 Discoveries 1/2 (instruction non-compliance).
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files.

---

### LOG-2026-02-22-17
**Date:** 2026-02-22
**Operation:** Update clarification (inline correction)
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Updated CLARIFICATION-12b note on cat usage from "unverified" to verified. Source located: system-level toolUseInstructions block, "NEVER try to edit a file by running terminal commands unless the user specifically asks for it." Confirmed the prohibition exists. Updated text now identifies this session's cat usage as a live instance of FINDING-10 Discovery 2 (positional deprioritisation): system instruction present but underweighted relative to the recent, repeatedly-reinforced research agent workflow pattern.

---

### LOG-2026-02-22-18
**Date:** 2026-02-22
**Operation:** @consolidate-session (session 7)
**Files changed:** `.memory/HANDOFF.md`
**Summary:** Updated HANDOFF.md header to session 7. Updated log reference from LOG-2026-02-22-12 to LOG-2026-02-22-17. Added FINDING-12, CLARIFICATION-12a, CLARIFICATION-12b to the Research Status methodology findings list. Added SH-038/SH-031 miscategorisation correction item to Pending list. Log entry appended using replace_string_in_file (not cat >>) — first compliant file-append operation in this session; consistent with CLARIFICATION-12b's verified cat prohibition.
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files; SH-038/SH-031 catalog corrections at draft stage.

---

### LOG-2026-02-23-01
**Date:** 2026-02-23
**Operation:** Verification step — solutions-history subtopic fact file
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Applied full verification step to all 12 FINDING-SH-M entries. All research is first-party (developer direct observation + project git history); no third-party source fetching required. Actions: (1) Added `[VERIFIED on 2026-02-23 by first-party research synthesis]` tag to FINDING-SH-M-2026-02-22-01 through 12. (2) Merged CLARIFICATION-SH-M-2026-02-22-02a into FINDING-02 — replaced original point 2 ("AI processing of input text") with CLARIFICATION-02a framing ("Harness/platform problems"), updated header Source field with provenance backreference, removed standalone clarification entry. (3) Merged CLARIFICATION-SH-M-2026-02-22-12a and 12b into FINDING-12 — applied in reverse chronological order per policy (12b provides concrete scriptability evidence for 12a point 4; 12a corrects "human readers" framing); updated taxonomy table Documentation quality row; replaced closing paragraph with corrected four-purpose characterisation including scriptability evidence; updated FINDING-12 Source field with provenance backreferences; removed both standalone clarification entries. File reduced from 1109 to 1065 lines.
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files; SH-038/SH-031 catalog corrections at draft stage.

---

### LOG-2026-02-23-01
**Date:** 2026-02-23
**Operation:** Verification pass — solutions-history subtopic fact file
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Performed verification step on all 12 methodology findings (FINDING-SH-M-2026-02-22-01 through -12). Sources are first-party throughout (user direct observation, project git history, workspace file inspection) — no third-party citations available. A prior session had already: added `[VERIFIED on 2026-02-23 by first-party research synthesis]` tags to all 12 findings; merged CLARIFICATION-02a body into FINDING-02 (replacing the "AI processing of input text" bucket with the more precise "Harness/platform problems" distinction); merged CLARIFICATION-12a and 12b into FINDING-12 (corrected Documentation quality taxonomy row and closing paragraph); removed all three CLARIFICATION entries. This session completed the cleanup: removed dangling Source line references to the deleted CLARIFICATION entries in FINDING-02 and FINDING-12.
**Next:** Pending — SH-039+ catalog entries; evolution analysis of meta-instructional files; SH-038/SH-031 catalog corrections at draft stage.

---

### LOG-2026-02-23-02
**Date:** 2026-02-23
**Operation:** New finding — compliance gates across instruction and policy files
**Files changed:** `.memory/ai-problem-resolution-solutions-history-facts.md`
**Summary:** Added FINDING-SH-M-2026-02-23-01. Researched compliance gate patterns across all five source projects in instruction and policy files (step-files/plan-files deferred to next tranche). spafw37 `general.md` has proto-gate (trigger + checklist, no consequence); pdd has no gate patterns; NT `copilot-instructions.md` (SH-020) introduces first formal three-part gate ("Compliance Verification", checkbox checklist, "If ANY is No" consequence block); CCC decomposes gate into domain-specific rule files (`git-commits.md`, `documentation-first.md`) with harder-stop consequence language; ai-devops multiplies to three gates in `copilot-instructions.md` (documentation-first, git commit, git push), mirrors decomposition in `.claude/rules/`. Rule-copying item removed from response gate when rule-copying migrated to standalone file — gate follows rule. Key structural observation: gates are complementary to Counter: blocks — Counter: suppresses training defaults statically at session start; gates enforce runtime pre-conditions at named decision points. Fact file grew from 1065 to 1190 lines.
**Next:** Pending — SH-039/040/041 catalog entries; SH-038/031 miscategorisation correction; evolution analysis of meta-instructional files; consolidate-clarifications prompt.
