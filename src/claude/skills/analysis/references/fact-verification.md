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

**Example of correct behaviour:**
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

1. Read the memory file and extract all factual claims
2. Identify recently verified facts (tagged within last 30 days) — skip these unless re-verification explicitly requested
3. Verify each remaining fact by checking sources
4. Evaluate source currency by checking dates
5. Separate facts into accepted (current/verified) and rejected (outdated/inaccurate)
6. Create a verification working document with detailed evidence
7. Tag each accepted fact with verification link
8. Create an archive file for rejected facts
9. Update the original file with only verified facts
10. Document the process in the progress log

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

### Step 1: Initialize Verification

[Initialize Verification](fact-verification/initialize-verification.md) - Read memory file, extract all facts, identify recently verified facts (skip these), create verification working document header, create archive file header.

### Step 2: Process Each Fact (Loop)

**For each fact requiring verification, execute in sequence:**

1. **Verify Fact** - [Verify Facts](fact-verification/verify-facts.md) - Fetch sources, check currency, verify content matches, determine ACCEPTED or REJECTED.

2. **Document Verification** - [Create Verification Working Document](fact-verification/create-verification-working-document.md) - Append verification details to working document (accepted or rejected status with evidence).

3. **Tag or Archive** - [Update Memory File](fact-verification/update-memory-file.md) or [Create Archive](fact-verification/create-archive.md) - If ACCEPTED: add verification tag to fact in memory file. If REJECTED: append fact to archive file.

**Repeat for each fact.**

### Step 3: Finalize and Log

[Finalize and Log](fact-verification/finalize-and-log.md) - Close verification working document with summary, close archive file with notes, save updated memory file, log progress to `.memory/verification_log.md`.

---

## Reference Materials

- [Verification Standards](fact-verification/verification-standards.md) - Currency, authority, community sources, completeness, accuracy
- [Edge Cases](fact-verification/edge-cases.md) - Handling special situations (recent tags, unavailable sources, conflicts, etc.)

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

## Prohibited Actions

**MUST NOT:**
- Accept facts without source verification
- Delete facts without archiving them
- Change fact statements without evidence
- Use outdated citations
- Rely on general knowledge for verification
- Skip verification for "obvious" facts
- Accept community sources as authoritative (see [Verification Standards](fact-verification/verification-standards.md) for community source requirements)
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

- **Read**: Read the memory file and extract facts, load step instructions
- **Write**: Create archive files, verification working documents, rewrite verified memory files
- **Edit**: Update existing files with verification tags
- **WebFetch**: Retrieve and verify documentation sources
- **WebSearch**: Find current authoritative sources
