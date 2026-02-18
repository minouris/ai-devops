# Rules Evolution Analysis: Problem-Solving Patterns Across Projects

## Table of Contents

- [Executive Summary](#executive-summary)
- [Methodology](#methodology)
- [Current State: ai-devops Rules](#current-state-ai-devops-rules)
- [Historical State: Source Projects Rules](#historical-state-source-projects-rules)
- [Problems Solved by Rules Evolution](#problems-solved-by-rules-evolution)
- [Problems No Longer Being Solved](#problems-no-longer-being-solved)
- [New Problems Being Solved](#new-problems-being-solved)
- [Evolution Path: spafw37 → PDD → nightingale-truenas → claude-code-container → ai-devops](#evolution-path-spafw37--pdd--nightingale-truenas--claude-code-container--ai-devops)
- [Conclusions: Problem-Solving Gaps](#conclusions-problem-solving-gaps)

---

## Executive Summary

This analysis traces how rules evolved across projects (spafw37 → prompt-driven-development → nightingale-truenas → claude-code-container → ai-devops) to solve specific AI development pitfalls, and identifies which problems we've stopped solving.

**Problem-Solving Evolution:**
- **spafw37**: Established domain standards (accuracy, communication, git, code review) + planning workflow
- **PDD**: Added composition patterns for portability + meta-level organization
- **nightingale-truenas**: Solved "vibe coding" (memory-files) + context overflow (step-files)
- **claude-code-container**: Consolidated meta-instructions + design documentation
- **ai-devops**: Added documentation standards + reference validation + selective loading

**Problems We've Stopped Solving:**
- Quality verification (lost accuracy.instructions.md)
- User communication standards (lost communication.instructions.md)
- Full git workflow (only git-policy.md remains)
- Code review quality (lost code-review-checklist.instructions.md)
- "Vibe coding" prevention (lost memory-files.instructions.md)
- Context overflow via self-contained steps (lost step-files.instructions.md)
- Plan structure guidance (lost plan-files.instructions.md, plan-structure.instructions.md)
- Cross-platform portability (lost composition patterns)
- Structural guidance (lost instruction-files.instructions.md, prompt-files.instructions.md)

[↑ Back to top](#table-of-contents)

---

## Methodology

This analysis traces problem-solving patterns through rule evolution:
1. Identify problems each project's rules were designed to solve
2. Track how solutions evolved across projects: spafw37 → PDD → nightingale-truenas → claude-code-container → ai-devops
3. Identify which problems we've stopped solving (missing rules)
4. Identify new problems being solved (new rules)

Sources referenced:
- [analysis.md](analysis.md) - Project analysis documenting source project artifacts and issues
- [recommendations.md](recommendations.md) - Import recommendations
- Current ai-devops instruction files (13 files)
- Source project instruction files documented in analysis.md

Focus: **What problems do rules solve, and how have those solutions evolved?**

[↑ Back to top](#table-of-contents)

---

## Current State: ai-devops Rules

### Current Instruction Files (13 total)

1. **ai-targeted-language.md** - AI-targeted language standards
2. **design-documents.md** - Design document standards
3. **document-navigation.md** - Navigation requirements for documentation
4. **document-structure.md** - Document structure requirements
5. **documentation-first.md** - Documentation-first response requirements
6. **documentation-standards.md** - Language and tone standards (UK English, etc.)
7. **git-policy.md** - Git commit standards
8. **markdown-formatting.md** - Markdown formatting standards
9. **mermaid-diagrams.md** - Mermaid diagram standards
10. **reference-items.md** - Reference items format (FACT-N, PROB-N, etc.)
11. **rule-copying.md** - Rule copying requirements
12. **rule-embedding.md** - Rule embedding standards for skills and agents
13. **section-numbering.md** - Section numbering standards

### Current Copilot Instructions

File: `.github/copilot-instructions.md`

Contains:
- System Prompt Conflict Resolution sections
- Documentation-First Response Requirements
- Git Commit Standards
- Compliance Verification checklists

[↑ Back to top](#table-of-contents)

---

## Historical State: Source Projects Rules

### From spafw37 (9 instruction files)

According to [analysis.md](analysis.md#60-91):

1. **accuracy.instructions.md** - Quality standards
2. **code-review-checklist.instructions.md** - Review standards
3. **communication.instructions.md** - How to interact with users
4. **git-operations.instructions.md** - Version control best practices
5. **plan-structure.instructions.md** - Plan structure standards
6. **planning-workflow.instructions.md** - Planning workflow instructions
7. **python-tests.instructions.md** - Python testing standards
8. **python.instructions.md** - Python coding standards
9. **python37.instructions.md** - Python 3.7 specific standards

**Key Rules:**
- Accuracy and quality verification
- Communication style with users
- Git workflow and operations
- Plan structure and organization
- Multi-step planning workflow (8-step process)
- Python-specific coding standards

### From prompt-driven-development (9+ instruction files)

According to [analysis.md](analysis.md#113-143):

1. **accuracy.instructions.md**
2. **actions.instructions.md**
3. **agents.instructions.md**
4. **doc.instructions.md**
5. **instruction-composition.instructions.md** - How to combine instructions
6. **instructions.instructions.md** - Meta-instructions about instructions
7. **prompt-composition.instructions.md** - How to combine prompts
8. **prompts.instructions.md** - How to write prompts
9. **rules.instructions.md** - Guardrail system

**Key Rules:**
- Composition patterns for modular instructions
- Meta-level instruction definitions
- Prompt structure and composition
- Agent definition standards
- Action definition standards

### From claude-code-container (7+ instruction files)

According to [analysis.md](analysis.md#165-190):

1. **design-diagrams.instructions.md** - Visual documentation standards
2. **design-docs.instructions.md** - Design documentation standards
3. **instruction-files.instructions.md** - **How to write instruction files**
4. **markdown-formatting.instructions.md** - Markdown formatting standards
5. **plan-files.instructions.md** - **How to structure plans**
6. **prompt-files.instructions.md** - **How to write prompt files**
7. **step-files.instructions.md** - **How to write self-contained step prompts with policy**

**Key Rules:**
- Meta-instructions for creating instruction files
- Plan file structure standards
- Prompt file structure standards
- **Step file standards (critical discovery)**
- Design documentation standards
- Visual documentation with diagrams

### From nightingale-truenas (5 instruction files)

According to [analysis.md](analysis.md#213-227):

1. **instruction-files.instructions.md** - How to write instruction files
2. **memory-files.instructions.md** - **Memory-based approach to avoid "vibe coding"**
3. **plan-files.instructions.md** - How to structure plans
4. **prompt-files.instructions.md** - How to write prompt files
5. **step-files.instructions.md** - **Step files as self-contained prompts with policy**

**Key Rules:**
- Simplified, focused instruction paradigm
- Memory file standards for capturing decisions
- Step-based execution with self-contained prompts
- Fact verification before implementation

[↑ Back to top](#table-of-contents)

---

## Problems Solved by Rules Evolution

### Problem 1: Quality and Accuracy Verification

**Problem**: AI hallucination, inaccurate outputs, lack of fact-checking

**Solution Evolution:**
- **spafw37**: `accuracy.instructions.md` - Quality standards, accuracy verification, fact-checking, citation requirements
- **PDD**: Maintained `accuracy.instructions.md` with refinements
- **ai-devops**: Partially embedded in `documentation-first.md` - citation requirements, documentation source priority, "no speculation" mandate

**Current State**: Comprehensive quality standards from spafw37 **no longer present as standalone file**

### Problem 2: User Communication and Interaction

**Problem**: Inconsistent AI communication style, unclear progress updates, poor error reporting

**Solution Evolution:**
- **spafw37**: `communication.instructions.md` - Communication style, question asking, clarification requests, progress updates, error reporting
- **Subsequent projects**: Maintained in various forms
- **ai-devops**: **NOT PRESENT**

**Current State**: User interaction standards **completely absent**

### Problem 3: Version Control Consistency

**Problem**: Inconsistent git practices, poor commit messages, unclear branching

**Solution Evolution:**
- **spafw37**: `git-operations.instructions.md` - Branch naming, commit workflow, PR procedures, merge strategies, conflict resolution
- **ai-devops**: `git-policy.md` - **Narrowed to only commit messages**, added Co-Authored-By prohibition, added anti-push directive

**Current State**: **Scope significantly reduced** - full git workflow lost, only commit message standards remain

### Problem 4: Code Quality Assurance

**Problem**: Inconsistent code review, missing quality checks

**Solution Evolution:**
- **spafw37**: `code-review-checklist.instructions.md` - Review checklist, quality criteria, testing requirements, documentation verification
- **Subsequent projects**: Maintained in various forms
- **ai-devops**: **NOT PRESENT**

**Current State**: Code review standards **completely absent**

### Problem 5: Context Overflow (Critical AI Pitfall)

**Problem**: Large plans push out instructions during implementation (spafw37 Issue #68), causing implementation errors

**Solution Evolution:**
- **spafw37**: Identified problem (Issue #68, #93) - plans too large, pushing out instructions during Step 8
- **PDD**: Issue #75 research - "Focused Task Files vs. Automatic Instruction Loading" identified automatic loading as problematic
- **nightingale-truenas**: `step-files.instructions.md` - **Self-contained step prompts with embedded policy** to avoid loading all instructions
- **ai-devops**: `rule-embedding.md` - **Selective instruction loading**, rule selection matrix, context budget management

**Current State**: **Partial solution** - selective loading addressed, but self-contained step approach **lost**

### Problem 6: "Vibe Coding" / Implicit Decisions

**Problem**: Decisions made implicitly during design without explicit documentation

**Solution Evolution:**
- **nightingale-truenas**: `memory-files.instructions.md` - Capture decisions and research in preliminary files BEFORE formal planning, fact distillation for design phase
- **ai-devops**: **NOT PRESENT**

**Current State**: Design process decision capture **completely absent**

### Problem 7: Plan Structure Consistency

**Problem**: Inconsistent plan organization, unclear structure

**Solution Evolution:**
- **spafw37**: `plan-structure.instructions.md`, `planning-workflow.instructions.md` - Required sections, organization patterns, 8-step workflow
- **claude-code-container**: `plan-files.instructions.md` - Consolidated plan file standards
- **nightingale-truenas**: `plan-files.instructions.md` - Simplified plan standards for final implementation stage
- **ai-devops**: **NOT PRESENT**

**Current State**: Plan structure guidance **completely absent**

### Problem 8: Cross-Platform Portability and Modularity

**Problem**: Rules tied to specific platforms, difficulty porting

**Solution Evolution:**
- **PDD**: `instruction-composition.instructions.md`, `prompt-composition.instructions.md` - Composition patterns, modular design, reusability
- **PDD**: `rules.instructions.md` - Guardrail system standards
- **ai-devops**: **NOT PRESENT**

**Current State**: Composition patterns and portability **completely absent**

### Problem 9: Documentation Inconsistency

**Problem**: Inconsistent markdown, missing navigation, unclear formatting

**Solution Evolution:**
- **simbox**: Early markdown and mermaid instructions
- **Refined through projects**: Markdown formatting improved
- **ai-devops**: **Significantly expanded**:
  - `documentation-standards.md` - UK English, tone, terminology
  - `markdown-formatting.md` - Fenced code blocks, filename conventions
  - `mermaid-diagrams.md` - Diagram standards, colour schemes
  - `document-navigation.md` - ToC, back-to-top links
  - `document-structure.md` - Organization requirements
  - `design-documents.md` - Design doc vs plan file distinction

**Current State**: **Most comprehensive solution across all projects**

### Problem 10: Structural Guidance for Artifact Creation

**Problem**: Unclear how to create instruction files, prompt files, plan files, step files

**Solution Evolution:**
- **claude-code-container**: `instruction-files.instructions.md`, `prompt-files.instructions.md`, `plan-files.instructions.md`, `step-files.instructions.md`
- **nightingale-truenas**: Maintained same files with simplified focus
- **ai-devops**: **NOT PRESENT**

**Current State**: Meta-instructions for artifact creation **completely absent** (note: these are guard rails, use not guaranteed)

### Problem 11: Reference Ambiguity

**Problem**: Unclear references, non-scriptable validation

**Solution Evolution:**
- **ai-devops**: `reference-items.md` - PREFIX-N format, table structure, HTML anchors, regex validation

**Current State**: **New solution unique to ai-devops**

### Problem 12: Rule Abbreviation When Embedding

**Problem**: AI summarizes rules when embedding them, losing critical detail

**Solution Evolution:**
- **ai-devops**: `rule-copying.md` - Verbatim copying requirement, anti-abbreviation directive, overrides system prompt brevity

**Current State**: **New solution unique to ai-devops**

[↑ Back to top](#table-of-contents)

---

## Problems No Longer Being Solved

### Quality Verification (Problem 1)

**Lost**: `accuracy.instructions.md` comprehensive quality standards

**Implication**: No systematic accuracy verification, fact-checking procedures, or quality criteria beyond what's embedded in documentation-first.md

### User Interaction (Problem 2)

**Lost**: `communication.instructions.md` user interaction standards

**Implication**: No guidance on communication style, progress updates, error reporting, question asking patterns

### Full Git Workflow (Problem 3)

**Lost**: Branch naming, PR procedures, merge strategies, conflict resolution from `git-operations.instructions.md`

**Retained**: Only git commit message standards in `git-policy.md`

**Implication**: Inconsistent git practices beyond commit messages

### Code Quality Assurance (Problem 4)

**Lost**: `code-review-checklist.instructions.md` review standards

**Implication**: No systematic code review criteria, quality checks, or testing verification

### Design Process Decision Capture (Problem 6)

**Lost**: `memory-files.instructions.md` for capturing decisions before formal planning

**Implication**: Risk of "vibe coding" - implicit decisions rather than explicit documentation during design phase

### Self-Contained Step Execution (Problem 5 - Partial)

**Lost**: `step-files.instructions.md` for self-contained prompts with embedded policy

**Retained**: `rule-embedding.md` for selective loading

**Implication**: Partial context overflow solution, but lost self-contained execution pattern

### Plan Structure Guidance (Problem 7)

**Lost**: `plan-files.instructions.md`, `plan-structure.instructions.md`, `planning-workflow.instructions.md`

**Implication**: No guidance for final implementation planning structure (note: these are final stage artifacts only)

### Cross-Platform Portability (Problem 8)

**Lost**: `instruction-composition.instructions.md`, `prompt-composition.instructions.md`, `rules.instructions.md`

**Implication**: Rules not modular for cross-platform use, limited extensibility

### Structural Artifact Guidance (Problem 10)

**Lost**: `instruction-files.instructions.md`, `prompt-files.instructions.md`

**Implication**: No meta-guidance on creating instructions/prompts (note: these are guard rails, use not guaranteed)

[↑ Back to top](#table-of-contents)

---

## New Problems Being Solved

### Reference Validation (Problem 11 - NEW)

**Solution**: `reference-items.md`

**Enables**: Scriptable validation, unambiguous linking, standardized reference format (FACT-N, PROB-N, etc.)

**Unique to ai-devops**: No precedent in source projects

### Section Numbering (NEW)

**Solution**: `section-numbering.md`

**Enables**: Hierarchical section references, cross-document linking, compact unambiguous references

**Unique to ai-devops**: No precedent in source projects

### Rule Abbreviation Prevention (Problem 12 - NEW)

**Solution**: `rule-copying.md`

**Enables**: Verbatim rule embedding, prevents summarization, overrides system brevity

**Unique to ai-devops**: No precedent in source projects

### Selective Context Loading (Problem 5 - NEW APPROACH)

**Solution**: `rule-embedding.md`

**Enables**: Context budget management, selective instruction loading, rule selection matrix

**Unique to ai-devops**: Different approach than nightingale-truenas's self-contained steps

### Documentation-First Enforcement (NEW FORMALIZATION)

**Solution**: `documentation-first.md`

**Enables**: Mandatory documentation consultation, citation requirements, explicit "no speculation" directive

**Evolution**: Formalizes accuracy requirements from spafw37, but more narrowly focused on documentation sources

### AI-Targeted Language Clarity (NEW FORMALIZATION)

**Solution**: `ai-targeted-language.md`

**Enables**: Second-person addressing, imperative mood, MUST/MUST NOT structure

**Evolution**: Likely existed implicitly, now formalized

[↑ Back to top](#table-of-contents)

---

## Evolution Path: spafw37 → PDD → nightingale-truenas → claude-code-container → ai-devops

### spafw37: Foundation (9 instruction files)

**Problems Solved:**
1. Quality verification → accuracy.instructions.md
2. User communication → communication.instructions.md
3. Git workflow → git-operations.instructions.md
4. Code review → code-review-checklist.instructions.md 5. Plan structure → plan-structure.instructions.md, planning-workflow.instructions.md
6. Python quality → python.instructions.md, python37.instructions.md, python-tests.instructions.md

**Problems Identified:**
- Context overflow (Issue #68) - plans too large push out instructions
- Feature-focused vs solution-focused prompts

### prompt-driven-development: Portability (9+ instruction files)

**Problems Solved:**
8. Cross-platform portability → instruction-composition, prompt-composition
9. Meta-organization → instructions.instructions, prompts.instructions, rules.instructions
10. Agent/action definition → agents.instructions, actions.instructions

**Problems Identified:**
- Automatic instruction loading problematic (Issue #75)
- Security concerns with prompt compilation

**Maintained from spafw37:**
- accuracy.instructions.md

### nightingale-truenas: Context Management (5 instruction files)

**Problems Solved:**
5. Context overflow (partial) → step-files.instructions.md (self-contained prompts with policy)
6. "Vibe coding" → memory-files.instructions.md (explicit decision capture before planning)
10. Structural guidance → instruction-files, prompt-files, plan-files, step-files

**Key Discovery**: Step files as self-contained prompts with embedded policy

**Simplified Focus**: Fewer files, structural organization emphasis

### claude-code-container: Consolidation (7+ instruction files)

**Problems Solved:**
9. Documentation (partial) → design-diagrams, design-docs, markdown-formatting
10. Structural guidance → instruction-files, prompt-files, plan-files, step-files

**Most up-to-date refinements** from all prior projects

**SDLC Framework**: Requirements → Analysis → Architecture → Design → Features → Plans → Steps

### ai-devops: Documentation & Validation (13 instruction files)

**Problems Solved:**
9. Documentation consistency (comprehensive) → documentation-standards, markdown-formatting, mermaid-diagrams, document-navigation, document-structure, design-documents
11. Reference validation (NEW) → reference-items
12. Rule abbreviation (NEW) → rule-copying
- Section numbering (NEW) → section-numbering
- Selective loading (NEW) → rule-embedding
- Documentation-first (formalized) → documentation-first
- AI-targeted language (formalized) → ai-targeted-language
3. Git commits (narrowed) → git-commits

**Problems NO LONGER Solved:**
1. Quality verification (lost accuracy.instructions.md)
2. User communication (lost communication.instructions.md)
3. Full git workflow (lost git-operations.instructions.md)
4. Code review (lost code-review-checklist.instructions.md)
5. Context overflow via steps (lost step-files.instructions.md)
6. "Vibe coding" (lost memory-files.instructions.md)
7. Plan structure (lost plan-files.instructions.md, plan-structure.instructions.md)
8. Cross-platform portability (lost composition patterns)
10. Structural guidance (lost instruction-files.instructions.md, prompt-files.instructions.md)

[↑ Back to top](#table-of-contents)

---

## Conclusions: Problem-Solving Gaps

### Summary: Problem-Solving Trade-Offs

**Gains:**
- **Documentation consistency**: Most comprehensive documentation standards across all projects
- **Reference validation**: New scriptable validation capability
- **Rule integrity**: Prevention of rule abbreviation during embedding
- **Selective loading**: New approach to context management

**Losses:**
- **Quality assurance**: Comprehensive accuracy verification and code review standards
- **User interaction**: Communication and progress reporting standards
- **Git practices**: Full workflow guidance beyond commit messages
- **Design process**: Decision capture mechanism ("vibe coding" prevention)
- **Context management**: Self-contained step execution pattern
- **Planning guidance**: Plan structure standards (final implementation artifacts)
- **Portability**: Composition patterns for cross-platform use
- **Meta-guidance**: Structural instructions for creating artifacts (guard rails)

### Critical Problem-Solving Gaps

**Gap 1: Quality Assurance Throughout Work**
- Lost: accuracy.instructions.md, code-review-checklist.instructions.md
- Impact: No systematic quality verification applying to all work phases

**Gap 2: Design Process Support**
- Lost: memory-files.instructions.md
- Impact: No explicit decision capture before formal planning, risk of "vibe coding"

**Gap 3: User Interaction Standards**
- Lost: communication.instructions.md
- Impact: Inconsistent communication, progress updates, error reporting

**Gap 4: Context Overflow - Incomplete Solution**
- Lost: step-files.instructions.md (self-contained prompts with policy)
- Retained: rule-embedding.md (selective loading)
- Impact: Partial solution only - selective loading helps, but lost self-contained execution

**Gap 5: Full Git Workflow**
- Lost: Most of git-operations.instructions.md
- Retained: git-policy.md only
- Impact: No branching, PR, merge, conflict resolution guidance

**Gap 6: Planning Guidance**
- Lost: plan-files.instructions.md, plan-structure.instructions.md, planning-workflow.instructions.md
- Impact: No structure for final implementation planning (note: final stage artifacts only)

**Gap 7: Extensibility and Portability**
- Lost: Composition patterns, modular instruction design
- Impact: Limited cross-platform portability, reduced extensibility

### Assessment: Evolution Focus Shift

**Source projects** (spafw37 → nightingale-truenas) focused on solving:
- Quality assurance
- Context overflow
- Design process support
- Planning workflow
- Cross-platform portability

**ai-devops** focused on solving:
- Documentation consistency (✓ comprehensive)
- Reference validation (✓ new capability)
- Selective context loading (✓ new approach)
- AI-targeted language formalization (✓ clarified)

**Trade-off**: Shifted from **process quality** to **documentation quality**

### Context Overflow: Multi-Faceted Problem

According to analysis.md, spafw37 Issue #68 identified context overflow as critical problem. Solutions evolved:

1. **spafw37**: Identified problem - plans too large push out instructions during implementation
2. **PDD Issue #75**: Automatic instruction loading problematic
3. **nightingale-truenas**: Self-contained step prompts with embedded policy
4. **ai-devops**: Selective instruction loading via rule-embedding.md

**Current state**: Partial solution
- ✓ Selective loading addresses one aspect
- ✗ Lost self-contained step approach
- ✗ Lost memory-based design process that prevents plan bloat

**Multi-faceted solution required**:
- Memory files for design phase (capturing decisions BEFORE plans) - **MISSING**
- Selective loading for relevant context only - **PRESENT**
- Self-contained steps with embedded policy - **MISSING**
- Modular plans for final implementation - **MISSING** (plan-files.instructions.md)

### Traceable Evolution Path

**Problem-solving progression**:

```
spafw37 (Oct 2025)
├─ SOLVED: Quality (accuracy, code review, git, communication)
├─ SOLVED: Planning structure
└─ IDENTIFIED: Context overflow (#68), feature-focus

prompt-driven-development (Dec 2025)
├─ SOLVED: Cross-platform portability (composition)
├─ SOLVED: Meta-organization
├─ IDENTIFIED: Automatic loading problematic (#75)
└─ MAINTAINED: Quality standards

nightingale-truenas (Jan 2026)
├─ SOLVED: Context overflow (step-files with policy)
├─ SOLVED: "Vibe coding" (memory-files)
├─ SIMPLIFIED: Structural focus
└─ VALIDATED: Plan→steps conversion successful

claude-code-container (Feb 16, 2026)
├─ SOLVED: Design documentation
├─ CONSOLIDATED: Meta-instructions (latest refinements)
└─ FRAMEWORK: Full SDLC vision

ai-devops (Feb 17, 2026)
├─ SOLVED: Documentation consistency (comprehensive)
├─ SOLVED: Reference validation (new)
├─ SOLVED: Rule abbreviation (new)
├─ SOLVED: Selective loading (new approach)
└─ LOST: Quality, communication, memory-files, step-files, composition
```

**Clear pattern**: Each project solved specific problems, but ai-devops focused on documentation/validation while **dropping process quality solutions**.

### Recommended Investigation

To understand problem-solving gaps, investigate:
1. Why were quality standards (accuracy, code review) dropped?
2. Why was memory-files.instructions.md (design process support) not imported?
3. Why was step-files.instructions.md (context overflow solution) not imported?
4. Why were composition patterns for portability not imported?
5. Was the shift from process quality to documentation quality intentional?

**Critical question**: Are we solving the right problems, or did we optimize for documentation while losing process quality?

[↑ Back to top](#table-of-contents)
