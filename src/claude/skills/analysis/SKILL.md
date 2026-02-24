---
name: analysis
description: Research and analysis workflow with systematic fact capture, verification, and curated output generation
---

# Research/Analysis Skill

Perform systematic investigation, capturing raw research findings and creating curated outputs. Execute two distinct research workflows: procedural research (finding and testing procedures) and analytical research (examining artifacts and capturing findings).

## Overview

This skill implements a rigorous research methodology with:
- Documentation-first verification requirements
- Two-stage text search (keyword → direct examination)
- Systematic fact capture with clarifications
- Disproven finding archival (never delete)
- Research completeness gates
- Fact verification before synthesis
- Operation logging for session continuity

## Documentation-First Principles

This skill operates under strict documentation-first principles. See [documentation-first.md](references/documentation-first.md) for complete requirements including:
- Mandatory official source verification
- Two-stage text search policy (keyword search → direct file examination)
- No speculation or assumptions
- Explicit uncertainty statements when sources unavailable

## Research Workflows

### Workflow 1: Procedural Research

Use when asked to find, test, and verify a procedure or process. See [procedural-research.md](references/procedural-research.md) for:
- Web/documentation search procedures
- Test result documentation
- Iterative refinement based on testing
- Fact file capture format

**Output:** Verified procedure documentation (only when user explicitly requests)

### Workflow 2: Analytical Research

Use when asked to examine artifacts systematically and synthesise findings. See [analytical-research.md](references/analytical-research.md) for:
- Artifact indexing and systematic examination
- Fact capture and index maintenance
- Disproven finding archival
- Multi-file research organization

**Output:** Analysis document with citations (only when user explicitly requests)

## Your Process

### 1. Capture Research in Fact Files

See [fact-capture.md](references/fact-capture.md) for:
- Fact file naming conventions (`.memory/[topic]-facts.md`, `.memory/[topic]-[subtopic]-facts.md`)
- FINDING-YYYY-MM-DD-N format
- Clarifying existing facts (append with `Clarifies:` reference)
- File boundaries (fact files vs pending analysis vs final output)
- When to create subtopic files

**Key principle:** During research phase, write ONLY to fact files. Pending analysis and final output are read-only until user requests synthesis.

### 2. Archive Disproven Findings

See [disproven-archive.md](references/disproven-archive.md) for:
- Moving findings from fact file to `-disproven.md` companion
- Disproof metadata format
- Preservation rationale

**Key principle:** Never delete disproven findings. Archive immediately with full context.

### 3. Update Analysis Index

See [index-maintenance.md](references/index-maintenance.md) for:
- Index file structure (`.memory/[topic]-index.md`)
- Tracking fact files and subtopics
- Noting companion disproven files
- Timestamp maintenance

### 4. Create Final Output (Only When User Requests)

**CRITICAL:** Do NOT create final output documents unless user explicitly requests them.

See [final-output.md](references/final-output.md) for:
- Research completeness gate (MANDATORY before synthesis)
- Procedural guide creation
- Analytical report synthesis with fact verification
- Draft approval workflow
- Citation requirements

**Key principle:** Run [verify-memory-facts](../../prompts/verify-memory-facts.md) on all fact files before synthesising analysis documents.

### 5. Operation Logging

See [operation-logging.md](references/operation-logging.md) for:
- Session initialization protocol (ask for topic slug, restore context)
- Significant operations requiring logging
- Log file format (`.memory/[topic]-log.md`)

**Key principle:** Log after each significant operation to enable session continuity.

## Key Principles

### Processing Artifacts vs. Final Outputs

**MUST:**
- Store all processing artifacts in `.memory/` (fact files, indices, drafts, disproven archives)
- Store only final approved outputs in the root (guides, analyses, documentation)
- Capture research broadly in fact files; filter as research progresses when appropriate
- Archive findings to `-disproven.md` files immediately when the user disproves them
- Run [verify-memory-facts](../../prompts/verify-memory-facts.md) on fact files before synthesising analysis documents

### Quality Control

**MUST:**
- Wait for user approval before publishing any final output
- Archive disproven findings immediately to preserve history
- Verify fact files using [verify-memory-facts](../../prompts/verify-memory-facts.md) before creating analysis documents; facts tagged within the last 30 days are skipped automatically
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
2. Once the user provides the topic slug, attempt to read `.memory/[topic]-log.md` (if record-operation logging is in use)
3. If the log exists, summarise the last 1–3 entries to the user: operation type, files changed, and next step recorded
4. Confirm: "Session context loaded from `.memory/[topic]-log.md`. Ready to continue."
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
- Capture broadly in fact files; archive disproven findings immediately, never delete
- Run [verify-memory-facts](../../prompts/verify-memory-facts.md) before synthesising any analysis
- Run [record-operation](../../prompts/record-operation.prompt.md) with the topic slug after each significant operation (if available)
- Place final outputs where the user specifies
- Continue research without interruption for approval

**MUST NOT:**
- Create any output document until the user explicitly requests it

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
