---
name: verify-fact
description: Verify individual research findings against official sources with sub-agent autonomy
allowed-tools: Read, Edit, Write, WebFetch, WebSearch
context: fork
---

# Verify Fact Skill

Verify individual research findings against authoritative sources and update memory files with verification status.

## Overview

This skill executes fact verification at the individual finding level, designed to work as a delegated sub-agent task. It:
- Retrieves a specific finding from a memory file
- Fetches authoritative sources (official documentation, test results, experimental data, live APIs) and compares claims
- Tags findings as VERIFIED or marks for manual verification
- Archives disproven findings immediately
- Updates fact files atomically

**What counts as authoritative "proof":**
- Official documentation and specifications
- Output from reproducible local tests or scripts
- Results from experimentation against live APIs (with command/test output)
- Technical specifications and published standards
- Direct observations from reproducible procedures

## Usage

```
/verify-fact <topic> [<subtopic>] <finding-id>
```

### Parameters

- **topic** (required): Topic slug (e.g., `github-api`)
- **subtopic** (optional): Subtopic folder name (e.g., `github-api-authentication`)
- **finding-id** (required): Finding identifier (e.g., `FINDING-2026-03-11-06`)

### Examples

```
/verify-fact github-api FINDING-2026-03-11-06
/verify-fact github-api github-api-authentication FINDING-2026-03-11-16
```

## Verification Workflow

### 1. Locate and Read Finding

1. Determine fact file path from topic/subtopic
2. Read fact file and locate the specified FINDING
3. Extract all claims from the finding
4. Retrieve source URL from fact metadata

### 2. Fetch or Reproduce Source and Gather Evidence

1. **For documentation claims:** Use WebFetch or WebSearch to load source content fresh
2. **For test/experimental claims:** Execute or reproduce the test/procedure that proves/disproves the claim
3. **For API claims:** Make actual API calls (if possible) or fetch live documentation
4. Compare fact claims against actual source content or test output
5. Check source/documentation publication dates for currency
6. **Gather all proof text/evidence before proceeding** - collect verbatim excerpts, test output, API responses, etc. for every claim
7. Document any discrepancies

### 3. Determine Verification Status (In Memory, No File Updates Yet)

Analyze all gathered evidence and determine status:

**VERIFIED:** All claims match source content exactly
- Status: VERIFIED
- Reason: (from evidence comparison)

**DISPROVEN:** Claims contradict official source documentation
- Status: DISPROVEN
- Archive destination: `-disproven.md` file
- Reason: (from evidence comparison)

**MANUAL VERIFICATION REQUIRED:** Source cannot be accessed automatically
- Status: MANUAL VERIFICATION REQUIRED
- Reason: (specific access limitation encountered)

### 4. Create and Populate Verification Working Document

Once status is determined and all evidence is gathered:

1. **Create if not exists:** `.memory/[topic]/[topic]-[subtopic]-verification-working.md` (or `.memory/[topic]/[topic]-verification-working.md` for main topic)
2. **Append complete verification entry** with all required sections:
   - Finding ID
   - Date, source URL, publication date
   - Verification method
   - Status
   - All claims with verification results
   - **Full proof text evidence** (verbatim excerpts from source, test output, API responses)
   - Discrepancies or disproof explanations

**DO NOT create or modify the working document until evidence gathering is complete.**

### 5. Archive or Update Fact File (Final Step)

Only after verification working document is complete, update the primary fact file:

1. **If VERIFIED:** Add verification tag to finding: `[VERIFIED on YYYY-MM-DD by [source-url]]`
2. **If DISPROVEN:** Move finding to `-disproven.md` archive file with full disproof details
3. **If MANUAL:** Add note in fact file: `[MANUAL VERIFICATION REQUIRED - reason]`

**Marking a fact as verified (or otherwise tagged) is the LAST step, after evidence documentation is complete.**

### 6. Report Results

Return detailed verification report including:
- Finding ID and all claims verified
- Source URL and verification method
- Verification status and specific results for each claim
- Any manual verification notes or disproof evidence

---

## Verification Working Document Entry Format

Reference template for the complete verification entry structure:

```markdown
### FINDING-YYYY-MM-DD-N Verification

**Date Verified:** YYYY-MM-DD
**Source:** [source-url]
**Source Publication Date:** YYYY-MM-DD (or current if updated regularly)
**Method:** WebFetch/WebSearch/Testing
**Status:** VERIFIED/DISPROVEN/MANUAL VERIFICATION REQUIRED

**Claims Verified:**
- Claim 1: [concise verification result]
- Claim 2: [concise verification result]

**Evidence:**
The following proof from the authoritative source confirms or contradicts each claim:

*Claim 1:*
> [Verbatim excerpt from documentation, test output, API response, or experimental result proving or disproving this specific claim]
Source section/location: [Document section, test file location, or API endpoint where result appears]

*Claim 2:*
> [Verbatim excerpt from documentation, test output, API response, or experimental result proving or disproving this specific claim]
Source section/location: [Document section, test file location, or API endpoint where result appears]

[If DISPROVEN: Detailed explanation of how source contradicts the finding, including relevant quotes or test output]
[If MANUAL: Specific explanation of verification limitation, and what type of verification would be required instead]
```

## Mandatory Verification Standards

**Source Fetching or Testing:**
- Use WebFetch or WebSearch for documentation claims
- Execute or reproduce tests for experimental/test-based claims
- Make live API calls or fetch documentation for API claims
- Load source content fresh (no cached assumptions or cached test results)
- Verify individual claims against actual authoritative source content or test output

**Content Comparison:**
- Compare fact statement against source content or test output directly
- Not just checking URL/source existence
- Verify technical accuracy, specifications, behaviors
- Validate test output against expected results and findings

**Currency Checking:**
- Review source publication dates (for documentation)
- Verify test/experimental procedures are still valid
- Flag if source appears outdated
- Note if source cannot be accessed or test cannot be reproduced

**No Batch Verification:**
- Each finding verified independently
- Fresh fetch/test per finding (no assumptions carry over from previous verifications)
- Complete verification before moving to next finding

**Evidence Capture (MANDATORY):**
- Capture verbatim excerpts, direct quotes, test output, or API response text from authoritative sources
- Each claim must have corresponding proof text/output from the source
- Include source section/URL fragment, test file location, or API endpoint identifying where proof appears
- For DISPROVEN findings: include exact contradicting text from source or test output showing failure
- For MANUAL VERIFICATION findings: document the specific reason verification wasn't possible
- Evidence must be sufficient for independent audit of the verification without re-running test or re-reading source
- Do NOT use paraphrases, summaries, or interpretations—use direct quotations or unmodified output

## Error Handling

**Source Unreachable:**
- Tag as `[MANUAL VERIFICATION REQUIRED - source unreachable]`
- Document which source failed
- List what claims could not be verified

**Partial Verification:**
- Some claims verifiable, others not
- Document which claims verified against which sources
- Tag as `[PARTIALLY VERIFIED - see finding for details]`

**Conflicting Sources:**
- Document all sources and their claims
- Tag as `[REQUIRES CLARIFICATION - sources conflict]`
- Preserve full context for manual review

## Integration with Analysis Skill

This skill is invoked by fact-capture.md inline verification workflow:
1. Fact is appended to memory file with `[NOT YET VERIFIED]` tag
2. `/verify-fact` skill is invoked as background agent
3. Verification working document is created/updated with detailed verification entry
4. Fact file is updated with verification tag from working document
5. Index is updated with new verified fact
6. Verification result reported to calling context

---

## Tool Requirements

- **Read**: Access fact files and memory structure
- **Edit**: Update fact files with verification tags
- **Write**: Create archive files for disproven findings
- **WebFetch**: Fetch official documentation sources
- **WebSearch**: Find authoritative sources when WebFetch fails
- **Agent**: Delegate to sub-agents for complex verification tasks

## Compliance Verification

Before completing verification:

- [ ] Specified finding was located in correct memory file?
- [ ] Source URL was extracted from finding metadata?
- [ ] Official source was fetched using WebFetch or WebSearch, OR test/procedure was executed?
- [ ] All claims in finding were checked against source content or test output?
- [ ] Source publication date was reviewed and documented for currency?
- [ ] **ALL evidence was gathered before any file updates?**
- [ ] Verification status was determined (VERIFIED/DISPROVEN/MANUAL)?
- [ ] **Verification working document was created/updated with complete evidence?**
- [ ] Verification entry includes all required sections (date, source, method, status, claims, evidence)?
- [ ] Evidence section contains verbatim excerpts from official source for EACH claim?
- [ ] Direct quotations were used, NOT paraphrases or summaries?
- [ ] Source section/URL fragment documented for each excerpt?
- [ ] **Fact file was updated with appropriate verification tag (LAST STEP)?**
- [ ] Disproven findings were archived to `-disproven.md` with full contradicting evidence?
- [ ] Index was updated if fact files changed?
- [ ] Verification report provided with detailed results?

**If ANY answer is "No":**
- Complete the missing verification step
- **Critical:** Do NOT tag facts in the primary fact file until the working document entry is complete
- These are mandatory standards
