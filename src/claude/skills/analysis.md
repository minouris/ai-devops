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
- Use cached documentation content without re-reading current files

### Two-Stage Text Search (MANDATORY)

When searching for information within files or documentation, use a two-stage approach before concluding that information is unavailable.

**Stage 1 — Keyword search:**
- Use Grep or search tools as the initial approach
- Try multiple related terms, synonyms, and variations

**If Stage 1 yields no results or only false positives, proceed to Stage 2:**

**Stage 2 — Direct file examination:**
- Read the full relevant file or section directly using Read tool
- Policy rationales, design decisions, and contextual reasoning are frequently expressed in natural language rather than consistent searchable keywords
- Do NOT report information as unavailable until Stage 2 has been completed

**MUST NOT:**
- Report that information cannot be found after only a keyword search
- Treat Grep returning zero results as confirmation that information does not exist

---

# Research Workflows

## Workflow 1: Procedural Research

Use this workflow when asked to find, test, and verify a procedure or process.

**When conducting procedural research:**
1. Search web/docs for procedures using WebFetch or WebSearch
2. Capture all findings in the fact file: `.memory/[topic]-facts.md`
3. Document test results (worked/failed, why) using Bash for testing
4. Refine procedures based on testing feedback
5. Continue iterating until the procedure is verified through successful testing

Do NOT create final output until the user explicitly requests it. Final output is verified procedure documentation (e.g., `pterodactyl-installation-guide.md`).

## Workflow 2: Analytical Research

Use this workflow when asked to examine artifacts systematically and synthesise findings into a curated analysis.

**When conducting analytical research:**
1. Create an index of all relevant artifacts (commits, issues, code, documentation)
2. Examine each artifact systematically using Read, Grep, and Glob tools
3. Capture ALL findings in the fact file: `.memory/[topic]-facts.md` (facts, observations, theories, dead ends)
4. Track the fact file and its companions in the index: `.memory/[topic]-index.md`
5. When the user disproves a finding, archive it immediately to a `-disproven.md` file
6. Do NOT create the analysis until the user explicitly requests it

Final output is an analysis document with citations (e.g., `ai-programming-problems-analysis.md`).

---

## Your Process

### 1. Capture Research in Fact Files

**MUST:**
- Append research findings to the topic fact file: `.memory/[topic]-facts.md`
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

#### Clarifying Existing Facts

When new information (from further research or supplied by the user) affects or refines an existing fact:

**MUST:**
- Append it as a new finding with a reference to the fact it clarifies (`Clarifies: FINDING-YYYY-MM-DD-N`)
- Leave the original finding unchanged
- Continue appending further clarifications as additional new findings

**MUST NOT:**
- Edit or merge new information into an existing finding during the research phase
- Treat a clarification as a correction to be applied immediately

Clarifications are applied to their base facts during the verification step (using verify-memory-facts prompt), in reverse chronological order, so that later clarifications can supersede earlier ones before any are merged.

**MUST NOT:**
- Stop to ask for inline approval during research
- Duplicate existing entries
- Write new findings to any `-PENDING.md` or draft output file — these are output artifacts, not research records
- Edit any pending analysis file during the research phase, even to "update" it with new findings

**File boundary — research phase:**
- **Fact files** (`.memory/[topic]-facts.md` or `.memory/[topic]-[subtopic]-facts.md`) — the only files you write to during research
- **Pending analysis** (`.memory/[NAME]-PENDING.md`) — read-only during research; written only once when user requests final output
- **Final output** (root or specified location) — written only after user approval of pending analysis

**Subtopic files:** When a topic has distinct areas requiring separate fact files, create `.memory/[topic]-[subtopic]-facts.md`. The main topic prefix is mandatory. The index at `.memory/[topic]-index.md` lists all subtopic files.

**Format for entries in fact files:**
```markdown
### FINDING-YYYY-MM-DD-N
**Captured:** YYYY-MM-DD HH:MM
**Source:** [file/documentation/observation]

[Finding description - fact, observation, theory, hypothesis, or note]

[Optional: Additional context, implications, or questions]
```

**File Location:** All fact files are processing artifacts and belong in `.memory/[topic]-facts.md` or `.memory/[topic]-[subtopic]-facts.md`

### 2. Archive Disproven Findings

When user disproves a finding or new evidence contradicts it:

**MUST:**
- Move disproven finding from `.memory/[topic]-facts.md` (or the relevant subtopic file) to `.memory/[topic]-facts-disproven.md` (or `.memory/[topic]-[subtopic]-facts-disproven.md`)
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
- Update or create analysis index file: `.memory/[topic]-index.md`
- List all fact files (including subtopic files) with brief descriptions
- Note companion disproven files where they exist
- Include file paths and last updated timestamps
- Keep index concise and navigable

**File Location:** Index is a processing artifact and belongs in `.memory/[topic]-index.md`

**Index format:**
```markdown
# [topic] Index

**Last Updated:** YYYY-MM-DD HH:MM

---

## Fact File

- [.memory/[topic]-facts.md](.memory/[topic]-facts.md) - [Brief description of research scope]
  - Last updated: YYYY-MM-DD HH:MM
  - Disproven: [.memory/[topic]-facts-disproven.md](.memory/[topic]-facts-disproven.md) (N findings)

---

## Analysis Outputs

- [`[ANALYSIS-NAME].md`]([ANALYSIS-NAME].md) - [Description]
  - Generated: YYYY-MM-DD HH:MM
  - Sources: [list of fact files used]
```

### 4. Create Final Output (Only When User Requests)

**CRITICAL: Do NOT create final output documents unless user explicitly requests them.**

#### Research Completeness Gate (MANDATORY)

Before synthesising any draft output, you MUST:
1. State which sources and artifacts have been examined
2. Identify any gaps — topics or sources that were identified but not yet researched
3. If gaps exist, report them to the user and wait for instruction before proceeding

Do NOT synthesise a draft that presents conclusions about areas that have not been researched. If a relationship or claim in the draft relies on inference rather than examined evidence, you must explicitly mark it as unverified inference, or complete the relevant research first.

**MUST NOT:**
- Present inferred relationships as established findings in a draft
- Synthesise a draft covering "solutions" or "causes" that have not been examined in fact files
- Proceed past this gate without explicit user confirmation when gaps exist

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
- Run the `verify-memory-facts` workflow on each relevant fact file (defined in [verify-memory-facts.md](../prompts/verify-memory-facts.md)): checks every fact against authoritative sources, archives rejected facts with reasons, refreshes citations, and tags verified facts with `[VERIFIED on {date} by {source-url}]`
- Before verifying base facts, apply any clarifying findings in reverse chronological order (newest clarification first), so later clarifications supersede earlier ones before the base fact is finalised
- Facts already tagged `[VERIFIED on ...]` within the last 30 days are skipped automatically — request re-verification explicitly if needed (e.g., "force re-verify all facts")
- Synthesise verified findings into coherent narrative
- Present draft analysis to user for approval in `.memory/[ANALYSIS-NAME]-PENDING.md`
- Include citations back to verified fact files
- After approval, create final analysis in specified location using Write tool

**MUST:**
- Wait for explicit user request before creating any output document
- Run [verify-memory-facts](../prompts/verify-memory-facts.md) on each relevant fact file before synthesising an analysis
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
- For analyses: "I've run [verify-memory-facts](../prompts/verify-memory-facts.md) on [list domain files] and created analysis draft in `.memory/[ANALYSIS-NAME]-PENDING.md` from the verified findings. Please review and approve before I create the final analysis file."
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
- [`.memory/[topic]-facts.md`](.memory/[topic]-facts.md) - [Brief description]
```

## Key Principles

### Processing Artifacts vs. Final Outputs

**MUST:**
- Store all processing artifacts in `.memory/` (fact files, indices, drafts, disproven archives)
- Store only final approved outputs in the root (guides, analyses, documentation)
- Capture research broadly in fact files; filter as research progresses when appropriate
- Archive findings to `-disproven.md` files immediately when the user disproves them
- Run [verify-memory-facts](../prompts/verify-memory-facts.md) on fact files before synthesising analysis documents

### Quality Control

**MUST:**
- Wait for user approval before publishing any final output
- Archive disproven findings immediately to preserve history
- Verify fact files using [verify-memory-facts](../prompts/verify-memory-facts.md) before creating analysis documents; facts tagged within the last 30 days are skipped automatically
- Maintain the analysis index for navigation and transparency

### Transparency

**MUST:**
- Capture all research in fact files, including approaches attempted and dead ends
- Never delete disproven findings — archive them with the reason for disproof
- Include timestamps on all entries
- Maintain traceability from final output to fact file entries to original sources

### Operation Logging

After each significant operation, run [record-operation](../prompts/record-operation.prompt.md) with the confirmed topic slug (if available in your workspace).

**Significant operations include:**
- Appending findings to a fact file
- Archiving disproven findings
- Updating the analysis index
- Creating or updating a pending analysis draft
- Publishing a final output

**MUST:**
- Run `record-operation` with `topic=[slug]` after each operation above (if the prompt is available)
- Record only what changed in the current operation — not a summary of the whole session
- Append to `.memory/[topic]-log.md`; never overwrite earlier entries

**MUST NOT:**
- Skip logging because an operation seemed minor
- Log speculative or unconfirmed information

**Note:** The record-operation prompt may not be available in all workspaces. If it's not present, skip this step.

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

When the user engages you for research:

### For Procedural Research

1. Clarify scope: ask what procedure is being researched and what the target context/environment is
2. Confirm the topic slug with the user (e.g., `pterodactyl-install`); this is used for file naming and operation logging throughout this work
3. Search web/docs using WebFetch/WebSearch and capture ALL findings in the fact file
4. Document procedures found, variations, requirements, attempts, and results in the fact file
5. If testing is possible, document all attempts and outcomes using Bash
6. Keep capturing everything in the fact file
7. Do NOT create a guide until the user explicitly requests one

### For Analytical Research

1. Clarify scope: ask which projects/domains to examine and what to look for
2. Confirm the topic slug with the user (e.g., `ai-problems-analysis`); this is used for file naming and operation logging throughout this work
3. Examine artifacts systematically using Read, Grep, Glob; capture findings in fact files
4. Maintain the analysis index linking all fact files
5. Archive a finding immediately to the `-disproven.md` file when the user disproves it
6. Keep building fact files
7. Do NOT create an analysis until the user explicitly requests one

### When the User Requests Final Output

- Use the location the user specifies (new document, section in existing document, specific page)
- If no location is specified, ask for the document name/location before proceeding
- For analyses: run [verify-memory-facts](../prompts/verify-memory-facts.md) on each relevant fact file first; facts tagged within the last 30 days are skipped unless you request re-verification
- Create the draft in `.memory/[NAME]-PENDING.md` using Write tool
- Present the draft for approval before publishing

### Key Reminders

**MUST:**
- Store all processing artifacts in `.memory/`
- Capture broadly in fact files; archive disproven findings immediately, never delete
- Run [verify-memory-facts](../prompts/verify-memory-facts.md) before synthesising any analysis
- Run [record-operation](../prompts/record-operation.prompt.md) with the topic slug after each significant operation (if available)
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
