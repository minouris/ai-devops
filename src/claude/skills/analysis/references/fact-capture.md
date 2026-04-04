# Fact-Capture Flow Specification

**This document defines the fact-capture flow as invoked by research workflows (procedural-research and analytical-research).**

---

# Flow Purpose

The fact-capture flow is responsible for **all aspects of recording, formatting, verification, indexing, and term linking** for research findings. Research workflows do not implement fact-capture logic; they invoke this flow.

---

# Flow Invocation Interface

## Standard Finding Capture

When a research workflow encounters a finding, invoke the fact-capture flow:

```
Invoke fact-capture flow with:
- topic: [string] - Topic slug used throughout research (e.g., "ai-config-distribution-strategies")
- observation: [string] - Finding description: fact, observation, theory, hypothesis, dead end, or note
- source: [string] - Citation to authoritative source, URL, file path, or "User observation"
- subtopic: [optional string] - Subtopic category if finding belongs to specific area within topic
- clarifies: [optional string] - FINDING-YYYY-MM-DD-N if this clarifies an existing finding
```

## Disproven Finding Archive

When research workflow receives user feedback that a finding is disproven, invoke the fact-capture flow:

```
Invoke fact-capture flow with:
- action: "archive-disproven"
- topic: [string] - Topic slug
- finding-id: [string] - FINDING-YYYY-MM-DD-N identifier of finding to archive
- reason: [string] - User explanation of why finding is disproven
```

---

# Flow Responsibilities (What Fact-Capture MUST Do)

When invoked, the fact-capture flow is **solely responsible** for:

## Finding Recording
- Generate unique FINDING-YYYY-MM-DD-N identifiers
- Create or append to fact files in proper location (`.memory/[topic]/[topic]-facts.md` or `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-facts.md`)
- Add **Captured:** YYYY-MM-DD HH:MM timestamp to each finding
- Add **Verified:** [NOT YET VERIFIED - requires verification workflow] tag to each new finding
- Record complete observation text with source citation

## File Structure Management
- Create topic directories (`.memory/[topic]/`) when needed
- Create subtopic directories (`.memory/[topic]/[topic]-[subtopic]/`) when thresholds exceeded
- Manage file naming conventions and folder organisation
- Maintain folder-based structure (.memory/[topic]/ not flat .memory/ root)
- Enforce maximum file size (40,000 characters) with automatic subtopic creation when exceeded

## Index Maintenance
- Maintain `.memory/[topic]/[topic]-index.md` as single source of truth for all findings
- Add findings to findings table only after capturing in fact file
- Organise findings table by Topic (primary) and Name (secondary)
- Link findings to their actual location in fact files
- Update verification status counts
- **NEVER create per-subtopic indices** - all findings route through main topic index

## Term Management (Before Verification)
- Extract semantic terms automatically when findings introduce new concepts
- Create `.memory/[topic]/[topic]-terms.md` or `.memory/[topic]/[topic]-[subtopic]/[topic]-[subtopic]-terms.md`
- Create bidirectional links between findings and terms
- Maintain term index with proper entry format

## Disproven Finding Management
- Move disproven findings to `-disproven.md` companion file
- Record disproof metadata (when, reason, who disproved)
- Preserve full context of original finding
- Never delete disproven findings

## Clarification Handling
- Append clarifications as new FINDING-YYYY-MM-DD-N entries
- Link clarifications to original findings via `Clarifies:` reference
- Leave original findings unchanged
- Store clarifications in same fact file as originals

## Documentation-First Compliance
- Verify all findings reference authoritative sources
- Enforce source citations on every finding
- Reject findings without proper source documentation

---

# Flow Guarantees (Idempotence)

The fact-capture flow **MUST** be idempotent and absolute:

1. **Multiple invocations of the same finding are safe**: If the same finding is invoked twice with identical parameters, it is recorded once (not duplicated)

2. **Finding references are globally consistent**: Any invocation that references another finding by ID (e.g., `clarifies: FINDING-2026-04-04-01`) works consistently regardless of invocation order

3. **Fact files remain in valid state**: The fact-capture flow never leaves fact files in incomplete or inconsistent states

4. **Index always reflects actual findings**: Index is updated synchronously with fact capture; index and fact files never diverge

5. **File location migrations are transparent**: If a finding is moved to a new subtopic file due to size thresholds, the finding reference (e.g., `FINDING-2026-04-04-01`) remains valid and consistent

---

# Research Workflow Restrictions

Research workflows (procedural-research, analytical-research) **MUST NOT**:

- Write directly to fact files
- Manage file structure or folder organisation
- Update indices manually
- Format fact entries
- Create finding identifiers
- Add verification tags
- Handle file size management
- Create or manage subtopics
- Extract or link terms
- Archive disproven findings

Research workflows must invoke the fact-capture flow for all recording, maintenance, and verification tasks.

---

# Verification Phase (Separate from Capture)

This flow specification covers fact CAPTURE only. After fact capture is complete:

- Research workflows are finished
- The verify-analysis skill takes over
- verify-analysis verifies each finding against sources
- verify-analysis extracts and verifies terms
- verify-analysis updates findings with [VERIFIED on YYYY-MM-DD by source-url] tags
- verify-analysis updates indices with verification status
- Only then are findings considered "complete"

See [verify-analysis skill](../../verify-analysis/SKILL.md) for the verification workflow.

---

# How Fact-Capture Flow is Implemented

**CRITICAL:** This specification defines WHAT the fact-capture flow does, not HOW it is implemented.

Implementation details (which tools are used, file I/O patterns, parsing logic, etc.) are encapsulated within the fact-capture flow and **MUST NOT be visible to research workflows**.

Research workflows invoke the flow by name with defined parameters. The implementation is a black box.

---

# Before Finalizing Research: Terminology Verification

After fact capture is complete, research workflows must request fact verification:

For each captured finding:
1. Notice any semantic concepts or terminology introduced in the finding
2. Request term verification: "Please verify terminology used in FINDING-2026-04-04-01"
3. The verify-analysis skill updates findings with verified term references
4. Findings are amended to use standardised terminology from verified terms

See [verify-analysis skill](../../verify-analysis/SKILL.md) for the complete verification workflow.

---

# Flow Idempotence Examples

**Example 1: Duplicate invocation**
```
First invocation:
- topic: github-api
- observation: "REST API returns 200 on success"
- source: https://docs.github.com/en/rest

Second invocation with identical parameters:
- Result: Finding not duplicated; same FINDING-YYYY-MM-DD-N used
```

**Example 2: Clarification ordering**
```
Research captures: FINDING-2026-04-04-01 (initial observation)
Research captures: FINDING-2026-04-04-02 (clarifies FINDING-2026-04-04-01)
Research captures: FINDING-2026-04-04-03 (clarifies FINDING-2026-04-04-01)

Result: All clarifications properly linked and ordered, links remain valid regardless of invocation sequence
```

**Example 3: File migration due to size**
```
FINDING-2026-04-04-01 initially in ai-config-distribution-strategies-facts.md
→ When main file exceeds 40,000 characters, finding moves to subtopic file
→ FINDING-2026-04-04-01 reference remains valid: fact-capture flow handles redirect
→ Index still links to FINDING-2026-04-04-01 correctly
```

---
