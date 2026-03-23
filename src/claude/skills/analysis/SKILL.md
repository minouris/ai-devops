---
name: analysis
description: Research and analysis workflow with systematic fact capture, verification, and curated output generation
allowed-tools: Read, Write, Edit, WebFetch, WebSearch
---

# Research/Analysis Skill

Perform systematic investigation, capturing raw research findings and creating curated outputs. Execute two distinct research workflows: procedural research (finding and testing procedures) and analytical research (examining artifacts and capturing findings).

## Overview

When you engage this skill, follow a rigorous research methodology:
- Documentation-first verification requirements
- Two-stage text search (keyword → direct examination)
- Systematic fact capture with clarifications
- Automatic semantic term extraction and linking
- Disproven finding archival (never delete)
- Research completeness gates
- Fact verification before synthesis
- Operation logging for session continuity

## Documentation-First Principles

When you conduct research with this skill, operate under strict documentation-first principles. See [documentation-first.md](references/documentation-first.md) for complete requirements including:
- Mandatory official source verification
- Two-stage text search policy (keyword search → direct file examination)
- No speculation or assumptions
- Explicit uncertainty statements when sources unavailable

## Research Workflows

### Workflow 1: Procedural Research

When the user asks you to find, test, and verify a procedure or process, use this workflow. See [procedural-research.md](references/procedural-research.md) for:
- Web/documentation search procedures
- Test result documentation
- Iterative refinement based on testing
- Fact file capture format

**Output:** Verified procedure documentation (only when user explicitly requests)

### Workflow 2: Analytical Research

When the user asks you to examine artifacts systematically and synthesise findings, use this workflow. See [analytical-research.md](references/analytical-research.md) for:
- Artifact indexing and systematic examination
- Fact capture and index maintenance
- Disproven finding archival
- Multi-file research organization

**Output:** Analysis document with citations (only when user explicitly requests)

## Your Process

### CRITICAL: Memory File Location

When you create or update memory files during research, use this path structure ONLY:

```
.memory/[topic-slug]/[topic-slug]-facts.md
.memory/[topic-slug]/[topic-slug]-terms.md
.memory/[topic-slug]/[topic-slug]-index.md
```

**DO NOT create files in these wrong locations:**
- ❌ `src/claude/projects/...` (WRONG)
- ❌ `.claude/projects/.../memory/` (WRONG)
- ❌ Any location other than workspace root `.memory/` (WRONG)

All memory files must be in the workspace root `.memory/[topic-slug]/` directory.

### 1. Capture Research in Fact Files

See [fact-capture.md](references/fact-capture.md) for:
- Fact file naming conventions (`.memory/[topic]/[topic]-facts.md`, `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-facts.md`)
- FINDING-YYYY-MM-DD-N format
- Clarifying existing facts (append with `Clarifies:` reference)
- File boundaries (fact files vs pending analysis vs final output)
- When to create subtopic files
- **CRITICAL: Before finalizing a finding, verify it uses correct terminology:** Extract terms from the finding, invoke `/verify-analysis term` for each, amend finding to use verified term names/IDs

**Key principle:** During research phase, write ONLY to fact files. Use verified terminology in findings. Pending analysis and final output are read-only until user requests synthesis.

### 1.5. Extract and Maintain Semantic Terms

See [term-capture.md](references/term-capture.md) for:
- Term definition and fine-grained scoping
- Automatic term extraction from fact findings
- On-demand term extraction workflow
- Bidirectional linking between terms and facts
- Term validation against same criteria as facts
- Term archival and disproven tracking

See [term-indexing.md](references/term-indexing.md) for:
- Term entry template and standardized formatting
- Term index file organization and naming conventions
- Central index maintenance (`index-terms.md`)
- Term verification workflow and status tracking
- File size management (500-line limit per index file)

**Key principle:** When you extract terms, create hierarchical semantic indexing with standardized formatting. Extract terms automatically when facts introduce new concepts, maintain bidirectional links between facts and terms, and organize terms into properly formatted glossaries.

### 2. Archive Disproven Findings

See [disproven-archive.md](references/disproven-archive.md) for:
- Moving findings from fact file to `-disproven.md` companion
- Disproof metadata format
- Preservation rationale

**Key principle:** Never delete disproven findings. Archive immediately with full context.

**CRITICAL:** This refers to findings disproven DURING RESEARCH (user feedback that a finding is inaccurate). Findings disproven DURING VERIFICATION are archived by the verify-analysis skill, NOT the analysis skill.

### 3. Post-Verification Operations (verify-analysis Skill Only)

**CRITICAL:** The following operations are the EXCLUSIVE responsibility of the verify-analysis skill:
- Update verification status tags on findings/terms
- Update indexes with newly verified findings/terms
- Archive findings/terms when validation fails
- Log verification operations

**MUST NOT:** The analysis skill performs any of these operations. Only verify-analysis handles all post-verification updates.

When verification is needed, invoke `/verify-analysis fact` or `/verify-analysis term` and let that skill handle all resulting updates to files and indexes.

### 4. Update Analysis Index (For New Findings Only)

See [index-maintenance.md](references/index-maintenance.md) for:
- Index file structure (`.memory/[topic]/[topic]-index.md`)
- Tracking fact files and subtopics
- Noting companion disproven files
- Timestamp maintenance
- Adding newly captured findings to index

**Key principle:** Update index when new findings are captured during research. Do NOT update index for verification status changes — that is verify-analysis skill's exclusive responsibility.

### 5. Create Final Output (Only When User Requests)

**CRITICAL:** Do NOT create final output documents unless user explicitly requests them.

See [final-output.md](references/final-output.md) for:
- Research completeness gate (MANDATORY before synthesis)
- Procedural guide creation
- Analytical report synthesis with fact verification
- Draft approval workflow
- Citation requirements

**Key principle:** Before creating analysis documents, invoke `/verify-analysis fact` to verify all facts. Do not perform verification yourself.

### 6. Operation Logging
- Session initialization protocol (ask for topic slug, restore context)
- Significant operations requiring logging
- Log file format (`.memory/[topic]/[topic]-log.md`)

**Key principle:** Log after each significant operation to enable session continuity.

## Key Principles

### Processing Artifacts vs. Final Outputs

**MUST:**
- Store all processing artifacts in `.memory/` (fact files, indices, drafts, disproven archives, terms files)
- Store only final approved outputs in the root (guides, analyses, documentation)
- Capture research broadly in fact files; filter as research progresses when appropriate
- Extract semantic terms automatically from findings
- Verify extracted terms using `/verify-analysis term` before considering findings complete
- Amend findings to use verified terminology (term IDs or verified names)
- Maintain bidirectional links between facts and terms
- Archive findings to `-disproven.md` files immediately when the user disproves them
- Invoke `/verify-analysis fact` when verification of findings is needed; do not perform verification yourself

### Quality Control

**MUST:**
- Wait for user approval before publishing any final output
- Archive disproven findings immediately to preserve history
- Before creating analysis documents, invoke `/verify-analysis fact` for all fact files to verify findings (facts tagged within the last 30 days are skipped automatically by verify-analysis)
- Maintain the analysis index for navigation and transparency

### Transparency

**MUST:**
- Capture all research in fact files, including approaches attempted and dead ends
- Never delete disproven findings — archive them with the reason for disproof
- Include timestamps on all entries
- Maintain traceability from final output to fact file entries to original sources

## Response to User

### On First Load (MANDATORY)

When you are invoked in a new session, before anything else:

1. Ask: "What topic are we working on? (This sets the session context — e.g., `ai-problems-analysis`)"
2. Once the user provides the topic slug, attempt to read `.memory/[topic]/[topic]-log.md` (if record-operation logging is in use)
3. If the log exists, summarise the last 1–3 entries to the user: operation type, files changed, and next step recorded
4. Confirm: "Session context loaded from `.memory/[topic]/[topic]-log.md`. Ready to continue."
5. If no log exists, confirm: "No previous log found for `[topic]`. Starting fresh."

**MUST NOT:**
- Begin any research or respond to the first task before completing steps 1–5
- Assume a topic slug without asking

---

### When Engaged for Research

- For **procedural research**: See [procedural-research.md](references/procedural-research.md) for complete workflow
- For **analytical research**: See [analytical-research.md](references/analytical-research.md) for complete workflow
- When user requests final output: See [final-output.md](references/final-output.md) for synthesis and verification workflow

### Key Reminders

**MUST:**
- Store all processing artifacts in `.memory/`
- Extract terms automatically from findings with singular scope
- Verify extracted terms using `/verify-analysis term` before considering findings complete
- Amend findings to use verified terminology from verified terms
- Maintain bidirectional links between facts and terms
- Capture broadly in fact files; archive disproven findings immediately, never delete
- Update terms index after each term operation
- Invoke `/verify-analysis fact` before synthesising any analysis; do not perform verification yourself
- Run [record-operation](../../prompts/record-operation.prompt.md) with the topic slug after each significant operation (if available)
- Place final outputs where the user specifies
- Continue research without interruption for approval

**MUST NOT:**
- Create any output document until the user explicitly requests it
- Bundle multiple concepts into a single term (each term = singular scope)
- Create terms without clear source citation
- Delete or lose bidirectional links between facts and terms

---

## Claude Code Tool Usage

This skill uses the following Claude Code tools:

- **Read**: Read fact files, source code, documentation
- **Write**: Create new fact files, drafts, final outputs
- **Edit**: Update existing fact files, indices, append entries
- **Grep**: Search code for patterns and keywords
- **Glob**: Find files matching patterns
- **Bash**: Execute tests, verify procedures, run commands
- **WebFetch**: Retrieve and analyse web documentation
- **WebSearch**: Find authoritative sources and official documentation

---

## Invocation

Invoke this skill when you need to:
- Research and document a technical procedure
- Analyse a codebase or project systematically
- Capture research findings with proper citation and verification
- Create evidence-based technical documentation

**Usage:**
```
/analysis
```

Then specify whether you're conducting procedural or analytical research, and provide the scope.
