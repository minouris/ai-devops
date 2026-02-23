# AI Problem Resolution — Solutions History: Overeagerness Findings

**Topic:** `ai-problem-resolution` (subtopic: solutions-history / problem: overeagerness)
**Overview file:** [ai-problem-resolution-solutions-history-facts.md](ai-problem-resolution-solutions-history-facts.md)
**Scope:** Methodology findings about compliance framing, language register, and compliance gate evolution as they address Overeagerness

---

## Development Methodology Findings

### FINDING-SH-M-2026-02-22-03
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** User (direct observation)
**Domain:** Language directives — dual purpose

Language directives in instruction files serve two distinct purposes that are not always separable:

1. **Removing annoyances** — e.g., UK English spelling (SOLUTION-SH-007 and equivalents across projects). These address output quality preferences rather than AI problems directly.

2. **Countering Overeagerness** — directives prohibiting hyperbolic language, grandiose claims, and marketing language serve a functional purpose beyond style. Such language, when present in context alongside incorrect information, may reinforce incorrect facts by lending them an air of confidence or authority. This makes the prohibition of hyperbole a measure against both Overeagerness (tone) and the compounding effect of Context Poisoning (incorrect facts presented with high-confidence language are harder to dislodge).

The two purposes are present simultaneously in documentation-standards files and should not be treated as purely stylistic rules.

---

### FINDING-SH-M-2026-02-22-12
**Captured:** 2026-02-22
**Verified:** [VERIFIED on 2026-02-23 by first-party research synthesis]
**Source:** `/workspaces/ai-devops/.claude/rules/ai-targeted-language.md`; `/workspaces/ai-devops/src/base/instructions/ai-targeted-language.md`; `.tmp/nightingale-truenas/.github/instructions/instruction-files.instructions.md` (lines 15, 25, 206–230, 513); user (direct observation)
**Domain:** Compliance framing — AI-targeted language as a structural compliance enabler

---

#### What the rule does

`ai-targeted-language.md` governs the language register used when writing AI files. Its purpose is not stylistic — it ensures that when an AI agent reads an instruction, the wording causes the instruction to be processed as a mandatory command rather than advisory guidance.

The rule contains two Counter: declarations:

- **Counter: Human-Targeted Documentation** — OVERRIDES the training tendency to write documentation for human readers. Instructions must be written in second person, directly addressing the AI agent ("you", not "The AI should" or "Copilot will").
- **Counter: Natural Language Variation** — OVERRIDES the training tendency to vary phrasing. Instruction files must use consistent imperatives ("MUST", "MUST NOT", "When you…") because repetitive structure aids AI parsing.

The Writing Style section prohibits: third-person descriptions of AI behaviour, vague language ("try to", "consider", "maybe", "approximately"), and conditional instruction language ("might", "could", "may").

A Brevity vs. Completeness section governs the trade-off: completeness takes precedence over brevity when ambiguity would result; brevity takes precedence when requirements are already unambiguous.

---

#### Relationship to degradation factors (FINDING-11)

`ai-targeted-language` addresses the **Framing** degradation category (Category 3) at the file authoring level:

| FINDING-11 Factor | ai-targeted-language coverage |
|---|---|
| 3a. Human-targeted prose framing | Directly addressed: Counter: Human-Targeted Documentation; MUST write second person, imperative |
| 3b. Conditional framing | Directly addressed: MUST NOT use "might", "could", "may"; MUST NOT use "try to", "consider" |
| 3c. No override declaration | Addressed structurally: the rule's own Counter: declarations model the required override pattern |

The rule works at authoring time: it governs the humans (and AI agents) who *create* AI files so that the resulting files have a lower risk of framing degradation in execution.

---

#### Provenance

The content did not originate as a standalone file. It was embedded within NT's `instruction-files.instructions.md` (531 lines, SH-019) — the language-register requirements appeared at lines 15, 25, 206–230, and 513 of that file, covering the same two Counter: declarations and the same MUST/MUST NOT lists.

In ai-devops, it was extracted into a dedicated file: `ai-targeted-language.md`. This follows the same decomposition pattern as spafw37's SH-001 → SH-005/SH-006/SH-007: a monolithic file's concerns separated into single-concern files.

Both `.claude/rules/ai-targeted-language.md` and `src/base/instructions/ai-targeted-language.md` are present in ai-devops with identical content — the latter is the canonical source; the former is deployed to the `.claude/rules/` tree.

---

#### Miscategorisation in SH-038

`ai-targeted-language` was catalogued in SH-038 under "style, format, structural, and syntax enforcement standards — not AI-problem targeted." This miscategorisation placed it alongside documentation-standards, mermaid-diagrams, and similar files.

The correct categorisation is alongside `rule-copying` and `rule-embedding` as a **structural compliance enabler**: it addresses how AI files must be written so that in-context instructions produce compliant behaviour. It directly targets named training behaviours (Human-Targeted Documentation, Natural Language Variation) and addresses two of the eleven in-context degradation factors identified in FINDING-11 in the Amnesia file.

---

#### Taxonomy correction for FINDING-09

The meta-instructional file inventory in FINDING-09 (see overview file) encompasses several distinct concerns that were not cleanly separated. `ai-targeted-language` highlights a third category that was not articulated:

| Category | Purpose | Files |
|---|---|---|
| **Compliance framing** | Language register ensures instructions are processed as commands | `ai-targeted-language.md` |
| **Rule presence/fidelity** | Instructions are in context and uncorrupted when needed | `rule-copying.md`, `rule-embedding.md` |
| **File structure standards** | Required sections, format, ordering | `instruction-files`, `prompt-files`, `step-files`, `plan-files`, `memory-files` |
| **Documentation quality** | Structural and citation conventions serving consistency, verification, AI navigation, and scriptability | `documentation-standards.md`, `mermaid-diagrams.md`, etc. |

Files in the documentation quality category (documentation-standards, markdown-formatting, mermaid-diagrams, reference-items, section-numbering) were also catalogued in SH-038. They do not exclusively govern human-reader output quality. They enforce structural and citation conventions that serve four purposes simultaneously: (1) **Consistency and predictability** — a structurally predictable document reduces AI interpretive overhead; (2) **Hallucination prevention** — citation mandates preserve sources for verification passes (the mechanism behind `verify-memory-facts`); (3) **AI context navigation** — mandated heading structure and navigation elements create predictable paths for AI context-gathering; (4) **Scriptability** — structural predictability enables automated operations on documentation and AI files. Concrete evidence for (4): `cat` heredoc append operations used throughout this research session became reliable after documentation structure rules were established, because the rules prevent structural collisions (heredoc terminator strings inside content, unescaped special characters, inconsistent quoting) that caused earlier operations to fail.

The taxonomy distinction from compliance-framing rules is one of mechanism, not of audience: compliance framing (`ai-targeted-language`) acts on how instructions are phrased so they are parsed as commands; documentation quality (`documentation-standards`, `reference-items`, `document-navigation`, etc.) acts on how documents are structured so they are navigable, verifiable, and consistent for both AI and human readers alike. These are domain standards that happen to have `applyTo` paths covering AI file types — they are not compliance-framing rules, but they are not purely stylistic rules either.

---

### FINDING-SH-M-2026-02-23-01: Compliance Gates — Evolution Across Instruction and Policy Files
**Captured:** 2026-02-23
**Sources:** First-party — spafw37 `general.md`, `issue-workflow.md`; pdd `instruction-composition.md`, `copilot-instructions.md`; NT `copilot-instructions.md` (SH-020); CCC `.devcontainer/.claude/rules/git-commits.md`, `.devcontainer/.claude/rules/documentation-first.md`; ai-devops `.github/copilot-instructions.md` (SH-038), `CLAUDE.md`, `.claude/rules/git-commits.md`

---

#### Definition

A **compliance gate** is a structured instruction block with three required components:
1. A **trigger phrase** naming a specific decision point ("Before completing ANY response", "Before creating any git commit")
2. A **self-check checklist** the AI must evaluate before proceeding — items are individually binary
3. A **consequence block** specifying what happens when any item fails — either mandatory remediation or a hard stop ("do not proceed")

The three-part structure (trigger + checklist + consequence) distinguishes a compliance gate from an informal advisory checklist or a behavioural guideline. The gate applies at runtime, at the named decision point; it does not modify the instructions that precede it.

---

#### spafw37 (Oct 2025) — proto-gate, no enforcement

`general.md` introduces a "Before Making Changes" section with a five-item advisory checklist: read instruction files for the file type; examine existing patterns; check for related tests; verify language/framework compatibility; run existing tests to establish a baseline.

This has the trigger frame ("Before Making Changes") and checklist form, but lacks the enforcement component. There is no consequence for failure, no stop instruction, and no "if any is No" clause. The language is directive but advisory: it tells the AI what to do before changes, not what to withhold if those steps are skipped.

`issue-workflow.md` adds a "What NOT to Do" prohibition list ("Don't start implementation without a completed plan"). This is a flat prohibition list, not a gate — it names forbidden actions without tying them to a pre-action check sequence.

---

#### pdd (Dec 2025) — no gate patterns

No compliance gate patterns appear in any pdd instruction or policy file. `instruction-composition.md`, `copilot-instructions.md`, and other pdd files contain no Compliance Verification sections and no "If ANY is No" consequence blocks.

---

#### NT (Jan 2026) — first formal compliance gate

NT `copilot-instructions.md` (SH-020) introduces the first formal compliance gate in a policy file, under the heading "Compliance Verification":

```
Before completing ANY response to a user query:

Ask yourself:
- [ ] Did I consult official documentation before answering?
- [ ] Have I included at least one citation?
- [ ] If uncertain, did I explicitly state this rather than guess?
- [ ] Did I avoid making assumptions about user intent?
- [ ] If documentation is unavailable, did I clearly state this?
- [ ] If copying ANY RULES to another file, did I copy the FULL TEXT verbatim...?

If ANY answer is "No":
- Research official documentation before responding
- Add required citations
- Clarify uncertainties explicitly
- These are mandatory standards
```

Key features: named trigger scope covering all responses; markdown checkbox list enabling item-by-item self-evaluation; consequence block with specific remediation steps; terminal phrase "These are mandatory standards" converting the checklist into a requirement rather than guidance. Scoped to the full documentation-first and rule-copying compliance surface. Six items. Rule-copying verbatim check is item 6.

---

#### CCC (Feb 2026) — domain decomposition of gate pattern

CCC does not place a compliance gate in its top-level policy file. Instead, the gate pattern migrates into **domain-specific rule files**. `git-commits.md` (Claude rule) carries its own Compliance Verification section scoped to commit operations:

```
Before creating any git commit:

Ask yourself:
- [ ] Did the user explicitly ask for a commit?
- [ ] Is the commit message clear and descriptive?
- [ ] Have I avoided adding Co-Authored-By or attribution lines?
- [ ] Are only relevant files staged?
- [ ] Do I understand what's being committed?
- [ ] Are there no secrets or credentials in the commit?

If ANY answer is "No":
- Do not proceed with the commit
- These are mandatory standards
```

`documentation-first.md` (Claude rule) carries an identical-structure gate scoped to documentation-first compliance. The NT single-scope gate has been decomposed: each rule domain now carries its own termination gate. The consequence language sharpens from "research before responding / clarify" to "do not proceed with the commit" — a harder stop with no remediation path, distinguishing irreversible operations (commits) from correctable ones (responses).

---

#### ai-devops (current) — gate multiplication in top-level policy

ai-devops `copilot-instructions.md` (SH-038) expands the NT single gate into three distinct compliance gates, all under one "Compliance Verification" section:

1. **Documentation-first response gate** (5 items): documentation consulted, citation included, uncertainty stated, assumptions avoided, unavailability stated. The rule-copying item from NT is absent — it was moved to a standalone rule file.
2. **Git commit gate** (6 items): edit requires commit, commit message clear, no Co-Authored-By, only relevant files staged, content understood, no secrets.
3. **Git push gate** (2 items): user explicitly requested push, remote and branch understood.

`CLAUDE.md` mirrors this three-gate structure with additional auto-commit policy. `.claude/rules/git-commits.md` also carries the domain-specific commit gate independently — the same CCC decomposition pattern, now coexisting with the omnibus version.

The removal of the rule-copying checklist item from the response gate in ai-devops is direct evidence of **gate decomposition following rule decomposition**: when the rule-copying concern acquired its own standalone file, its compliance check was removed from the omnibus gate. The gate and the rule it enforces migrate together.

---

#### Structural observations

1. **Three-part structure first appears fully in NT and is preserved verbatim.** The phrase "These are mandatory standards" is stable across NT, CCC, and ai-devops — a direct instance of the rule-copying principle applied to gate text.

2. **spafw37's "Before Making Changes" is a proto-gate.** It has the trigger frame and checklist form but lacks the consequence block — the enforcement mechanism that converts advisory guidance into a conditional stop.

3. **Gate logic is strict-AND.** Checklist items are individually binary; the "If ANY" operator means a single failed item triggers the consequence. There is no partial compliance. This is structurally identical to a logical conjunction of all items — harder to rationalise around than a weighted or majority-rule check.

4. **Gates and Counter: blocks are complementary mechanisms targeting different problems.** Counter: blocks address training defaults proactively — they suppress specific learned behaviours before the session starts. Compliance gates address runtime compliance at specific decision points — they require demonstration of conformance before an action is taken. Counter: is a static override; gates are dynamic checkpoints.

5. **Gates migrate in two directions.** In CCC and ai-devops, the pattern moves (a) upward into the top-level omnibus policy, where it multiplies by domain, and (b) downward into individual rule files, where each rule domain carries its own gate. When a rule migrates to a standalone file, its gate migrates with it.

6. **Gate presence does not guarantee compliance.** FINDING-10 Discoveries 1 and 2 (see Amnesia file) apply to gate text with equal force. A gate at the end of a long policy file is subject to the same availability and framing degradation factors as any other instruction.

---

#### Relationship to other findings

- **FINDING-02** (conditional framing as failure mode, overview file): The compliance gate avoids the softening effect of conditional instruction framing. The trigger is conditional in form ("Before X, do Y") but the instruction inside the gate is mandatory in force ("If ANY is No: do not proceed").
- **FINDING-11** (degradation factors, Ammesia file, Framing category): Gates address Framing factor 3c (mandatory instructions buried under non-mandatory language) at the policy level.
- **FINDING-12** (documentation quality, this file): The checkbox format (`- [ ] item`) is itself an instance of structural predictability serving AI processing — enumerable, individually scannable, immune to prose interpretation.
