# AI Programming Problems - Verified Facts

**Domain:** AI programming problems and solutions across projects
**Project:** ai-devops
**Created:** 2026-02-17

---

### FACT-2026-02-17-1
**Verified:** 2026-02-17 14:00
**Source:** spafw37 Issue #68 (https://github.com/minouris/spafw37/issues/68)

Context overflow occurs when instruction file system loads too many files simultaneously based on file pattern matching. In spafw37, 9 instruction files (2000-3000 lines total) loaded during planning workflow Step 4, causing file operation failures, file corruption, and excessively verbose responses.

**Evidence:** GitHub issue documented problem during Dec 2025, with specific file pattern analysis showing 5 files with `applyTo: "**/*"`, 1 with `applyTo: "features/**/*.md"`, and 3 with `applyTo: "**/*.py"` triggered by Python code blocks in markdown.

---

### FACT-2026-02-17-2
**Verified:** 2026-02-17 14:05
**Source:** spafw37 Issue #93 (https://github.com/minouris/spafw37/issues/93)

Monolithic plan files (4000+ lines) strain AI context management during implementation. This creates multiple problems: AI assistants struggle to follow Step 8 implementation instructions, human reviewers must navigate massive files, version control diffs become difficult to review, and individual sections cannot be easily referenced or reused.

**Evidence:** Issue created Dec 2025 documenting problems encountered during Issue #63 implementation where 4000+ line plan document made Step 8 implementation difficult for AI assistants to execute systematically.

---

### FACT-2026-02-17-3
**Verified:** 2026-02-17 14:10
**Source:** prompt-driven-development Issue #75 (https://github.com/minouris/prompt-driven-development/issues/75)

Automatic instruction loading based on file patterns wastes context on irrelevant rules. Field testing showed focused task-specific plan files (bundling only relevant rules) saved 12,500-21,500 tokens per task, achieved 40-55% fewer conversation turns, and maintained 100% context retention vs 60% with automatic loading.

**Evidence:** Measured results from 8-task documentation cleanup project in Jan 2026 comparing automatic loading (would have cost 20,000-35,000 tokens per task) versus focused task files (~3,500 tokens per task with 100% relevance).

---

### FACT-2026-02-17-4
**Verified:** 2026-02-17 14:15
**Source:** prompt-driven-development Issue #70 (https://github.com/minouris/prompt-driven-development/issues/70)

System-level AI instructions override user-provided prompt instructions unless explicitly overridden. In field testing, AI's system instruction to "implement proactively" overrode a 430-line prompt's TDD workflow requirement, causing AI to implement code before writing tests.

**Evidence:** spafw37 Issue #81 documented field failure where Step 8 implementation prompt failed because TDD requirement appeared at Step 6 of the prompt, whilst system instruction to "be helpful by implementing changes" took precedence.

---

### FACT-2026-02-17-5
**Verified:** 2026-02-17 14:20
**Source:** prompt-driven-development Issue #76 (https://github.com/minouris/prompt-driven-development/issues/76)

Compiled AI instruction formats (like AISP) create security and auditability problems. Mathematical notation with 512 specialized symbols requiring 8-12K tokens of specification knowledge to interpret makes human review impractical, enabling attack vectors like prompt injection, supply chain attacks, semantic drift, and obfuscation via mathematical complexity.

**Evidence:** Security analysis document in prompt-driven-development examining AISP compilation approach, comparing to WebAssembly security model and smart contract auditing practices.

---

