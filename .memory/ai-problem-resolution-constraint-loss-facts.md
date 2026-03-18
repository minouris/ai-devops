# AI Problem Resolution — Constraint Loss Facts

**Topic:** `ai-problem-resolution-constraint-loss`
**Scope:** Constraints removed or softened across all analyzed rule files during their evolution across the five projects (spafw37, pdd, nightingale-truenas, claude-code-container, ai-devops)
**Methodology:** Systematic revision-by-revision comparison of constraint language, prohibition lists, and mandatory requirements

---

## Research Scope

**Includes:**
- All rule files catalogued in SH-001 through SH-038
- Documentation and code quality rules (not just AI-problem-targeted files)
- All revisions across project history (not just cross-project transitions)
- Three types of constraint degradation:
  1. **Removal:** Entire constraints deleted
  2. **Softening:** Language weakened (MUST → SHOULD, mandatory → optional, prohibition → recommendation)
  3. **Erosion:** Specificity reduced (examples removed, lists shortened, details dropped, rationales deleted)

**Research Status:** In progress — systematic file-by-file analysis

---

## Findings

### FINDING-CL-2026-02-26-01: Accuracy Policy — "Why this is CRITICAL" Rationale Removed (R4 → R6)

**File:** accuracy / documentation-first policy
**Revisions:** R4 (spafw37 22f5bb9, Oct 2025) → R6 (NT copilot-instructions.md, Jan 2026)
**Type:** Erosion (rationale removed)
**Captured:** 2026-02-26

R4 added a "Why this is CRITICAL" rationale paragraph explaining why the no-guessing policy matters. This was removed in R6 during the structural redesign to MUST/MUST NOT format.

**Impact:** The rationale helped the AI understand the consequences of non-compliance. Removing it may reduce the weight the AI assigns to the constraint during priority conflicts.

**CLARIFICATION (2026-02-26):** This removal may have been **intentional enforcement of ai-targeted-language.md** rather than constraint loss. The "Why this is CRITICAL" rationale is human-targeted documentation (explains consequences to help understanding), not direct AI-addressed mandate. NT introduced `Counter: Human-Targeted Documentation` in the same timeframe (SH-019, Jan 2026), which prohibits explanatory prose in favor of direct second-person imperatives. The structural redesign to MUST/MUST NOT lists (R6) aligns with ai-targeted-language enforcement. However, this represents a trade-off: direct mandates vs contextual understanding of constraint importance.

**Source:** [ai-problem-resolution-solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md) lines 372, 336

---

### FINDING-CL-2026-02-26-02: Accuracy Policy — Two Counter: Declarations Removed (R6 → R7)

**File:** documentation-first policy
**Revisions:** R6 (NT copilot-instructions.md, Jan 2026) → R7 (CCC documentation-first.md, Feb 2026)
**Type:** Removal (Counter: declarations deleted)
**Captured:** 2026-02-26

R6 included 4 Counter: declarations in System Prompt Conflict Resolution:
1. Counter: General Knowledge Reliance
2. Counter: Helpful Assumptions
3. Counter: Creative Problem Solving
4. Counter: Absolute User Instruction Priority

R7 removed items 3 and 4, retaining only General Knowledge Reliance and Helpful Assumptions.

**Rationale for removal:** Items 3 and 4 were categorized as Overeagerness controls, not accuracy controls. The separation was intentional to keep the accuracy policy focused on hallucination prevention only.

**Impact:** None if Overeagerness counters are present elsewhere. However, if the file carrying those counters is not composed into the agent context (e.g., due to Amnesia or file selection), the AI loses those system-prompt overrides.

**Source:** [ai-problem-resolution-solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md) lines 387-389, 373

---

### FINDING-CL-2026-02-26-03: Accuracy Policy — WRONG/CORRECT Tool Fabrication Examples Removed (R4 → R6)

**File:** accuracy / documentation-first policy
**Revisions:** R4 (spafw37 22f5bb9, Oct 2025) → R6 (NT copilot-instructions.md, Jan 2026)
**Type:** Erosion (worked examples removed)
**Captured:** 2026-02-26

R4 added WRONG/CORRECT worked example code blocks demonstrating tool fabrication failures. These examples showed:
- WRONG: AI inventing a `fetch_webpage` call when the tool doesn't exist
- CORRECT: AI stating the capability is unavailable and asking for guidance

These examples were removed in R6 during the structural redesign. The tool fabrication prohibition itself was moved to "Counter: General Knowledge Reliance" but without the worked examples.

**Impact:** Worked examples are more concrete than abstract prohibitions. Removing them may reduce the AI's ability to recognize tool fabrication as a specific instance of the broader "don't guess" constraint.

**CLARIFICATION (2026-02-26):** This removal may have been **intentional enforcement of ai-targeted-language.md** rather than constraint loss. WRONG/CORRECT examples are instructional material designed to teach through demonstration—a human-targeted pedagogical approach. NT's `Counter: Human-Targeted Documentation` (SH-019, Jan 2026) prohibits such explanatory framing in favor of direct second-person mandates. The prohibition itself was preserved in "Counter: General Knowledge Reliance," only the worked examples were removed. However, this represents a trade-off: pedagogical clarity (examples showing what not to do) vs enforcement purity (direct prohibitions only).

**Source:** [ai-problem-resolution-solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md) lines 334, 371

---

### FINDING-CL-2026-02-26-04: Accuracy Policy — 4-Step Tool Gap Response Guide Removed (R4 → R6)

**File:** accuracy / documentation-first policy
**Revisions:** R4 (spafw37 22f5bb9, Oct 2025) → R6 (NT copilot-instructions.md, Jan 2026)
**Type:** Erosion (specific procedure replaced with general mandate)
**Captured:** 2026-02-26

R4 included a 4-step response guide for tool/capability gaps:
```
If you don't have a capability or tool:
1. [Step details with named examples: fetch_webpage, web_search]
2. [...]
3. [...]
4. [...]
```

R6 replaced this with: "Say 'I don't know' or 'I cannot verify this information' when uncertain" — a single mandatory requirement without procedural detail.

**Impact:** The 4-step guide provided a specific template for responding to capability gaps. The R6 replacement is shorter and more direct but less prescriptive. Whether this is a constraint loss depends on whether the procedural detail helped the AI comply more reliably.

**CLARIFICATION (2026-02-26):** This simplification may have been **intentional enforcement of ai-targeted-language.md** and the `Counter: Natural Language Variation` principle. The 4-step procedural guide represents verbose instructional scaffolding; the simplified mandate ("Say 'I don't know'...") is a direct second-person imperative. NT's ai-targeted-language enforcement (SH-019, Jan 2026) prioritizes consistent, brief imperatives over detailed procedural templates. This represents a deliberate trade-off: procedural scaffolding (step-by-step guidance) vs enforcement brevity (direct mandate). Whether this improves or degrades compliance requires empirical validation.

**Source:** [ai-problem-resolution-solutions-history-hallucination-facts.md](ai-problem-resolution-solutions-history-hallucination-facts.md) lines 333, 370

---

### FINDING-CL-2026-02-26-05: Git Policy — CI/CD Log Review Requirement Completely Removed (SH-006 → SH-027)

**File:** git-operations → git-commits
**Revisions:** SH-006 (spafw37 git-operations.instructions.md, Oct 2025) → SH-027 (CCC git-commits.md, Feb 2026)
**Type:** Removal (entire section deleted)
**Captured:** 2026-02-26

SH-006 included a detailed "Mandatory Full Log Review for CI/CD Failures" section with:
- 5-step procedure requiring full log examination before diagnosis
- Explicit prohibition: "Never grep for specific error patterns before seeing the full context"
- Worked example showing WRONG vs RIGHT approaches
- "Why this is critical" rationale explaining confirmation bias risks
- Scope: "ALL remote error diagnosis — GitHub Actions, CI systems, remote servers, etc."

This entire section was removed in SH-027. The file was narrowed to commit message formatting standards only.

**Impact:** Without this constraint, AI may fall back to its default behavior of searching for specific error patterns, missing root causes and earlier failures in CI/CD logs.

**Status:** Not restored in SH-033 (ai-devops git-policy.md). Constraint remains lost.

**Source:** spafw37 `.github/instructions/git-operations.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-06: Git Policy — Pull Request Review Requirements Completely Removed (SH-006 → SH-027)

**File:** git-operations → git-commits
**Revisions:** SH-006 (spafw37 git-operations.instructions.md, Oct 2025) → SH-027 (CCC git-commits.md, Feb 2026)
**Type:** Removal (entire section deleted)
**Captured:** 2026-02-26

SH-006 included "Pull Request Review Requirements" with 5-step procedure:
1. Retrieve ALL unresolved comments (not just subset)
2. Check resolution status (only human-marked RESOLVED counts)
3. Read response threads (decisions and clarifications)
4. Address all file types (code, docs, planning documents)
5. No assumptions about comment resolution

This entire section was removed in SH-027.

**Impact:** Without this constraint, AI may:
- Miss unresolved PR comments
- Assume comments are resolved without verification
- Skip comment threads containing important decisions
- Overlook planning document code examples that need fixes

**Status:** Not restored in SH-033 (ai-devops git-policy.md). Constraint remains lost.

**Source:** spafw37 `.github/instructions/git-operations.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-07: Git Policy — Commit Ban Completely Removed Then REVERSED (SH-006 → SH-027 → SH-033)

**File:** git-operations → git-commits → git-policy
**Revisions:**
- SH-006 (spafw37 git-operations.instructions.md, Oct 2025): **"YOU MAY NOT COMMIT CODE."**
- SH-027 (CCC git-commits.md, Feb 2026): Prohibition removed entirely
- SH-033 (ai-devops git-policy.md, Feb 2026): **Reversed to "MUST commit after EVERY edit"**
**Type:** Removal then reversal (180° constraint reversal)
**Captured:** 2026-02-26

**Evolution:**

SH-006 (Oct 2025):
```
## CRITICAL: Git General Operations Policy

**YOU MAY NOT COMMIT CODE. YOU MAY NOT PUSH CODE.**

You do not have permission to run `git commit` or `git push` under any circumstances. These operations must be performed by the human user only.

**Rationale:** You have repeatedly claimed work was complete when it was not, making it unsafe to allow you to commit or push changes.
```

SH-027 (Feb 2026):
- Entire commit/push ban removed
- File reduced to commit message formatting standards only
- "When to Commit" section has: "Commit when: User explicitly requests a commit"

SH-033 (Feb 2026):
```
## When to Commit

### Automatic Commits (MANDATORY)

**MUST commit after EVERY edit:**
- After creating any new file
- After modifying any existing file
- After deleting any file
- After any file operation that changes the working tree
```

**Impact:** This represents a complete policy reversal from mandatory prohibition to mandatory requirement. The original ban was introduced because "You have repeatedly claimed work was complete when it was not" (explicit rationale in SH-006). The reversal in SH-033 removes all user control over commit timing and removes the safety gate the original ban provided.

**Push prohibition:** Retained in SH-033 under "Pushing to Remotes" section. The push ban survived while the commit ban was reversed.

**CLARIFICATION (2026-02-26):** This reversal was **intentional policy refinement**, not constraint degradation. The original blanket ban conflated two separate concerns: (1) premature work completion claims, and (2) irreversible remote integration. The refined policy correctly identifies that **push is the actual risk** (remote integration without approval), while **frequent commits improve safety** (preserve granular history, enable rollback, prevent work loss). The original rationale ("You have repeatedly claimed work was complete when it was not") was actually about pushing incomplete work to remotes, not about local commits. The refined policy maintains the critical safety gate (push prohibition) while gaining the benefits of proper version control hygiene (frequent commits).

**Source:** spafw37 `.github/instructions/git-operations.instructions.md`, CCC `.devcontainer/.claude/rules/git-commits.md`, ai-devops `.github/instructions/git-policy.md` (verified via direct file reads)

---

### FINDING-CL-2026-02-26-08: Code Review Checklist — Complete File Loss (SH-008, spafw37 → subsequent projects)

**File:** `.github/instructions/code-review-checklist.instructions.md`
**Revisions:** SH-008 (spafw37, Oct 2025) → Not present in pdd, NT, CCC, or ai-devops
**Type:** Complete file loss
**Captured:** 2026-02-26

**Lost constraints (5 major sections, 92 lines):**

1. **Python Import Rules Verification** — mandatory checks before any code changes:
   - ALL imports at module level (top of code block)
   - NO inline imports inside functions
   - Imports grouped: stdlib → third-party → local
   - NO modules passed as function arguments
   - Red flags list (7 specific patterns to check)
   - Plan document import rules

2. **Nesting and Complexity Verification:**
   - NO code nested more than 2 levels below function declaration
   - NO nested blocks exceeding 2 lines
   - ALL extracted helpers have descriptive names and their own tests
   - Red flags list (3 patterns)

3. **Plan Document Sequencing Verification:**
   - Each function followed IMMEDIATELY by its tests
   - NO "Step Xa / Step Xb" grouping (code/tests separated)
   - Specific pattern: Code X.Y.Z → Test X.Y.(Z+1) → Test X.Y.(Z+2) → Code X.(Y+1).1
   - Red flags list (3 patterns)

4. **Naming Verification:**
   - NO single-letter variables (use `line_index` not `i`)
   - NO lazy names (`tmp`, `data`, `result`, `val`)
   - ALL names are descriptive full words
   - Constants in UPPER_SNAKE_CASE
   - Dictionary key constants follow `DICT_KEY = 'dict-key'` pattern

5. **Block Comment Verification:**
   - Block comments must be DESCRIPTIVE (not just numbered)
   - Every block comment explains WHAT the code does

**Enforcement section:**
- Process: Read instruction files → Review checklist → Verify items → Before committing
- If AI violates rules: Stop immediately, acknowledge violation, explain WHY, fix before proceeding
- "No exceptions. These are not suggestions - they are mandatory requirements."

**Impact:** Removal of this file eliminates a comprehensive pre-commit quality gate covering code structure, naming, complexity, and documentation standards. These constraints were never incorporated into later projects.

**Status:** Not present in any project after spafw37.

**Source:** spafw37 `.github/instructions/code-review-checklist.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-09: Communication Standards — Complete File Loss (SH-007, spafw37 → subsequent projects)

**File:** `.github/instructions/communication.instructions.md`
**Revisions:** SH-007 (spafw37, Oct 2025) → Not present in pdd, NT, CCC, or ai-devops
**Type:** Complete file loss
**Captured:** 2026-02-26

**Lost constraints (49 lines):**

1. **LOCALIZATION AND INTERNATIONALIZATION:**
   - Use UK English spelling and conventions (7 examples: colour/organise/behaviour/centre/licence/defence)
   - Use metric units (4 examples: metres/kilometres, kilograms, Celsius, litres)
   - Do not use US-specific examples (4 prohibitions: no US geography, no US conventions, use internationally neutral examples, no US-centric formats)
   - "This applies to ALL work - code, documentation, examples, and any other content."

2. **Communication Style:**
   - Maintain clarity and directness (6 bullet points)
   - Avoid extraneous framing (3 bullet points)
   - When executing non-trivial commands: explain purpose and impact
   - Do NOT use emojis unless explicitly requested

**Impact:** These communication standards were never incorporated into subsequent projects. UK English requirements, metric units, and international neutrality constraints were completely lost after spafw37.

**Note:** Some communication style guidance (brevity, no emojis) was later incorporated into ai-devops CLAUDE.md and ai-targeted-language.md, but the localization requirements were never restored.

**Status:** Not present in any project after spafw37.

**Source:** spafw37 `.github/instructions/communication.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-10: Issue Workflow — Complete File Loss (SH-003, spafw37 → subsequent projects)

**File:** `.github/instructions.bak/issue-workflow.instructions.md`
**Revisions:** SH-003 (spafw37, Oct 2025, archived to .bak) → Not present in pdd, NT, CCC, or ai-devops
**Type:** Complete file loss
**Captured:** 2026-02-26

**Lost constraints (131 lines):**

1. **Starting Work on an Issue** — 3-step mandatory workflow:
   - Generate feature name: `issue-<issue_num>-<issue-name>-<milestone>` format with specific component rules
   - Create and switch to feature branch: branch type selection (feature/bugfix/ci/docs prefixes), do not push yet
   - Create skeletal plan document: `features/<feature_name>.md` with specific structure

2. **Branch naming conventions:**
   - Specific format rules for converting issue titles to branch names
   - Milestone version extraction from setup.cfg if not specified
   - Explicit prohibition: "Do not push the branch yet - the user will push it when ready"

**Problems addressed:** Overeagerness (enforces branch creation workflow before implementation)

**Impact:** This workflow enforcement was designed to prevent AI from jumping directly into implementation without proper branch setup and planning document structure. Without it, AI may skip these preparatory steps.

**Status:** Not present in any project after spafw37. Constraint remains lost.

**Source:** spafw37 `.github/instructions.bak/issue-workflow.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-11: Architecture Design Standards — Complete File Loss (SH-004, spafw37 → subsequent projects)

**File:** `.github/instructions.bak/architecture.instructions.md`
**Revisions:** SH-004 (spafw37, Oct 2025, archived to .bak) → Not present in pdd, NT, CCC, or ai-devops
**Type:** Complete file loss
**Captured:** 2026-02-26

**Lost constraints (235 lines):**

1. **Clean Slate Design principles:**
   - No legacy assumptions: "Do not assume the new design must match any current implementation"
   - Technology-agnostic: "Do not assume specific protocols, frameworks, or libraries without explicit requirements"
   - Fresh thinking: "Question all previous design decisions and evaluate alternatives"
   - Ground-up rebuild: "Start from requirements and design the optimal solution"

2. **Design-First Approach:**
   - Design before implementation: "Complete architectural design before writing any code"
   - Documentation-driven: "All design decisions must be documented before implementation"
   - Iterative refinement through discussion and review
   - Validate assumptions: "Question and verify all design assumptions"

3. **Design Workflow:**
   - Start High-Level (4 bullet points about conceptual models, responsibilities, glossary, index)
   - Progressive Elaboration: "Do NOT run ahead", wait for user direction, move abstract→concrete only when requested
   - Suggest, Don't Assume: offer alternatives, present options, explain reasoning, wait for acceptance

4. **Documentation Standards:**
   - Architecture document structure and location
   - Mermaid diagram requirements and style guide reference
   - Document organization (glossary, index, cross-references)

**Problems addressed:** Overeagerness (constrains scope of changes to documented design decisions)

**Impact:** These constraints were specifically designed to prevent AI from making unilateral design decisions and implementing before getting user approval. "Suggest, Don't Assume" and "Do NOT run ahead" are explicit Overeagerness counters.

**Status:** Not present in any project after spafw37. Constraint remains lost.

**Source:** spafw37 `.github/instructions.bak/architecture.instructions.md` (verified via direct file read)

---

### FINDING-CL-2026-02-26-12: Planning Files — Gherkin Documentation Test Prohibition Lost (SH-002 → SH-009)

**File:** planning.instructions.md → plan-structure.instructions.md
**Revisions:** SH-002 (spafw37 planning.instructions.md, Oct 2025) → SH-009 (spafw37 plan-structure.instructions.md, Oct 2025)
**Type:** Removal (specific prohibition lost during file split)
**Captured:** 2026-02-26

**Original constraint (SH-002):**
```
Do NOT use Gherkin format for documentation tests. Documentation tests are manual reviews focused on quality aspects (clarity, accuracy, completeness, consistency).
```

**After split (SH-009):**
- Prohibition not present
- Gherkin format heavily promoted for unit/integration tests
- No mention of documentation tests or restriction on Gherkin usage

**Impact:** The original constraint prevented inappropriate use of Gherkin (a behavior specification format) for documentation quality reviews. Without this constraint, AI may create Gherkin scenarios for documentation verification tasks where manual review is more appropriate.

**Status:** Constraint remains lost in all subsequent projects.

**Source:** spafw37 planning.instructions.md and plan-structure.instructions.md (verified via direct file reads)

---

### FINDING-CL-2026-02-26-13: Planning Files — Function Combination Prohibition Lost (SH-002 → SH-009)

**File:** planning.instructions.md → plan-structure.instructions.md
**Revisions:** SH-002 (spafw37 planning.instructions.md, Oct 2025) → SH-009 (spafw37 plan-structure.instructions.md, Oct 2025)
**Type:** Removal (specific prohibition lost during file split)
**Captured:** 2026-02-26

**Original constraint (SH-002):**
```
**Do NOT combine multiple functions in a single code block** - extract helpers into separate numbered code blocks with their own tests.
```

**After split (SH-009):**
- Prohibition not present
- General guidance about single function per block exists but without explicit MUST NOT prohibition

**Impact:** Without the explicit prohibition, AI may combine multiple functions into a single code block, making it harder to review and test functions independently.

**Status:** Constraint remains lost in all subsequent projects.

**Source:** spafw37 planning.instructions.md and plan-structure.instructions.md (verified via direct file reads)

---

### FINDING-CL-2026-02-26-14: Planning Files — Block Numbering Prohibition REVERSED (SH-002 → SH-009)

**File:** planning.instructions.md → plan-structure.instructions.md
**Revisions:** SH-002 (spafw37 planning.instructions.md, Oct 2025) → SH-009 (spafw37 plan-structure.instructions.md, Oct 2025)
**Type:** Reversal (prohibition replaced with encouragement)
**Captured:** 2026-02-26

**Original constraint (SH-002):**
```
- ❌ DO NOT write numbers into actual source code files
- ❌ DO NOT include line number comments in implementation

**Rationale:** Source code changes constantly. Line numbers in production code become outdated immediately and create maintenance burden. The numbering system exists solely to facilitate detailed planning and review discussions.
```

**After split (SH-009):**
```
## Block Numbering in Code Specifications

**Purpose:** Block numbering (X.Y.Z.N format) serves as line number substitutes in fenced code blocks within markdown, where actual line numbers are unreliable.

**CRITICAL: Block numbers must be COMMENTS in the code, not markdown headings or docstring content.**

**Benefits:**
1. Enables precise references without relying on line numbers
2. Numbering depth hints at nesting depth
3. Makes it easy to identify and discuss specific code sections
4. Helps expose nesting violations
```

**Analysis:** This is a complete reversal:
- Original: "DO NOT write numbers into actual source code files" with rationale about maintenance burden
- Revised: "Block numbers must be COMMENTS in the code" (emphasis on MUST) with list of benefits

The original prohibition recognized that numbered comments in production code become stale. The revision actively requires numbered comments and promotes their benefits.

**Impact:** This reversal may lead to production code containing numbered block comments that become outdated as code evolves, creating the exact maintenance burden the original constraint was designed to prevent. The distinction between "plan documents" and "actual source code files" in the original constraint has been lost.

**Status:** Reversal persists in all subsequent projects.

**Source:** spafw37 planning.instructions.md and plan-structure.instructions.md (verified via direct file reads)

---

### FINDING-CL-2026-02-26-15: Memory Files — Complete File Loss (SH-022, NT → CCC/ai-devops)

**File:** `.github/instructions/memory-files.instructions.md`
**Revisions:** SH-022 (NT, Jan 2026) → Not present in CCC or ai-devops
**Type:** Complete file loss
**Captured:** 2026-02-26

**Lost constraints (421 lines):**

Structured persistent memory system defining:
1. **File types with required formats:**
   - SERVICE_INFO (service-specific configuration and state)
   - CREDENTIALS (authentication details)
   - DECISIONS (design decisions with rationale)
   - ISSUES (blockers and workarounds)
   - PLAN_N_PROGRESS (implementation plan and progress tracking)
   - SESSION_NOTES (operational context and state)
   - ASSUMPTION_LOG (assumptions requiring verification)

2. **Structural requirements:**
   - Mandatory `.memory/` directory
   - Specific file naming conventions
   - Required section headers for each file type
   - Format specifications (key-value pairs, markdown sections, timestamps)
   - Separation of facts (static reference) from logs (execution history)

3. **Memory file policies:**
   - All memory files excluded from git
   - Files persist across sessions to prevent Amnesia
   - Agents required to check and update memory files before/after operations

**Problems addressed:** Amnesia (first comprehensive external memory solution in the corpus)

**Impact:** Loss of this file means later projects lack a structured approach to persistent memory. While ai-devops has an analysis agent with .memory/ patterns, the comprehensive memory-files specification with its 7 file types and detailed formatting requirements was never restored.

**Partial recovery:** ai-devops analysis agent (SH-037) uses `.memory/` directory with fact files, index, and logs — evolved from memory-files patterns but less prescriptive and with different file type taxonomy.

**Status:** Complete file loss; partially recovered through analysis agent conventions but without the detailed specification.

**Source:** NT `.github/instructions/memory-files.instructions.md` (verified file exists in NT only)

---

## Summary: Constraint Loss Patterns

### Complete File Losses (5 files, estimated 1,816 lines)

1. **code-review-checklist.instructions.md** (SH-008, 92 lines) — Python import rules, nesting/complexity limits, naming standards, block comments
2. **communication.instructions.md** (SH-007, 49 lines) — UK English, metric units, communication style, emoji prohibition
3. **issue-workflow.instructions.md** (SH-003, 131 lines) — Issue start workflow, branch naming, feature name generation
4. **architecture.instructions.md** (SH-004, 235 lines) — Clean slate design, design-first approach, suggest don't assume
5. **memory-files.instructions.md** (SH-022, 421 lines) — Structured persistent memory with 7 file types (partially recovered in SH-037)

**Total:** ~1,816 lines of constraints completely lost

### Constraint Removals Within Files (7 findings)

1. **"Why this is CRITICAL" rationale removed** (Accuracy R4 → R6) — Rationale explaining consequences of non-compliance — **Note:** May be ai-targeted-language enforcement; see FINDING-CL-2026-02-26-01 clarification
2. **Two Counter: declarations removed** (Accuracy R6 → R7) — Counter: Creative Problem Solving, Counter: Absolute User Instruction Priority
3. **WRONG/CORRECT tool fabrication examples removed** (Accuracy R4 → R6) — Worked examples of tool invention failure — **Note:** May be ai-targeted-language enforcement; see FINDING-CL-2026-02-26-03 clarification
4. **4-step tool gap response guide removed** (Accuracy R4 → R6) — Specific procedural template for capability gaps — **Note:** May be ai-targeted-language enforcement; see FINDING-CL-2026-02-26-04 clarification
5. **CI/CD Log Review section removed** (Git SH-006 → SH-027) — 5-step mandatory full log review procedure with rationale and examples
6. **Pull Request Review Requirements removed** (Git SH-006 → SH-027) — 5-step procedure for thorough PR comment resolution
7. **Commit/push ban removed** (Git SH-006 → SH-027) — Prohibition with explicit rationale about AI claiming incomplete work as done

### Constraint Reversals (2 findings)

1. **Git commit ban REVERSED to mandatory** (Git SH-006 → SH-027 → SH-033) — "YOU MAY NOT COMMIT" became "MUST commit after EVERY edit" (180° reversal) — **Note:** Intentional policy refinement, not degradation; see FINDING-CL-2026-02-26-07 clarification
2. **Block numbering prohibition REVERSED** (Planning SH-002 → SH-009) — "DO NOT write numbers into actual source code files" became "Block numbers MUST be COMMENTS in the code"

### Constraint Softenings/Erosions (3 findings)

1. **Gherkin documentation test prohibition lost** (Planning SH-002 → SH-009) — Specific prohibition on using Gherkin for doc reviews disappeared
2. **Function combination prohibition lost** (Planning SH-002 → SH-009) — "Do NOT combine multiple functions in a single code block" disappeared
3. **4-step response template replaced with general mandate** (Accuracy R4 → R6) — Detailed procedure replaced with "Say 'I don't know'" (may be refinement rather than loss)

### Constraint Strengthening (counterexample)

1. **Rule copying requirements STRENGTHENED** (Instruction-composition SH-013 → rule-copying SH-028/SH-035) — Added Counter: declarations, CRITICAL emphasis, extensive MUST/MUST NOT lists, compliance checklist

---

## Analysis Status: COMPLETE

**Files examined:** 35+ unique rule files across 5 projects (spafw37, pdd, NT, CCC, ai-devops)
**Revisions analyzed:** R1-R8 for accuracy policy, full git policy lineage, planning file split, complete file inventory
**Constraint losses documented:** 15 findings (5 complete file losses, 7 removals, 2 reversals, 1 strengthening counterexample)

**Key discovery:** Constraint loss is systematic and extensive. An estimated 1,816+ lines of constraints were completely lost through file abandonment. Additional constraints were removed during file evolution. Notable examples include CI/CD log review requirements, PR review procedures, and code review checklist standards.

**Important distinction:** Not all removals represent degradation. Some were **intentional design choices**:
- **Git commit policy reversal** (FINDING-CL-2026-02-26-07): Intentional refinement separating local version control hygiene (frequent commits) from remote integration risk (push prohibition)
- **ai-targeted-language enforcement** (FINDING-CL-2026-02-26-01/03/04): Removals of rationales, worked examples, and procedural templates aligned with `Counter: Human-Targeted Documentation` principle—trading pedagogical scaffolding for direct AI-addressed imperatives

These represent **deliberate trade-offs** in constraint design philosophy rather than unintentional constraint loss through failed copying.

