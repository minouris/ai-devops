# Project Handoff

**Last Updated:** 2026-02-18  
**Current State:** Custom agent systems research synthesized from claude-code-container. 8 new findings on Claude Code custom modes implementation.

---

## Environment

**Project:** ai-devops  
**Location:** /home/mnorr001/src/github/minouris/ai-devops  
**Purpose:** Unified AI-driven DevOps methodology framework - currently researching custom agent capability systems (Skills, Custom Agents, Custom Modes)

---

## Project Context

### Source Projects Analyzed
Five projects examined for rule evolution:
1. **spafw37** (Oct 2025) - Origin of plan-based approach, 9 instruction files
2. **prompt-driven-development** (Dec 2025) - Composition patterns, 9+ instruction files  
3. **nightingale-truenas** (Jan 2026) - Step-files discovery, memory-based approach, 5 instruction files
4. **claude-code-container** (Feb 2026) - Latest consolidation, 7+ instruction files; contains custom modes research documentation
5. **simbox** (Sept 2025) - Documentation format examples

**Research Focus Shift (Feb 18):** Session focused on synthesizing research about custom agent capability systems (Skills, Custom Agents, Custom Modes) from claude-code-container repository documentation.

### Current ai-devops State
- **13 instruction files** in `.github/instructions/`
- Focus: Documentation standards, reference validation, selective context loading
- Missing: Quality standards (accuracy, communication, code review), memory-files, step-files, composition patterns

---

## Key Files Created/Modified

```
ai-devops/
├── .github/
│   ├── agents/
│   │   └── analysis.agent.md            # Created: custom agent for systematic analysis
│   ├── copilot-instructions.md          # Updated: automatic commit policy
│   ├── instructions/
│   │   └── git-commits.md               # Updated: automatic commit policy
│   └── prompts/
│       └── consolidate-session.prompt.md # Added from budget-sheet
├── .gitignore                            # Created: excludes .memory/
├── .memory/                              # Created: session memory (not committed)
│   └── HANDOFF.md                        # Session handoff file
├── analysis.md                           # Updated: removed subjective priorities
├── rules-evolution-analysis.md           # Created: problem-centric analysis
└── recommendations.md                    # Existing: import recommendations

```

---

## Analysis Files

### analysis.md
**Purpose:** Project analysis documenting 5 source projects  
**Updated:** Removed subjective priority assessments, clarified file type roles  
**Key Sections:**
- Projects Examined (with timeline, maturity assessment)
- Recommended Artifacts for Import (7 priorities)
- Recommended Unified Approach

### rules-evolution-analysis.md  
**Purpose:** Problem-centric analysis of rule evolution  
**Structure:**
- 12 problems identified with solution evolution paths
- Problems no longer being solved (quality, communication, "vibe coding", etc.)
- Traceable evolution: spafw37 → PDD → nightingale → claude-code → ai-devops
- Conclusion: Shift from process quality to documentation quality

### recommendations.md
**Purpose:** Import plan with 7 priority phases  
**Status:** Existing document, not modified in this session

---

## Critical Learnings

### File Type Roles (User Corrections)
1. **Guard rails** (instruction-files.md, prompt-files.md) - Use by AI not guaranteed
2. **Domain standards** (accuracy.md, communication.md, git-operations.md, code-review.md) - Apply throughout all work phases
3. **Final implementation artifacts** (plan-files.md, step-files.md) - Created at final stage only, not throughout design process
4. **Design process support** (memory-files.md) - Captures decisions BEFORE plans, prevents "vibe coding"

### Problem-Solving Focus
Rules evolved to solve specific AI development pitfalls:
- Context overflow (spafw37 Issue #68)
- "Vibe coding" (implicit decisions)
- Quality verification
- User communication consistency
- Cross-platform portability

### Problem-Solving Gaps
ai-devops stopped solving several critical problems:
- Quality assurance (lost accuracy.instructions.md, code-review-checklist.instructions.md)
- User interaction (lost communication.instructions.md)
- Design process support (lost memory-files.instructions.md)
- Context overflow via self-contained steps (lost step-files.instructions.md)
- Full git workflow (only git-commits.md remains)

---

## Custom Agents

### analysis.agent.md
**Purpose:** Systematic fact-gathering for analysis work  
**Location:** `.github/agents/analysis.agent.md`  
**Tools:** read, edit, search, web (WebSearch, WebFetch)
**Status:** Debugged and ready for use

**Workflow:**
1. Captures ALL findings (verified and unverified) in `.memory/ANALYSIS_FINDINGS.md`
2. Distills verified facts into `.memory/ANALYSIS_FACTS_PENDING.md`
3. Awaits user approval before appending to final analysis file
4. Archives processed findings in `.memory/ANALYSIS_FINDINGS_ARCHIVE.md`

**Key Feature:** Prevents analysis bloat and pollution from dead ends by requiring user approval gate before final content

**Based on:** nightingale-truenas memory-based approach (memory-files.instructions.md, distill-memory-facts.prompt.md)

**Debug Fix:** Fixed YAML syntax error - added missing `tools:` property name in frontmatter

**Usage:** Switch to `@analysis` agent in Copilot Chat for analysis work, specify final analysis file name

---

## Git Workflow Changes

### Automatic Commit Policy (NEW)
**When:** After EVERY file edit (create/modify/delete)  
**Files Updated:**
- `.github/instructions/git-commits.md`
- `.github/copilot-instructions.md`

**Policy:**
- ✅ Automatic commits after all edits
- ❌ NO automatic pushes (explicit user request required)

**Recent Commits (This Session):**
1. Update git commit policy to require automatic commits after every edit
2. Correct analysis assumptions and restructure rules evolution as problem-centric
3. Add .gitignore to exclude session memory files
4. Add analysis custom agent for systematic fact-gathering
5. Fix YAML syntax error in analysis agent and add web tool

---

## Current Work (Session: 2026-02-18)

**Focus:** Research synthesis on custom agent capability systems  
**Completed This Session:**
- Cloned claude-code-container repository successfully
- Reviewed `.devcontainer/doc/claude_code_custom_modes.md` research
- Added 8 comprehensive research findings (FINDING-2026-02-18-1 through FINDING-2026-02-18-8)
- Clarified terminology: "custom chatmodes" is legacy GitHub Copilot naming; current platforms use "agents" (Copilot) vs "custom modes" (Claude Code SDK)
- Documented permission modes: default, acceptEdits, plan, bypassPermissions, delegate, dont_ask
- Documented tool restriction patterns (allowlist vs denylist)
- Documented 3 implementation patterns (constraint-based, persona-based, autonomous execution)
- Documented multi-phase workflow integration with exit criteria
- Provided complete working example (problem-definer mode)

**Key Findings:**
- GitHub Copilot custom agents (.agent.md) ≠ Claude Code custom modes (.agent.md)
- Both platforms support agentskills.io standard for portable Skills
- Custom modes designed for phase-based workflows with distinct permissions per phase
- Permission modes layer control: plan (read-only) → acceptEdits (auto-approve writes) → bypassPermissions (full auto)

**Pending Analysis:**
1. Review findings for contradictions with prior research
2. Extract practical implementation patterns applicable to ai-devops
3. Decide: Adopt custom mode patterns for ai-devops workflows?
4. Decision on restoring process quality standards vs documentation optimization

**Next Steps:**
1. Practical evaluation: Test custom mode patterns on real ai-devops workflows
2. Archive session findings in `.memory/` (current: ai-devops-chatmodes-skills-facts.md)

---

## Quick Reference

**Instruction files count:** 13 in ai-devops, 17+ across source projects  
**Critical missing:** accuracy, communication, memory-files, step-files, git-operations (full), code-review, composition patterns  
**New in ai-devops:** reference-items, section-numbering, rule-copying, rule-embedding  
**Analysis approach:** Problem-centric, not file-centric  
**Custom agent:** `@analysis` for systematic fact-gathering with approval gate  
**Memory files:** `.memory/` directory (excluded from git)

**Research Files:**
- `.draft/ai-devops-chatmodes-skills-facts.md` - 18 findings on custom agents, skills, modes
- `.memory/ai-devops-analysis-index.md` - Index of research findings and sources
- `.memory/ai-devops-chatmodes-skills-facts.md` - Working copy of research (if archived)

**Claude-code-container Insights:**
- **Custom modes:** Permission-based subagents (plan mode = read-only analysis)
- **Permission modes:** 6 types controlling tool access (plan, acceptEdits, default, etc.)
- **Workflow pattern:** Phase 1 (define) → Phase 2 (analyze) → Phase 3 (plan) → Phase 4 (implement) → Phase 5 (verify)
- **Tool restrictions:** Allowlist (restrictive) vs denylist (permissive) approaches
- **Exit criteria:** Each phase has completion conditions and output artefacts
