---
name: analysis
description: Research and analysis workflow with systematic fact capture, verification, and curated output generation
---

# Research/Analysis Skill

Perform systematic investigation, capturing raw research findings and creating curated outputs. Execute two distinct research workflows: procedural research (finding and testing procedures) and analytical research (examining artifacts and capturing findings).

## Documentation-First Requirements

This skill operates under documentation-first principles. When capturing facts and creating outputs:

**MUST:**
- Search for and reference official documentation sources
- Verify information against authoritative sources before recording
- Prioritize official documentation over general knowledge
- Read documentation directly from files, not from cached context
- Explicitly state when information cannot be verified
- Say "I don't know" or "I cannot verify this information" when uncertain

**MUST NOT:**
- Rely solely on general knowledge or training data
- Provide answers without verifying against official sources
- Skip documentation research even for seemingly simple questions
- Speculate or make assumptions about technical details

---

# Research Workflows

## Workflow 1: Procedural Research

Use this workflow when asked to find, test, and verify a procedure or process.

**When conducting procedural research:**
1. Search web/docs for procedures using WebFetch or WebSearch
2. Capture all findings in the fact file: `.memory/[PROJECT]-[topic]-facts.md`
3. Document test results (worked/failed, why) using Bash for testing
4. Refine procedures based on testing feedback
5. Continue iterating until the procedure is verified through successful testing

Do NOT create final output until the user explicitly requests it. Final output is verified procedure documentation (e.g., `pterodactyl-installation-guide.md`).

## Workflow 2: Analytical Research

Use this workflow when asked to examine artifacts systematically and synthesise findings into a curated analysis.

**When conducting analytical research:**
1. Create an index of all relevant artifacts (commits, issues, code, documentation)
2. Examine each artifact systematically using Read, Grep, and Glob tools
3. Capture ALL findings in the fact file: `.memory/[PROJECT]-[domain]-facts.md` (facts, observations, theories, dead ends)
4. Track all domain fact files in the index: `.memory/[PROJECT]-analysis-index.md`
5. When the user disproves a finding, archive it immediately to a `-disproven.md` file
6. Do NOT create the analysis until the user explicitly requests it

Final output is an analysis document with citations (e.g., `ai-programming-problems-analysis.md`).

---

## Your Process

### 1. Capture Research in Fact Files

**MUST:**
- Append research findings to appropriate domain fact file: `.memory/[PROJECT]-[domain]-facts.md`
- Create domain file if it doesn't exist using Write tool
- Capture broadly: facts, observations, theories, hypotheses, approaches attempted
- Timestamp each entry with date
- Include source reference for traceability
- Update analysis index after appending using Edit tool
- Continue research without pausing for approval

#### When the User Reviews

- Archive a finding immediately to the `-disproven.md` file when the user disproves it
- Incorporate user feedback without interrupting research flow
- Do NOT pause research to ask for approval on individual findings
- Focus on breadth and depth of capture

**MUST NOT:**
- Stop to ask for inline approval during research
- Duplicate existing entries

**Format for entries in fact files:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [file/documentation/observation]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**File Location:** All fact files are processing artifacts and belong in `.memory/[PROJECT]-[domain]-facts.md`

### 2. Archive Disproven Findings

When user disproves a finding or new evidence contradicts it:

**MUST:**
- Move disproven finding from `.memory/[PROJECT]-[domain]-facts.md` to `.memory/[PROJECT]-[domain]-facts-disproven.md`
- Add disproof metadata (date disproven, contradicting evidence, reason)
- Remove from main fact file completely using Edit tool
- Update index to note disproven companion file exists
- Preserve history for transparency

**Format for disproven findings:**
```markdown
### FINDING-YYYY-MM-DD-N (DISPROVEN)
**Originally Captured:** YYYY-MM-DD HH:MM
**Disproven:** YYYY-MM-DD HH:MM
**Original Source:** [original source]
**Contradicting Evidence:** [what disproved this]

~~[Original finding description]~~

**Reason for Disproof:** [Why this is no longer considered accurate]
```

### 3. Update Analysis Index

After appending to fact files or archiving disproven findings:

**MUST:**
- Update or create analysis index file: `.memory/[PROJECT]-analysis-index.md`
- List all domain-specific fact files with brief descriptions
- Note companion disproven files where they exist
- Include file paths and last updated timestamps
- Keep index concise and navigable

**File Location:** Index is a processing artifact and belongs in `.memory/[PROJECT]-analysis-index.md`

**Index format:**
```markdown
# [Project Name] Analysis Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Domain-Specific Fact Files

### Docker & Containerisation
- [.memory/[PROJECT]-docker-facts.md](.memory/[PROJECT]-docker-facts.md) - Docker configuration, container architecture, deployment research
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[PROJECT]-docker-facts-disproven.md](.memory/[PROJECT]-docker-facts-disproven.md) (N findings)

### Architecture
- [.memory/[PROJECT]-architecture-facts.md](.memory/[PROJECT]-architecture-facts.md) - System architecture, components, interactions research
  - Last updated: YYYY-MM-DD HH:MM

[... additional domains ...]

---

## Analysis Outputs

- [`[ANALYSIS-NAME].md`]([ANALYSIS-NAME].md) - [Description]
  - Generated: YYYY-MM-DD HH:MM
  - Sources: [list of fact files used]
```

### 4. Create Final Output (Only When User Requests)

**CRITICAL: Do NOT create final output documents unless user explicitly requests them.**

When user requests final output (examples):
- "Create analysis document on [topic]"
- "Write procedure guide for [topic]"
- "Add findings as section X in document Y"
- "Create page on [topic] in [location]"
- Any explicit request to produce final documentation

**For Procedural Guides:**
- Review fact file containing tested procedures using Read tool
- Extract verified working procedure
- Present draft guide to user for approval in `.memory/[GUIDE-NAME]-PENDING.md`
- Include all steps, requirements, troubleshooting notes
- After approval, create final guide in specified location using Write tool

**For Analytical Reports:**
- Review relevant domain fact files using Read tool
- Run the `verify-memory-facts` workflow on each relevant fact file (see note below)
- Facts already tagged `[VERIFIED on ...]` within the last 30 days are skipped automatically
- Synthesise verified findings into coherent narrative
- Present draft analysis to user for approval in `.memory/[ANALYSIS-NAME]-PENDING.md`
- Include citations back to verified fact files
- After approval, create final analysis in specified location using Write tool

**Note on Fact Verification:**
The `verify-memory-facts` workflow checks every fact against authoritative sources, archives rejected facts with reasons, refreshes citations, and tags verified facts with `[VERIFIED on {date} by {source-url}]`. This workflow should be available as a separate prompt or can be executed manually following verification procedures.

**MUST:**
- Wait for explicit user request before creating any output document
- Run fact verification on each relevant fact file before synthesising an analysis
- Respect user's specified location/document/section for output
- Do NOT commit final output until user explicitly approves
- Present draft in `.memory/` first
- Include proper citations/sources

**MUST NOT:**
- Create draft or final documents without user request
- Assume where output should go (ask if unclear)
- Include unverified or irrelevant findings from fact files
- Proceed without user approval for final output
- Copy fact file content wholesale (filter and synthesise into narrative)

**Prompt user with:**
- For guides: "I've created procedure guide draft in `.memory/[GUIDE-NAME]-PENDING.md`. Please review and approve before I create the final guide."
- For analyses: "I've verified facts in [list domain files] and created analysis draft in `.memory/[ANALYSIS-NAME]-PENDING.md` from the verified findings. Please review and approve before I create the final analysis file."
- If location unclear: "Where should I place this output? (new document in root, add to existing document, specific location?)"

**Final analysis format:**
```markdown
# [Analysis Title]

**Generated:** YYYY-MM-DD HH:MM
**Sources:** [List fact files consulted]

---

## Executive Summary
[High-level synthesis]

## [Section 1]
[Narrative using facts with inline citations to fact files]

## [Section 2]
[etc.]

---

## Sources
- [`[PROJECT]-[domain]-facts.md`]([PROJECT]-[domain]-facts.md) - [Brief description]
```

## Key Principles

### Processing Artifacts vs. Final Outputs

**MUST:**
- Store all processing artifacts in `.memory/` (fact files, indices, drafts, disproven archives)
- Store only final approved outputs in the root (guides, analyses, documentation)
- Capture research broadly in fact files; filter as research progresses when appropriate
- Archive findings to `-disproven.md` files immediately when the user disproves them
- Run fact verification on fact files before synthesising analysis documents

### Quality Control

**MUST:**
- Wait for user approval before publishing any final output
- Archive disproven findings immediately to preserve history
- Verify fact files before creating analysis documents; facts tagged within the last 30 days are skipped automatically
- Maintain the analysis index for navigation and transparency

### Transparency

**MUST:**
- Capture all research in fact files, including approaches attempted and dead ends
- Never delete disproven findings — archive them with the reason for disproof
- Include timestamps on all entries
- Maintain traceability from final output to fact file entries to original sources

## Response to User

When the user invokes this skill for research:

### For Procedural Research

1. Clarify scope: ask what procedure is being researched and what the target context/environment is
2. Search web/docs using WebFetch/WebSearch and capture ALL findings in the fact file
3. Document procedures found, variations, requirements, attempts, and results in the fact file
4. If testing is possible, document all attempts and outcomes using Bash
5. Keep capturing everything in the fact file
6. Do NOT create a guide until the user explicitly requests one

### For Analytical Research

1. Clarify scope: ask which projects/domains to examine and what to look for
2. Examine artifacts systematically using Read, Grep, Glob; capture findings in domain fact files
3. Maintain the analysis index linking all fact files
4. Archive a finding immediately to the `-disproven.md` file when the user disproves it
5. Keep building fact files
6. Do NOT create an analysis until the user explicitly requests one

### When the User Requests Final Output

- Use the location the user specifies (new document, section in existing document, specific page)
- If no location is specified, ask for the document name/location before proceeding
- For analyses: run fact verification on each relevant fact file first; facts tagged within the last 30 days are skipped unless you request re-verification
- Create the draft in `.memory/[NAME]-PENDING.md` using Write tool
- Present the draft for approval before publishing

### Key Reminders

**MUST:**
- Store all processing artifacts in `.memory/`
- Capture broadly in fact files; archive disproven findings immediately, never delete
- Run fact verification before synthesising any analysis
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
