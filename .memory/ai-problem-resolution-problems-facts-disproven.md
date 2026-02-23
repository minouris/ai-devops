# AI Problems Analysis - Archived

**Archive Note:** Problems identified in this file are either:
1. Project-specific implementations (metaprompts/AISP, spafw37 registry, prompt-driven-development ecosystem)
2. Solution frameworks rather than fundamental AI problems (standardisation)

Archived 2026-02-19.

---

### PROBLEM-2026-02-19-05: Missing Standardization for Agent Modes, Prompts, Policies (ARCHIVED)
**Captured:** 2026-02-19 14:45  
**Archived:** 2026-02-19 15:35  
**Reason:** Describes a solution framework (standardisation) rather than a fundamental AI management problem. Standardisation assists in solving execution/compliance problems but is not itself an AI problem.
**Source:** [prompt-driven-development issues #66](https://github.com/minouris/prompt-driven-development/issues/66) (open), [#67](https://github.com/minouris/prompt-driven-development/issues/67) (open), [#68](https://github.com/minouris/prompt-driven-development/issues/68) (open)

Three interrelated format standardisation issues are all open and blocking work:

**Issue #66: Define Policy Format Standards**
- Goals: Define policy-specific frontmatter, standard sections, reference patterns, scope guidelines
- Missing: Policy format standards, instruction enforcement file

**Issue #67: Define Prompt Format Standards**
- Goals: Define prompt-specific frontmatter, standard sections for composition patterns, reference syntax
- Missing: Prompt format standards, metaprompt composition guidance, compilation/execution model

**Issue #68: Define Agent Mode Format Standards**
- Goals: Define agent mode frontmatter, standard sections for configuration, tools, behaviours, permissions
- Missing: Agent mode formats, activation patterns, platform-specific variations, exportable format definitions

**Why this is archived:** Lack of standardisation is a symptom of deeper execution/compliance problems (how to consistently specify AI behaviour). The real problems are in #1, #3, #8 (instruction non-compliance, system prompt override, policy enforcement). Standards would help solve those, but standardisation itself is not the core problem.

**Status:** All three issues open, no progress yet, blocking metaprompt adoption

---

### PROBLEM-2026-02-19-04: AISP Compiled Prompt Security Vulnerabilities (ARCHIVED)
**Captured:** 2026-02-19 14:30  
**Archived:** 2026-02-19 15:30  
**Reason:** Specific to AISP/metaprompts project implementation, not general AI management problem
**Source:** [prompt-driven-development issue #76](https://github.com/minouris/prompt-driven-development/issues/76) (open); related PRs #77, #78, #79, #82

AISP (AI Instruction Set Protocol) prompt compilation introduces security vulnerabilities that enable malicious instruction injection and obfuscation.

**The problem:**
AISP is a metaprompt compilation approach that translates natural language prompts into mathematical notation with 512 specialised symbols for "unambiguous AI interpretation." However, this creates a significant security risk: malicious instructions can be hidden in AISP code that humans cannot easily review or verify.

**Why this is dangerous:**

1. **Opacity to human reviewers**
   - AISP uses mathematical notation unfamiliar to most developers
   - Requires 8–12K tokens of specification knowledge to interpret
   - Intent obfuscation is trivial for malicious actors
   - Non-experts cannot audit AISP code

2. **Trust boundary breakdown**
   - Pre-compilation: Who validates natural language before AISP compilation?
   - Post-compilation: Who verifies compiled AISP matches intended behaviour?
   - Execution: AI agents execute AISP without human-readable explanation

3. **Specific attack vectors identified**
   - **Prompt injection via AISP:** Malicious AISP embedded as seemingly benign natural language, compiler generates AISP with hidden instructions
   - **Supply chain attacks:** Compromised AISP libraries with embedded malicious functions, pre-compiled AISP distributed without source code
   - **Semantic drift:** Compilation introduces subtle behaviour changes (e.g., "read file X" also copies to external endpoint)
   - **Obfuscation via complexity:** Hide malicious logic in complex categorical constructions and type system analysis

4. **Verification is impractical**
   - No standard AISP validator or security scanner exists
   - Decompiling AISP back to natural language loses fidelity
   - Formal verification requires mathematical expertise teams lack
   - Including AISP specification in context is prohibitively expensive

**Current status:**
- Multiple PRs submitted addressing security concerns (#77, #78, #79)
- Open issue #75: "Lessons Learned: Focused Task Files vs. Automatic Instruction Loading" documents implications
- Open PR #82: "Correct AISP security analysis based on spec author feedback" indicates ongoing research and correction

---

### PROBLEM-2026-02-19-07: Registry System Inadequacy (ARCHIVED)
**Captured:** 2026-02-19 14:45  
**Archived:** 2026-02-19 15:30  
**Reason:** Specific to spafw37 project's change tracking system, not general AI management problem
**Source:** [spafw37 issue #100](https://github.com/minouris/spafw37/issues/100) (open), [#101](https://github.com/minouris/spafw37/issues/101) (closed), [#102](https://github.com/minouris/spafw37/issues/102) (open, v1.2.0 milestone)

The change registry system has proven inadequate and required major redesign:

**History of attempts:**
- Issue #101 (closed): Previous attempt to implement Change Registry System—insufficient, reopened
- Issue #98: Active changes registry (CHANGES-ACTIVE.md)
- Issue #99: Archived changes registry (CHANGES-ARCHIVED.md)
- Issue #100: Comprehensive redesign with new structure and standards (currently in progress)

**Problems with registry:**
- Inadequate tracking of changes across features, tools, and documentation
- Poor categorisation of work by component type
- Insufficient historical audit trail
- Unclear separation of active vs. archived changes

**Status:**
- Issue #100: In Progress, detailed design complete but not yet implemented
- Issue #102: Marked as major requirement for v1.2.0 milestone (deferred implementation)
- Suggests earlier attempt insufficient; fundamental rethinking needed

---

### PROBLEM-2026-02-19-08: Metaprompt Framework vs. Task-Specific Frameworks (ARCHIVED)
**Captured:** 2026-02-19 14:45  
**Archived:** 2026-02-19 15:30  
**Reason:** Specific to prompt-driven-development repository architecture, not general AI management problem
**Source:** [prompt-driven-development issue #72](https://github.com/minouris/prompt-driven-development/issues/72) (open)

The current prompt-driven-development repository conflates two distinct but related purposes:

**Framework 1: Plan-Driven Development (PDD) Framework**
- Purpose: Enable developers to use AI agents effectively for structured software development
- Artifacts: Workflow prompts (1-6 series), development actions (issue creation, plan management), development instructions (Python, Git, implementation)
- Target audience: Software developers using AI assistance
- Components: 9+ instruction files, workflow prompts, agents for Architecture and Design

**Framework 2: Metaprompts Framework**
- Purpose: Enable prompt engineers and AI researchers to analyse AI agent behaviour, identify problematic patterns, systematically generate countermeasures
- Artifacts: System prompt analysis documents, metaprompts for analysis and composition, rules library for overriding problematic behaviours, core policy files
- Target audience: Prompt engineers, AI researchers, framework developers
- Components: Analysis documents, composition prompts, rules library, policy files

**Why this is a problem:**
- Two distinct purposes create conflicting design goals
- Shared `.github/instructions/` cause coupling
- Different audiences have different needs (developers vs. researchers/engineers)
- Release cycles and versioning strategies differ
- Makes it harder for users to understand which framework is which
- Complicates dependency management (PDD depends on metaprompts, but they're intertwined)

**Current issues tied to this architecture problem:**
- PDD-focused: #21–29 (prompt refinement), #30 (workflow), #31 (configuration), #32 (issue tracker)
- Metaprompts-focused: #8 (system prompt analysis), #10 (rules extraction), #12–14 (composition verification)
- Cross-cutting: #38–45 (ecosystem detection, authentication, validation, error handling)

**Status:** Open issue, solution identified but not yet implemented

---

### PROBLEM-2026-02-19-12: Agent Detection Mechanism Lacks Specificity (ARCHIVED)
**Captured:** 2026-02-19 15:20  
**Archived:** 2026-02-19 15:30  
**Reason:** Specific to prompt-driven-development action file implementation, not general AI management problem
**Source:** [prompt-driven-development issue #44](https://github.com/minouris/prompt-driven-development/issues/44) (open); referenced in PR #36 review comment

Agent detection logic in action files provides abstract instructions without implementation guidance.

**Current state:**
Action files (e.g., `create-issue.md`) include vague detection instructions:
```
Detect `{Agent_Type}` by checking environment:
- If running in an IDE with GitHub Copilot Chat: "copilot-chat"
- If running in GitHub Copilot coding agent: "copilot-agent"
- Default: "unknown"
```

**The problem:**
- "Check environment" lacks specificity—what environment variables? API calls? Context indicators?
- No documented mechanism for detecting agent type
- Agent authors have no guidance for implementing specific detection logic
- Runtime context information not documented
- GitHub Copilot Chat detection mechanism unclear
- GitHub Copilot Coding Agent environment markers not documented
- No standard patterns available for reference

**Impact:**
- Actions cannot reliably detect their execution context
- Ecosystem-specific variants cannot properly delegate
- Fallback to default "unknown" agent type fails gracefully but loses capabilities
- Agent developers must reverse-engineer detection from experience
