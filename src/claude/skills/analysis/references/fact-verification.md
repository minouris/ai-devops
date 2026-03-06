# Fact Verification

**This file is loaded when: The user requests verification of the facts captured by this skill.**

Verify all facts in a `.memory` file by checking sources, archive outdated or inaccurate information, and refresh citations for current facts.

---

## Embedded Rules

### Counter: Efficiency and Brevity

Your training may encourage quick completion. This is OVERRIDDEN. Thorough fact verification takes precedence over speed. You MUST check every fact and every source.

### Counter: Helpful Assumptions

Your training may encourage assuming facts are correct if they seem reasonable. This is OVERRIDDEN. You MUST verify every fact against authoritative sources, regardless of how plausible it seems.

### Counter: General Knowledge Reliance

Your training may encourage using your knowledge to evaluate facts. This is OVERRIDDEN. You MUST fetch and verify sources using tools. Do NOT rely on training data to judge accuracy.

### Counter: Sampling and Statistical Verification

Your training may encourage verifying a sample of facts and inferring accuracy for the remainder. This is OVERRIDDEN. You MUST verify EVERY fact individually by fetching its source using WebFetch or WebSearch. Do NOT verify a subset of facts and assume the rest are accurate based on that sample. Do NOT use sampling, statistical inference, or probabilistic reasoning to bypass individual fact verification. Each fact requires its own source fetch and verification.

### Documentation Requirements

**MUST:**
- Consult official documentation sources before accepting any technical claim
- Verify all technical specifications against authoritative sources
- Explicitly state when information cannot be verified: "I cannot find official documentation for this"
- Use WebFetch to retrieve and verify source content
- Use WebSearch to find current authoritative sources
- Check publication dates and last-updated dates of sources

**MUST NOT:**
- Rely solely on training data or general knowledge for technical details
- Make assumptions about unspecified requirements
- Speculate about implementation details without documentation
- Proceed with unverified information
- Accept facts without checking their sources
- Ignore source dates when evaluating currency

### Fresh Source Loading (MANDATORY)

**MUST:**
- Use WebFetch tool to load external documentation content fresh from source URLs
- Use WebSearch tool to find current authoritative sources
- Fetch documentation directly from official sources for every verification
- Retrieve source content during the verification workflow, not before
- Treat every fact verification as requiring a fresh fetch

**MUST NOT:**
- Use cached documentation content from earlier in the conversation
- Rely on documentation content read before the verification workflow started
- Assume documentation loaded previously is still current
- Trust your training data or general knowledge about documentation content
- Skip fetching a source because you "remember" reading it earlier

**Rationale:**
External documentation changes frequently. Content loaded earlier in a conversation may be outdated by the time verification begins. Documentation cached in your training data is outdated by definition. Every fact verification requires a fresh fetch from the authoritative source to ensure accuracy.

**Example of correct behavior:**
- User says: "I fetched the docs earlier, they say X"
- You MUST: Use WebFetch to retrieve the documentation again during verification
- You MUST NOT: Accept the user's description of what the docs say without verifying

### Source Content Verification (MANDATORY)

**MUST:**
- Verify that facts accurately record the information provided by sources
- Compare fact statements against actual source content
- Check that claims match what the source states
- Confirm technical details, specifications, and behaviours match source documentation
- Validate that context and meaning are preserved from source to fact

**MUST NOT:**
- Treat existence of a source link as verification
- Accept facts as verified simply because a URL is provided
- Assume source contains claimed information without checking
- Mark facts as verified without reading and comparing source content
- Skip content verification when a citation exists

**Rationale:**
A citation proves only that a source exists, not that the source says what the fact claims. Verification requires comparing the fact statement against the actual information in the source. The fact must accurately represent what the source documents.

**Example of incorrect behaviour:**
- Fact: "Claude Code supports 25 hook events"
- Citation: [Hooks Documentation](https://code.claude.com/docs/en/hooks)
- Incorrect: Mark as VERIFIED because citation exists
- Correct: Fetch documentation, count actual hook events (18), mark as REJECTED

---

## Task Overview

You will process a `.memory` file containing technical facts and research findings. Your task is to:

1. **Read the memory file** specified in the input
2. **Extract all factual claims** from the file
3. **Identify recently verified facts** tagged `[VERIFIED on ...]` within the last 30 days — skip these unless re-verification is explicitly requested
4. **Verify each remaining fact** by checking sources using WebFetch or WebSearch
5. **Evaluate source currency** by checking dates
6. **Separate facts** into accepted (current/verified) and rejected (outdated/inaccurate)
7. **Create a verification working document** with detailed verification evidence for each fact
8. **Tag each accepted fact** with `[VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-n))` in its header block, where:
   - `{source-url}` is the primary authoritative URL (or short descriptor such as `research synthesis`) used to verify that specific fact
   - `{verification-working-file}` is the path to the verification working document (e.g., `.memory/topic-verification-working.md`)
   - `#finding-n` is the anchor link to the specific finding's verification section in the working document
9. **Create an archive file** for rejected facts with rejection reasons
10. **Update the original file** with only verified facts, refreshed citations, and verification tags
11. **Document the distillation process** in the progress log

---

## Input Format

**Expected input:**
```
memoryFilePath=.memory/{filename}.md
```

**Variables:**
- `${input:memoryFilePath}` - Path to the memory file to verify (e.g., `.memory/analysis_facts_pending.md`)

---

## Workflow Steps

### Step 1: Read and Parse Memory File

**Execute:**
```
1. Read file at ${input:memoryFilePath} using Read tool
2. Extract all factual claims (technical specifications, API details, behaviours, configurations)
3. Identify existing citations for each fact
4. For each fact, check whether it carries a [VERIFIED on {date} by ...] tag
5. Calculate days elapsed since each verification tag date
6. Mark facts verified within the last 30 days as SKIP (retain as accepted without re-verification)
7. Create list of remaining facts with their current citations for verification
```

**MUST:**
- Extract EVERY factual claim, no matter how minor
- Note facts that lack citations
- Preserve context around each fact
- Record skipped facts (recently verified) separately in the log
- When evaluating a `[VERIFIED on {date} by {source}]` tag, parse the source field to determine which URL or process performed the verification

**MUST NOT:**
- Skip facts that seem obviously correct (unless they carry a recent verification tag)
- Ignore facts without citations
- Make assumptions about what constitutes a "fact"
- Re-verify facts tagged within the last 30 days unless the user explicitly requests it

---

### Step 2: Verify Each Fact

**Before processing each fact:**

If a fact is tagged `[VERIFIED on {date} by ...]` and the tag date is within the last 30 days:
- Retain as ACCEPTED without fetching sources
- Preserve the existing tag unchanged
- Record as "retained — verified within 30 days" in the log

Re-verify regardless of tag age only when the user explicitly requests it (e.g., "force re-verify" or "verify all facts").

**For each fact not covered by a recent verification tag:**

**Execute:**
```
1. Identify the authoritative source for this fact
2. Use WebFetch to retrieve source content (if URL available)
3. Use WebSearch to find current authoritative source (if no URL or URL broken)
4. Check source publication/update date
5. Verify fact content matches source
6. Determine if fact is ACCEPTED or REJECTED
```

**Verification Criteria:**

**ACCEPTED if:**
- Fact matches content in authoritative source
- Source is current (published/updated within reasonable timeframe for topic)
- Source is authoritative (official docs, official repos, official release notes)
- Citation is complete and accessible

**REJECTED if:**
- Fact contradicts current source
- Source is outdated (check for newer versions/docs)
- Source is not authoritative
- Fact cannot be verified (source unavailable, citation missing, no authoritative source exists)
- Fact has been superseded by newer information

**MUST:**
- Check EVERY fact, even if citation seems valid
- Fetch source content using WebFetch to verify fact accuracy
- Check for newer versions of documentation using WebSearch
- Note specific reason for rejection
- Record exact source URL and access date for accepted facts

**MUST NOT:**
- Accept facts without fetching sources
- Assume citations are correct without verification
- Skip verification for "obvious" facts
- Ignore date information
- Verify a sample and infer the rest are accurate
- Use statistical verification or sampling methods

---

### Step 3: Categorise Facts

**Create two lists:**

**Accepted Facts (for verification working document):**
```markdown
## Accepted Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}

**Verification:**
- Source: [{Source Name}]({URL})
- Accessed: YYYY-MM-DD
- Published/Updated: YYYY-MM-DD
- Status: Current and verified

**Citation:** According to the [{Source Name}]({URL}), {fact statement}.
```

When multiple sources were consulted, use the primary or most authoritative URL in the tag. Use a short descriptor such as `research synthesis` when the fact derives from synthesising multiple sources rather than a single verifiable URL.

The verification working document will serve as a comprehensive reference for how each fact was verified, with the verification tag in the fact file linking to the relevant section.

**Recently Verified Facts (skipped):**
```markdown
## Retained Fact {N}: {Brief Description}

**Fact:** {Exact factual statement}
**Verified:** [VERIFIED on YYYY-MM-DD by {original verifier}]  ← retained, within 30-day window

**Status:** Skipped — verified within the last 30 days. Re-verify after {expiry date}.
```

**Rejected Facts:**
```markdown
## Rejected Fact {N}: {Brief Description}

**Original Fact:** {Exact factual statement from file}

**Original Citation:** {Citation that was in file, if any}

**Rejection Reason:** {Specific reason - outdated/inaccurate/unverifiable/superseded}

**Evidence:**
- Checked: {What sources were checked}
- Found: {What current information shows}
- Date: {When checked}

**Current Information:** {If fact is outdated, what is the current correct information}

**Archived:** YYYY-MM-DD
```

---

### Step 4: Create Verification Working Document

**Execute:**
```
1. Determine verification working filename from input path:
   ${input:memoryFilePath} → {basename}-verification-working.md
   Example: .memory/claude-config-compaction-facts.md → .memory/claude-config-compaction-verification-working.md

2. Create verification working document using Write tool with the structure below
```

**Verification Working Document Structure:**
```markdown
# {Topic} Verification Working Document

Comprehensive verification of all findings in {source-file} against official documentation sources.

**Primary sources:**
- [Source Name](URL)
- [Source Name](URL)

**Verification date:** YYYY-MM-DD

---

## FINDING-YYYY-MM-DD-N: {Finding Title}

**Claim:** {Brief summary of what the finding claims}

**Verification:**

From [Source Name](URL):

> "{Exact quote from source that verifies the claim}"

{Additional quotes or evidence as needed}

**Status:** ✅ VERIFIED - {Summary of verification result}
{or}
**Status:** ⚠️ PARTIALLY VERIFIED - {What was verified, what wasn't}
{or}
**Status:** ❌ REJECTED - {Why it was rejected}

---

{Repeat for each finding}

---

## Verification Summary

**Findings verified:** {N} fully verified, {N} partially verified

{Summary of verification results}
```

**MUST:**
- Include detailed evidence for each finding's verification
- Provide exact quotes from sources where possible
- Document verification status clearly
- Use markdown heading anchors that match the finding identifiers (e.g., `## FINDING-2026-03-05-88` creates anchor `#finding-2026-03-05-88`)

**MUST NOT:**
- Skip creating this document
- Use vague verification descriptions
- Omit source quotes or evidence

---

### Step 5: Create Archive File

**Execute:**
```
1. Determine archive filename from input path:
   ${input:memoryFilePath} → {basename}_archive_{yyyy-mm-dd}.md
   Example: .memory/analysis_facts_pending.md → .memory/analysis_facts_pending_archive_2026-02-19.md

2. Create archive file using Write tool with the structure below
```

**Archive File Structure:**
```markdown
# {Basename} Archive - {Date}

**Archive Date:** YYYY-MM-DD
**Source File:** {original memory file path}
**Archived By:** verify-memory-facts process

**Purpose:** This file contains facts from {source file} that were found to be
outdated, inaccurate, or unverifiable during fact verification on {date}.

---

## Rejected Facts

{Insert all rejected facts from Step 3, with full rejection reasons}

---

## Archive Notes

- Total facts checked: {N}
- Facts rejected: {N}
- Facts accepted: {N}
- Verification method: WebFetch, WebSearch
- Authoritative sources consulted: {list}

---
```

**MUST:**
- Include complete rejection reasons
- Specify what current information shows (if outdated)
- Record verification methodology
- Preserve original fact statements exactly

**MUST NOT:**
- Delete rejected facts without archiving
- Omit rejection reasons
- Archive accepted facts

---

### Step 6: Update Original Memory File

**Execute:**
```
1. Rewrite memory file using Edit or Write tool with ONLY accepted facts
2. Update citations with refreshed URLs and dates
3. Add verification note to file header referencing the verification working document
4. Maintain original file structure where possible
```

**Updated File Header:**
```markdown
# {File Title}

**Last Verified:** YYYY-MM-DD
**Verification Method:** Source checking via WebFetch/WebSearch
**Verification Details:** See {verification-working-filename}
**Archived Facts:** See {archive filename}

---
```

**Updated Fact Format:**
```markdown
## {Topic}

{Verified fact content}

**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-id))
**Source:** [{Source Name}]({URL}) (accessed YYYY-MM-DD, published/updated YYYY-MM-DD)

---
```

For fact files using the `FINDING-YYYY-MM-DD-N` block structure, add the `**Verified:**` line to the fact's header block, immediately after the `**Source:**` line:

```markdown
## FINDING-YYYY-MM-DD-N: {Finding Title}

**Source:** {source reference}
**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-yyyy-mm-dd-n))
```

**Tag format explanation:**
- `{source-url}` — Primary authoritative URL or `research synthesis` for multi-source findings
- `{verification-working-file}` — Path to verification working document (e.g., `.memory/topic-verification-working.md`)
- `#finding-yyyy-mm-dd-n` — Anchor link to the finding's verification section (lowercase, with hyphens)

**MUST:**
- Include ALL accepted facts
- Add `**Verified:** [VERIFIED on YYYY-MM-DD by {source-url}] ([details]({verification-working-file}#finding-id))` to every newly verified fact
- Include link to verification working document in each verification tag
- Preserve existing `**Verified:**` tags on recently verified facts (within 30 days) unchanged
- Use refreshed citations with dates
- Maintain logical organisation
- Note existence of archive file and verification working document
- Preserve any non-factual content (structure, notes, TODOs)

**MUST NOT:**
- Include rejected facts in updated file
- Use old citations without verification
- Remove structural elements (headers, sections)
- Change fact statements beyond verification updates
- Remove or overwrite existing `**Verified:**` tags on retained (skipped) facts
- Omit the link to the verification working document in new verification tags

---

### Step 7: Log Progress

**Execute:**
```
Create or update .memory/verification_log.md with an entry for this run
```

```markdown
## Verification: {filename} - YYYY-MM-DD HH:MM:SS

**Source File:** {memory file path}
**Verification Working Document:** {verification working file path}
**Archive File:** {archive file path}
**Started:** YYYY-MM-DD HH:MM:SS
**Completed:** YYYY-MM-DD HH:MM:SS

**Summary:**
- Total facts processed: {N}
- Facts newly verified (tagged): {N}
- Facts retained (within 30-day window, skipped): {N}
- Facts rejected (archived): {N}
- Sources checked: {N}

**Newly Verified Facts:**
- {Brief list of accepted fact topics}

**Retained Facts (skipped — recent tag):**
- {Brief list with tag dates and expiry dates}

**Rejected Facts:**
- {Brief list of rejected fact topics with reasons}

**Tools Used:**
- WebFetch: {N} calls
- WebSearch: {N} queries

**Issues Encountered:**
- {Any problems during verification}

---
```

---

## Output Format

**Provide to user:**

```markdown
# Memory File Verification Complete

**Original File:** {path}
**Newly Verified:** {N} facts (tagged with source and verification details link)
**Retained:** {N} facts (within 30-day window — skipped, tags preserved)
**Archived:** {N} facts rejected
**Verification Working Document:** {verification working file path}
**Archive Location:** {archive file path}

## Summary

**Newly Verified Facts:**
1. {Fact topic} - verified from {source} ([details]({verification-working-file}#finding-id))
2. {Fact topic} - verified from {source} ([details]({verification-working-file}#finding-id))
...

**Retained Facts (skipped — verified within 30 days):**
1. {Fact topic} - tag expires {date}
...

**Rejected Facts (Archived):**
1. {Fact topic} - {rejection reason}
2. {Fact topic} - {rejection reason}
...

## Files Modified

- ✅ Updated: {original memory file}
- ✅ Created: {verification working document}
- ✅ Created: {archive file}
- ✅ Logged: .memory/verification_log.md

## Next Steps

Review the updated memory file to ensure all critical information is retained.
Check the verification working document for detailed verification evidence.
Check the archive file to see what was removed and why.
```

---

## Verification Standards

**Currency:**
- For API docs, within 1 year is current
- For stable specs, 2-3 years acceptable

**Authority (highest to lowest):**
1. Official project documentation
2. Official API references
3. Official GitHub repositories and release notes
4. Official blog posts and announcements
5. [Conditional] Community forums, Stack Overflow, unofficial blogs

**Community Source Requirements:**

Community sources (forums, Stack Overflow, unofficial blogs) MAY be used if ALL conditions are met:
- Supporting evidence suggests the information is correct
- Information is explicitly marked as from community sources
- Verification status clearly indicates community source origin
- Flagged for user review acceptance before final acceptance

**Verification tag format for community sources:**
```markdown
**Verified:** [COMMUNITY SOURCE - REQUIRES USER REVIEW on YYYY-MM-DD from {source-url}] ([details]({verification-working-file}#finding-id))
```

**MUST:**
- Mark community source facts with `[COMMUNITY SOURCE - REQUIRES USER REVIEW ...]` tag
- Document supporting evidence in verification working document
- Present community-sourced findings to user for explicit acceptance
- Note in verification working document why no official source was available

**MUST NOT:**
- Use community sources when official sources exist
- Accept community sources without supporting evidence
- Mark community-sourced facts as fully verified without user review
- Proceed with community sources as authoritative without explicit user acceptance

**Completeness:**
- Citation must include URL, source name, and date accessed

**Accuracy:**
- Fact statement must match source content exactly

---

## Edge Cases

**If fact has a recent verification tag (within 30 days):**
- Retain as accepted without fetching sources
- Preserve tag unchanged
- Log as "retained — verified within 30-day window"
- Re-verify only if the user explicitly requests it

**If fact has an expired verification tag (older than 30 days):**
- Treat as unverified
- Verify fully and replace the tag with a new `[VERIFIED on {date} by {source-url}] ([details]({verification-working-file}#finding-id))`
- If verification fails, move to archive

**If source is unavailable (404, connection error):**
- Use WebSearch to find current location
- If not found after search, mark as REJECTED with reason: "Source unavailable, could not verify"

**If fact has no citation:**
- Use WebSearch to find authoritative source
- If found and verified, mark ACCEPTED with new citation
- If not found, mark REJECTED with reason: "Unverifiable, no authoritative source found"

**If source is outdated but fact is still correct:**
- Search for current documentation using WebSearch
- If current docs confirm fact, mark ACCEPTED with updated citation
- If current docs contradict or omit fact, mark REJECTED

**If multiple sources conflict:**
- Use highest authority source
- Mark as REJECTED if official sources conflict, with reason: "Conflicting information in official sources"

---

## Prohibited Actions

**MUST NOT:**
- Accept facts without source verification
- Delete facts without archiving them
- Change fact statements without evidence
- Use outdated citations
- Rely on general knowledge for verification
- Skip verification for "obvious" facts
- Accept community sources as authoritative
- Proceed when sources are ambiguous
- Batch verify without checking each source individually
- Verify a sample of facts and infer accuracy for the remainder
- Use sampling, statistical inference, or probabilistic reasoning to bypass verification
- Tag facts as verified without actually fetching and checking their sources

---

## Example Execution

**Input:**
```
memoryFilePath=.memory/analysis_facts_pending.md
```

**Process:**
1. Read `.memory/analysis_facts_pending.md`
2. Extract facts:
   - "GitHub Copilot custom agents use `.agent.md` files"
   - "Copilot supports `tools:` property in agent frontmatter"
   - "agentskills.io defines a portable skills standard"
3. Verify each:
   - Fact 1: ✅ ACCEPTED - Verified in official GitHub Copilot docs (2026)
   - Fact 2: ❌ REJECTED - Property is `tools` but syntax changed in recent release
   - Fact 3: ❌ REJECTED - Site unavailable, cannot verify standard is current
4. Create `.memory/analysis_facts_pending-verification-working.md` with detailed verification evidence
5. Create `.memory/analysis_facts_pending_archive_2026-02-19.md`
6. Update `.memory/analysis_facts_pending.md` with only Fact 1 (tagged with link to verification working document)
7. Log to `.memory/verification_log.md`

**Output:**
```
Memory File Verification Complete

Original File: .memory/analysis_facts_pending.md
Verified: 1 fact accepted (with verification details link)
Archived: 2 facts rejected
Verification Working Document: .memory/analysis_facts_pending-verification-working.md
Archive Location: .memory/analysis_facts_pending_archive_2026-02-19.md
```

---

## Memory Directory Convention

**During prompt execution, use `.memory/` for:**
- Verification working documents → `.memory/{basename}-verification-working.md`
- Progress logging → `.memory/verification_log.md`
- Archived facts → `.memory/{basename}_archive_{date}.md`

**MUST create memory files when:**
- Documenting verification evidence (`.memory/{basename}-verification-working.md`)
- Archiving rejected facts (`.memory/{basename}_archive_{date}.md`)
- Logging the verification process (`.memory/verification_log.md`)

**MUST NOT:**
- Put archived facts in user-facing documentation
- Delete rejected facts without archiving
- Skip creating the verification working document

---

## Compliance Verification

**Before completing verification:**

- [ ] Every fact in original file was evaluated?
- [ ] Facts with `[VERIFIED on ...]` tags within the last 30 days skipped (unless re-verification requested)?
- [ ] Every remaining fact was verified against an authoritative source?
- [ ] Source content was fetched using WebFetch or WebSearch?
- [ ] Source dates were checked?
- [ ] Verification working document created with detailed evidence for each finding?
- [ ] Newly accepted facts tagged with `[VERIFIED on {date} by {source-url}] ([details]({verification-working-file}#finding-id))`?
- [ ] Each verification tag includes link to corresponding section in verification working document?
- [ ] Retained facts have their original tags preserved unchanged?
- [ ] Rejected facts are archived with specific rejection reasons?
- [ ] Archive file created with complete information?
- [ ] Original file updated with only verified facts and correct tags with verification links?
- [ ] Verification logged to `.memory/verification_log.md`?
- [ ] User provided with summary of changes including verification working document location?

**If ANY answer is "No":**
- Complete the missing verification
- Do not declare task complete
- These are mandatory standards

---

## Claude Code Tool Usage

This prompt workflow uses the following Claude Code tools:

- **Read**: Read the memory file and extract facts
- **Write**: Create archive files and rewrite verified memory files
- **Edit**: Update existing files with verification tags
- **WebFetch**: Retrieve and verify documentation sources
- **WebSearch**: Find current authoritative sources
