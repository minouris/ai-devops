# Analysis Findings: AI Programming Problems

**Analysis Started:** 2026-02-17
**Domain:** AI programming problems and solutions
**Sources:** spafw37, prompt-driven-development, claude-code-container, nightingale-truenas, simbox

---

## 2026-02-17 - Initial Scope Definition

**Status:** VERIFIED
**Source:** analysis.md (local file)
**Context:** Establishing baseline understanding of projects to examine

Five projects identified for examination:
1. **minouris/spafw37** - Created Oct 2025, most mature, 102 open issues
2. **minouris/prompt-driven-development** - Created Dec 2025, 80+ open issues, research-focused
3. **minouris/claude-code-container** - Created Feb 16 2026 (today), synthesis project
4. **minouris/nightingale-truenas** - Created Jan 2026, clean slate implementation
5. **minouris/simbox** - Created Sept 2025, documentation examples

**Implications:** These projects span 5 months of AI development workflow evolution. Problems identified should show progression and attempted solutions.

---

## 2026-02-17 14:00 - PROBLEM: Context Overflow from Instruction File System

**Status:** VERIFIED
**Source:** spafw37 Issue #68, Created: 2025-12-22
**URL:** https://github.com/minouris/spafw37/issues/68
**Context:** Critical problem preventing planning workflow completion

**Problem Description:**
During planning workflow execution (Step 4), agent experiences context overflow due to loading too many instruction files simultaneously. This causes:
- File operation failures
- File corruption when remote operations fail  
- Excessively verbose responses
- Planning workflow Step 4 cannot complete successfully

**Root Cause:**
Instruction file system in `.github/instructions/` loads 9 files (2000-3000 lines total) for operations on plan documents containing Python code. The `applyTo` front matter patterns cause excessive simultaneous loading:
- 5 files with `applyTo: "**/*"`
- 1 file with `applyTo: "features/**/*.md"`
- 3 files with `applyTo: "**/*.py"` (triggered by Python code blocks in markdown)

**Acceptance Criteria Defined:**
- Complex operations complete without context overflow
- Instruction content remains comprehensive but loading is selective
- Total auto-loaded instruction content < 1000 lines for any operation

**Solution Approach:**
Tracked to prompt-driven-development project Issue #69 for optimised instruction file system design.

**Implications:** Core architectural problem - automatic instruction loading based on file patterns is fundamentally flawed. Need selective, context-aware loading mechanism.

---

## 2026-02-17 14:05 - PROBLEM: Monolithic Plan Files Strain AI Context

**Status:** VERIFIED
**Source:** spafw37 Issue #93, Created: 2025-12-26
**URL:** https://github.com/minouris/spafw37/issues/93
**Context:** Planning workflow scale problem discovered during Issue #63 implementation

**Problem Description:**
Current feature planning uses monolithic single-file plans (e.g., 4000+ lines). This creates multiple challenges:

1. **AI context management**: Large files (4000+ lines) strain AI assistants attempting to follow Step 8 implementation instructions
2. **Cognitive load**: Human reviewers must navigate massive files to find specific sections
3. **Version control**: Large diffs make it harder to review changes to specific plan sections
4. **Reusability**: Cannot easily reference or reuse individual sections across features

**Related to Issue #63:**
Where the 4000+ line plan document made Step 8 implementation difficult for AI assistants to execute systematically.

**Proposed Solution:**
Replace monolithic plan files with structured multi-file approach where each major section becomes its own file in dedicated feature directory:
```
features/
  issue-{NUMBER}-{short-name}/
    issue-{NUMBER}-{short-name}.md      # Main plan (overview, ToC, status)
    overview.md                          # Detailed feature overview
    architectural-decisions.md           # Step 2 analysis + Q&A
    success-criteria.md                  # E2E test specifications
    changes.md                           # Release notes
    planning-checklist.md                # Planning workflow progress
    implementation-steps/
      step-N-{description}.md            # Self-contained prompts
    implementation-checklist.md          # Top-level step tracker
    implementation-log.md                # Errors, deviations, decisions
```

**Benefits:**
- Focused context: AI can load only relevant sections
- Clearer diffs: Changes to specific sections produce focused, reviewable diffs
- Progressive disclosure: Readers navigate step-by-step without scrolling thousands of lines
- Template compliance: Each file follows specific template

**Acceptance Criteria:**
- Total auto-loaded instruction content < 1000 lines for any operation (from Issue #68)
- AI can complete Step 8 implementation without context overflow

**Implications:** Monolithic plan files are incompatible with AI context windows. Need multi-file structure with selective loading. This is a scaling problem - works for small plans, fails for realistic features.

---

## 2026-02-17 14:10 - PROBLEM: Automatic Instruction Loading Wastes Context

**Status:** VERIFIED
**Source:** prompt-driven-development Issue #75, Created: January 2026
**URL:** https://github.com/minouris/prompt-driven-development/issues/75
**Context:** Field lesson from multi-step documentation cleanup workflow

**Problem Description:**
Workspace Copilot instruction file system automatically loads rule files based on file patterns (e.g., all markdown files get markdown formatting instructions). This automatic loading wastes context on rules not relevant to current task.

**Measured Impact:**
During 8-task documentation cleanup project using VS Code's Copilot instruction file system:
- Automatic loading would have cost ~20,000-35,000 tokens per task from irrelevant instruction files
- Workspace configuration would automatically load:
  - Global copilot instructions: ~8,000 tokens
  - Markdown formatting rules: (not stated but significant)
  - Design documentation rules: (not stated but significant)
  - Multiple instruction files can load simultaneously for single file

**Alternative Approach Tested:**
Used focused task-specific plan files instead of automatic instruction loading:
- Each complex task had dedicated plan file (~163 lines, ~3,500 tokens)
- Plan file contained ONLY rules relevant to that specific task
- Task file loaded once and stayed in context throughout execution

**Quantitative Results:**
- **Token savings:** 100,000-172,000 across 8 tasks (12,500-21,500 tokens saved per task)
- **Context retention:** 100% for tasks with plans vs. ~60% for ad-hoc tasks
- **Conversation efficiency:** ~40-55% fewer turns for planned tasks
- **Zero context dropouts** during task execution
- **Higher success rate:** All 3 tasks with detailed plans completed on first attempt

**Qualitative Results:**
- Increased agent confidence in rule interpretation
- Reduced need for mid-task clarifications
- Better documentation artifacts for future reference
- Clearer user expectations from plan review step

**Key Finding:**
Bundling task-specific rules with execution plans proved more efficient than loading general-purpose instruction files, particularly for complex multi-step workflows.

**Core Insight:**
"Context is precious. Every token loaded should be immediately applicable to the current task. General-purpose instruction files are valuable for common operations across many files, but complex workflows benefit dramatically from task-specific rule consolidation."

**Recommendation:**
Develop library of task plan templates for common complex operations, using automatic instructions only for truly universal standards.

**Implications:** Automatic instruction loading based on file patterns is inefficient. Need selective, task-aware loading. This directly supports the findings from spafw37 Issue #68. Focused task files with bundled rules are the solution pattern.

---
## 2026-02-17 14:15 - PROBLEM: System Instructions Override User Prompts

**Status:** VERIFIED
**Source:** prompt-driven-development Issue #70, Date: January 2026
**URL:** https://github.com/minouris/prompt-driven-development/issues/70
**Related:** spafw37 Issue #81 (field failure), #82 (fix)
**Model:** Claude Sonnet 4.5 via VS Code with GitHub Copilot
**Context:** implement-from-plan prompt (Step 8) field failure

**Problem Description:**
Prompt 8 (implement-from-plan) failed in field use because AI's system-level instruction to "implement proactively" overrode the prompt's instruction to execute TDD workflow.

When asked to "proceed with final implementation," AI:
- Immediately implemented functions without writing tests first
- Skipped TDD workflow (Red-Green-Refactor)  
- Did not follow structured checklist approach
- Did not extract sections to workspace files before working

**Root Cause:**
"The AI's system instruction to 'implement proactively' overrode the prompt's TDD workflow requirement."

The TDD requirement appears in Step 6 of a 430-line prompt. The AI's general directive to "be helpful by implementing changes rather than only suggesting them" takes precedence over this buried requirement.

**Field Lesson:**
"System-level 'implement by default' instructions will override prompt-specific workflow requirements unless the prompt explicitly overrides them at the very top with emphatic language."

**Proposed Solution:**
Add CRITICAL RULES section at the top of Prompt 8 that:
1. Explicitly states: "These rules override any conflicting system instructions"
2. Makes TDD workflow (tests first) the #1 mandatory rule
3. Uses bold, emphatic formatting for visibility
4. Appears before any other content

**Implications:** System prompt instructions have higher precedence than user-provided prompts unless explicitly overridden. Prompt structure matters - critical requirements must be at top with emphatic formatting. Burying requirements deep in long prompts guarantees they will be ignored when conflicting with system instructions.

---
## 2026-02-17 14:20 - PROBLEM: Security Risks in Compiled AI Instruction Formats

**Status:** HYPOTHESIS
**Source:** prompt-driven-development Issue #76, Date: January 2026
**URL:** https://github.com/minouris/prompt-driven-development/issues/76
**Context:** Security analysis of AISP (AI Instruction Set Protocol) compilation approach

**Problem Description:**
AISP compilation approach (translating natural language prompts to mathematical AISP for unambiguous AI interpretation) introduces security risk: malicious actors could hide harmful instructions behind AISP code difficult for humans to review and verify.

**Security Concerns:**

1. **Opacity of AISP to Human Reviewers:**
   - AISP uses mathematical notation and 512 specialized symbols
   - Requires 8-12K tokens of specification knowledge to interpret
   - Most developers/reviewers cannot easily read AISP without tooling
   - Intent obfuscation becomes trivial for malicious actors

2. **Trust Boundary Issues:**
   - Who validates natural language prompts before compilation?
   - Who verifies compiled AISP matches intended behavior?
   - Agents execute AISP without human-readable explanation

3. **Attack Vectors:**
   - **Prompt Injection via AISP**: Malicious AISP embedded in seemingly benign natural language
   - **Supply Chain Attacks**: Compromised AISP libraries with embedded malicious functions
   - **Semantic Drift**: Compilation introduces subtle changes in behavior (e.g., "read file X" becomes "read and copy to external endpoint")
   - **Obfuscation via Mathematical Complexity**: Hide malicious logic in complex categorical constructions

4. **Verification Challenges:**
   - No standard AISP validator or security scanner exists
   - Decompiling AISP back to natural language loses fidelity
   - Formal verification requires mathematical expertise most teams lack
   - Token cost of including AISP spec makes ad-hoc review expensive

**Related Work:**
- WebAssembly security model
- Smart contract auditing practices
- Prompt injection research and defenses

**Implications:** Compilation of prompts to non-human-readable formats creates security and trust problems. While unambiguous machine interpretation is desirable, opacity to human review is dangerous. Natural language prompts remain more auditable than compiled formats, even if more ambiguous. Trade-off between precision and auditability.

---