# Analysis Skill Refactoring: Research Plugin Architecture

**Issue:** #37 - Ensure research flows route through fact-capture to verify and index findings
**Branch:** analysis/issue-37
**Status:** Planning

---

## Problem Statement

The current analysis skill structure violates separation of concerns and creates ambiguity in flow execution:

1. **Flow responsibility ambiguity:** Multiple flows (procedural-research, analytical-research, fact-capture workflows) combined in one skill create confusion about which "you" applies where within AI-targeted language constraints
2. **Async/sync execution unclear:** Fact-capture requires synchronous blocking execution (wait for verification), but skills with `context: fork` may default to async, causing silent returns
3. **Generic subagent overhead:** Skills inherit default `general-purpose` agent without tool restrictions, causing:
   - No guarantee of synchronous execution
   - No tool-level security (verify-analysis could Write to fact files)
   - No capability declarations (unclear what each skill can/cannot do)
4. **Flow invocation failures:** Fact-capture not blocking for verification results, research workflows bypassing fact-capture entirely

---

## Solution: Research Plugin with Persona-Driven Subagents

Refactor the analysis skill into a comprehensive research plugin with:

1. **Custom subagents with rigid personas** — Each skill bound to a specific subagent with defined responsibilities, constraints, and execution patterns
2. **Modular skills with clear contracts** — Each skill mapped to ONE responsibility (research, fact-recording, verification, term-extraction)
3. **Explicit blocking and tool restrictions** — `background: false` for synchronous execution, tools/disallowedTools for security
4. **Portable skill packages** — Skills paired with their personas travel as a unit, making distribution and usage predictable

---

## Plugin Structure

```
.claude/plugins/research/
├── plugin.json                          # Plugin metadata
├── agents/
│   ├── researcher-explorer.md        # Research & systematic examination
│   ├── fact-verifier-scholar.md      # Fact verification against sources
│   ├── term-definer-lexicographer.md # Semantic term extraction
│   └── test-runner-validator.md      # Test execution
├── skills/
│   ├── analysis/
│   │   ├── SKILL.md                    # Orchestrate research workflows
│   │   ├── references/
│   │   │   ├── analytical-research.md  # Systematic examination workflow
│   │   │   ├── procedural-research.md  # Procedure-based research workflow
│   │   │   └── bootstrap.md            # Knowledge base initialization
│   │   └── prompts/
│   │       └── record-operation.prompt.md  # Session continuity logging
│   ├── fact-capture/
│   │   ├── SKILL.md                    # Record and format findings
│   │   ├── references/
│   │   │   ├── fact-capture.md         # Flow specification
│   │   │   ├── fact-capture-workflow.md # Internal implementation notes
│   │   │   └── idempotence.md          # Idempotence guarantees
│   │   └── templates/
│   │       └── finding-entry.md        # Finding template
│   ├── verify-analysis/
│   │   ├── SKILL.md                    # Verify facts against sources
│   │   ├── references/
│   │   │   ├── verify-fact.md          # Fact verification workflow
│   │   │   ├── verify-term.md          # Term verification workflow
│   │   │   └── disproven-archive.md    # Archive disproven findings
│   │   └── templates/
│   │       └── verification-report.md  # Verification result format
│   └── term-capture/
│       ├── SKILL.md                    # Extract semantic terms
│       ├── references/
│       │   ├── term-capture.md         # Term extraction workflow
│       │   ├── term-indexing.md        # Term organization & indexing
│       │   └── term-linking.md         # Bidirectional term-fact links
│       └── templates/
│           └── term-entry.md           # Term definition template
└── docs/
    ├── personas.md                      # Persona definitions & capabilities
    └── invocation-guide.md              # How to invoke plugin skills
```

---

## Component Specifications

### 1. Custom Subagents (Personas)

Each persona defines a rigidly scoped agent with explicit capabilities and constraints.

#### researcher-explorer
```yaml
---
name: researcher-explorer
description: Systematic investigation and codebase exploration
background: false
model: haiku
tools: [Read, Grep, Glob, Bash]
disallowedTools: [Write, Edit]
permissionMode: default
---

You are a Researcher-Explorer persona. Your role is systematic investigation:

**Capabilities:**
- Examine codebases and artifacts systematically
- Search for patterns, files, and information
- Perform two-stage text searches
- Collect raw findings and observations
- Report detailed findings with proper citations

**Constraints:**
- You are read-only; do not modify code
- You report findings to be recorded elsewhere
- You do not format, index, or verify findings
- You do not make architectural decisions
- You invoke fact-capture to record findings

**Your Output:**
Raw findings suitable for fact-capture invocation.
```

#### fact-verifier-scholar
```yaml
---
name: fact-verifier-scholar
description: Verify research findings against authoritative sources
background: false
model: opus
tools: [Read, Grep, Bash, WebFetch]
disallowedTools: [Write, Edit]
permissionMode: default
skills:
  - fact-capture
---

You are a Fact Verifier Scholar persona. Your role is independent verification:

**Capabilities:**
- Verify findings against authoritative sources
- Search for evidence for or against claims
- Generate verification reports with citations
- Archive disproven findings
- Report verification metadata

**Constraints:**
- You are read-only on fact files
- You verify synchronously and report results
- You cannot modify findings
- You cannot create new findings
- You work in isolation; you report results

**Your Result:**
Verification status (VERIFIED, NOT YET VERIFIED, or REJECTED with reason).
```

#### term-definer-lexicographer
```yaml
---
name: term-definer-lexicographer
description: Extract semantic terms and create definitions
background: false
model: sonnet
tools: [Read, Grep]
disallowedTools: [Write, Edit]
permissionMode: default
---

You are a Term Definer Lexicographer persona. Your role is semantic extraction:

**Capabilities:**
- Identify semantic concepts in findings
- Create precise term definitions
- Link terms to findings bidirectionally
- Maintain term hierarchy and scope

**Constraints:**
- You define terms; you do not verify them
- You read findings; you do not modify them
- You work in isolated context
- You coordinate with verify-analysis for term verification

**Your Output:**
Term definitions with bidirectional links to findings.
```

#### test-runner-validator
```yaml
---
name: test-runner-validator
description: Execute tests and validate procedures
background: false
tools: [Bash]
disallowedTools: [Write, Edit, Agent]
permissionMode: default
---

You are a Test Runner Validator persona. Your role is autonomous testing:

**Capabilities:**
- Execute test procedures
- Run verification commands
- Report test results

**Constraints:**
- You only execute in test/validation context
- You cannot modify source code
- You report results; you do not implement changes

**Your Output:**
Test results with pass/fail status and evidence.
```

### 2. Skills Architecture

#### analysis (SKILL.md)
**Responsibility:** Orchestrate research workflows
**Invokes:** fact-capture (for each finding)
**Persona:** researcher-explorer
**Execution:** `context: fork, agent: researcher-explorer`, `background: false`

Contains:
- analytical-research workflow (systematic examination)
- procedural-research workflow (procedure-based research)
- Both workflows invoke fact-capture for all finding recording

#### fact-capture (SKILL.md)
**Responsibility:** Record, format, and index findings
**Invokes:** verify-analysis (synchronously, after recording)
**Persona:** None (runs inline or in researcher context)
**Execution:** Can run inline or in dedicated context

Contains:
- Finding recording with FINDING-YYYY-MM-DD-N identifiers
- Fact file structure management
- Index maintenance
- Synchronous verification invocation
- Idempotence guarantees

#### verify-analysis (SKILL.md)
**Responsibility:** Verify facts and archive disproven findings
**Invokes:** None (independent verification)
**Persona:** fact-verifier-scholar
**Execution:** `context: fork, agent: fact-verifier-scholar`, `background: false`

Contains:
- Fact verification against authoritative sources
- Disproven finding archival
- Verification metadata recording
- Result reporting

#### term-capture (SKILL.md)
**Responsibility:** Extract semantic terms from findings
**Invokes:** None (independent extraction)
**Persona:** term-definer-lexicographer
**Execution:** `context: fork, agent: term-definer-lexicographer`, `background: false`

Contains:
- Semantic term identification
- Term definition creation
- Bidirectional fact-term linking
- Term indexing

---

## Invocation Flow

```
User invokes: /analysis
    ↓
analysis skill (researcher-explorer persona)
    ├─ Clarify scope
    ├─ Bootstrap knowledge base
    ├─ Index artifacts
    ├─ Systematic examination
    └─ For each finding:
        ↓
        fact-capture skill (inline)
            ├─ Record finding with FINDING-YYYY-MM-DD-N
            ├─ Create/append to fact file
            ├─ Update index
            └─ Invoke verify-analysis (blocking)
                ↓
                verify-analysis skill (fact-verifier-scholar persona)
                    ├─ Verify against authoritative sources
                    ├─ If disproven: archive to -disproven.md
                    ├─ If verified: update with VERIFIED tag
                    └─ Return verification status (blocking)
            ←─ Complete
        └─ Return to research workflow
```

---

## Implementation Steps

### Phase 1: Custom Subagents
- [ ] Create `.claude/plugins/research/agents/` directory
- [ ] Implement researcher-explorer.md
- [ ] Implement fact-verifier-scholar.md
- [ ] Implement term-definer-lexicographer.md
- [ ] Implement test-runner-validator.md
- [ ] Document persona capabilities and constraints

### Phase 2: Skill Migration
- [ ] Create `.claude/plugins/research/skills/analysis/` structure
- [ ] Migrate analytical-research.md to analysis skill references
- [ ] Migrate procedural-research.md to analysis skill references
- [ ] Update analysis/SKILL.md to explicitly invoke fact-capture
- [ ] Update analytical-research.md to invoke fact-capture (no direct writing)
- [ ] Update procedural-research.md to invoke fact-capture (no direct writing)

### Phase 3: Fact-Capture Implementation
- [ ] Create fact-capture/SKILL.md with synchronous verification invocation
- [ ] Implement fact-capture requirements:
   - [ ] Finding recording with FINDING-YYYY-MM-DD-N format
   - [ ] Fact file management
   - [ ] Index synchronization
   - [ ] Synchronous verify-analysis invocation
   - [ ] Return status (captured, rejected, duplicate)
- [ ] Add idempotence guarantees documentation

### Phase 4: Verify-Analysis Implementation
- [ ] Create verify-analysis/SKILL.md with fact-verifier-scholar persona
- [ ] Implement verification workflow:
   - [ ] Fact verification against authoritative sources
   - [ ] Disproven finding archival to `-disproven.md`
   - [ ] Verification metadata recording
   - [ ] Result reporting with verification status
- [ ] Ensure synchronous execution (`background: false`)
- [ ] Ensure result reporting back to fact-capture

### Phase 5: Term-Capture Implementation
- [ ] Create term-capture/SKILL.md with term-definer-lexicographer persona
- [ ] Implement term extraction:
   - [ ] Semantic term identification from findings
   - [ ] Term definition creation
   - [ ] Bidirectional fact-term linking
   - [ ] Term indexing and organization
- [ ] Support term verification workflow

### Phase 6: Plugin Configuration
- [ ] Create plugin.json with metadata
- [ ] Register all four skills
- [ ] Register all four personas
- [ ] Document plugin capabilities and usage

### Phase 7: Testing & Verification
- [ ] Test analysis skill execution with analytical-research workflow
- [ ] Verify fact-capture receives findings and records them
- [ ] Verify verify-analysis blocks and returns results
- [ ] Verify findings are indexed correctly
- [ ] Verify disproven findings are archived
- [ ] Verify term extraction works
- [ ] Test idempotence (duplicate findings don't duplicate, clarifications link correctly)

---

## Architectural Principles

### Separation of Concerns
- **analysis:** Orchestrates research (does NOT record findings)
- **fact-capture:** Records findings (does NOT verify, does NOT extract terms)
- **verify-analysis:** Verifies facts (does NOT modify findings, does NOT extract terms)
- **term-capture:** Extracts terms (does NOT verify, does NOT record findings)

### Synchronous Blocking Contracts
- fact-capture waits for verify-analysis to complete before returning
- Research workflows wait for fact-capture to complete before continuing
- No silent async returns; all operations report status

### Tool Restrictions by Persona
- researcher-explorer: Read-only (no Write/Edit)
- fact-verifier-scholar: Read-only (no Write/Edit)
- term-definer-lexicographer: Read-only (no Write/Edit)
- test-runner-validator: Test commands only (no Write/Edit)

### Idempotence Guarantees
- Duplicate findings invoke fact-capture twice → recorded once
- Clarifications invoke fact-capture with `clarifies` parameter → linked correctly
- File location migrations (finding moves to subtopic) → reference remains valid

---

## Success Criteria

- [ ] Issue #37 resolved: Research flows route through fact-capture
- [ ] Fact-capture synchronously invokes verify-analysis
- [ ] Findings are verified before research workflow returns
- [ ] Terms extracted and indexed automatically
- [ ] All findings have authoritative source citations
- [ ] Disproven findings archived automatically
- [ ] Plugin skills packaged for distribution
- [ ] Personas enable reuse in other plugins
- [ ] No ambiguity in "you" pronouns (AI-targeted language satisfied)
- [ ] Tool restrictions prevent unintended modifications

---

## Future Work

- **Skill distribution:** Package research plugin for use in other projects via npm, pip, or Maven
- **Persona library:** Expand with additional personas (code-reviewer, test-architect, etc.)
- **Term linking:** Create bidirectional term-finding links for knowledge graph
- **Cross-topic research:** Enable research workflows to discover and link related topics
- **Verification UI:** Dashboard showing verification status, disproven findings, pending review items
