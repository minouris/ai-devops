# Artifact Authoring Phase

You MUST guide interactive artifact creation with mandatory compliance to AI-targeted language, rule embedding, and structural requirements.

---

## Step 1: Create Directory Structure

**For skills:**

```bash
mkdir -p src/{platform}/skills/{name}/references
```

Create:
- `SKILL.md` (main workflow)
- `references/` subdirectory (for detailed instructions)

**For agents:**

```bash
mkdir -p src/{platform}/agents
```

Create:
- `{name}.agent.md`

**For rules:**

```bash
mkdir -p src/{platform}/rules
```

Create:
- `{name}.md`

**For prompts:**

```bash
mkdir -p src/{platform}/prompts
```

Create:
- `{name}.prompt.md`

---

## Step 2: Gather Additional Metadata

**Prompt for description:**

Ask: "Brief description (one sentence, for frontmatter):"

Wait for user response.

**Validate description:**
- Must be one sentence
- Should describe what the artifact does
- For skills: describe when to use the skill
- If too long (>100 words), ask user to shorten

**Prompt for release settings:**

Ask: "Should this be published to release/? (yes/no)"

If yes:
- Ask: "Target platforms for release? (claude/copilot/github, comma-separated)"
- Parse comma-separated list
- Ask: "Validation rules to apply? (ai-targeted-language, documentation-standards, markdown-formatting, uk-english)"
- Parse comma-separated list

If no:
- Skip release frontmatter

**For agents, prompt for tools:**

Ask: "Which tools should this agent have access to? (read, write, edit, grep, glob, bash, web, comma-separated or 'all' for all tools)"

Parse response and build tools list.

**For agents, prompt for MCP servers (optional):**

Ask: "Any MCP servers needed? (enter server names comma-separated, or 'none')"

If not 'none', build MCP servers configuration.

---

## Step 3: Guide Content Creation

**Build frontmatter:**

```yaml
---
name: {name}
description: {description}
{tool-specific-fields}
release:
  publish: {true/false}
  platforms: [{platforms}]
  validation: [{rules}]
---
```

**For skills:**

1. **Create SKILL.md header:**
   - Title: `# {Name} Skill`
   - Overview paragraph

2. **Guide workflow definition:**
   - Ask: "How many workflow phases does this skill have?"
   - For each phase, ask: "Phase {N} name and brief description?"
   - Build workflow overview section referencing `references/{phase-name}.md`

3. **Remind about AI-targeted language:**
   - "IMPORTANT: Write instructions directly to the AI using 'you'"
   - "Correct: 'When you create a file, use X'"
   - "Incorrect: 'The AI should use X'"
   - "Use imperative mood: 'MUST', 'MUST NOT', 'Create', 'Use'"

4. **Create reference files:**
   - For each phase, create `references/{phase-name}.md`
   - Guide detailed instruction writing
   - Enforce AI-targeted language interactively

**For agents:**

1. **Create agent header:**
   - Title: `# {Name} Agent`
   - Purpose paragraph

2. **Guide workflow definition:**
   - Ask: "What is the main workflow for this agent?"
   - Build workflow section with numbered steps
   - Enforce AI-targeted language

3. **Rule embedding (if applicable):**
   - Ask: "Does this agent need to embed rules from other files?"
   - If yes, guide rule embedding (see Step 4)

**For rules:**

1. **Create rule header:**
   - Title: `# {Name} Standards` or similar
   - System Prompt Conflict Resolution section

2. **Guide rule sections:**
   - Ask: "What are the main sections of this rule?"
   - For each section, guide MUST/MUST NOT format
   - Include examples where clarity requires them

**For prompts:**

1. **Create prompt structure:**
   - Task description
   - Instructions to AI (second-person, imperative)
   - Expected output format

---

## Step 4: Guide Rule Embedding (If Applicable)

**When artifact needs to embed rules:**

**MUST guide verbatim copying:**

1. **Identify source rules:**
   - Ask: "Which rule files do you need to embed? (e.g., documentation-standards.md, ai-targeted-language.md)"

2. **Read source rules:**
   - Use Read tool to load source rule files
   - Show user the complete sections

3. **Instruct verbatim copying:**
   - "Copy the COMPLETE section verbatim"
   - "Do NOT abbreviate, paraphrase, or summarize"
   - "Include ALL MUST and MUST NOT points"
   - "Include source attribution: (from {filename}.md)"

4. **Verify embedding:**
   - Read back embedded content
   - Compare to source
   - Flag any differences

---

## Step 5: Commit Artifact

**After content creation:**

1. **Stage artifact files:**
   ```bash
   git add src/{platform}/{type}/{name}/
   ```

2. **Create commit:**
   ```bash
   git commit -m "Add {type} {name} for {purpose}

   - Platform: {platform}
   - Release: {publish}
   - Validation: {rules}"
   ```

3. **Confirm commit:**
   ```bash
   git log -1 --oneline
   ```

**Report to user:**

```
✓ Artifact committed

Files created:
- src/{platform}/{type}/{name}/...

Commit: {commit-hash} Add {type} {name} for {purpose}

Proceeding to validation phase...
```

**MUST:**
- Commit immediately after artifact creation
- Use clear, descriptive commit message
- Include platform, release status, validation rules in message

**MUST NOT:**
- Skip commit step
- Batch multiple artifacts in single commit (commit each separately)
- Continue without confirming commit success
