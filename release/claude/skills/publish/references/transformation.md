# Transformation and Publication Phase

You MUST apply platform-specific transformations and copy artifacts to release/ directory.

---

## Step 1: Apply Platform-Specific Transformations

**For each artifact and target platform:**

### Claude Code → Claude Code (No Transformation)

**MUST:**
- Copy artifact as-is to `release/claude/`
- Preserve directory structure
- Remove `release:` field from frontmatter in copied version

**Example:**
- Source: `src/claude/skills/example/SKILL.md`
- Target: `release/claude/skills/example/SKILL.md`

### Claude Code Skill → GitHub Copilot Agent

**MUST transform:**

1. **File extension:**
   - Source: `SKILL.md`
   - Target: `{skill-name}.agent.md`

2. **Frontmatter adjustments:**
   - Remove `release:` field
   - Adjust `tools:` if needed for Copilot compatibility
   - Add Copilot-specific fields if required

3. **Path adjustments:**
   - Update relative references if directory structure differs

**Example:**
- Source: `src/claude/skills/analysis/SKILL.md`
- Target: `release/copilot/agents/analysis.agent.md`

### Base (Shared) Artifacts

**MUST:**
- Copy to all specified platforms
- Apply platform-specific transformations per platform
- Preserve shared artifacts in `src/base/` for reference

---

## Step 2: Remove release Frontmatter Field

**For all copied artifacts:**

**MUST:**
- Remove entire `release:` block from frontmatter
- Preserve all other frontmatter fields
- Do NOT modify source files in `src/`

**Example transformation:**

Source frontmatter:
```yaml
---
name: example
description: Does something
release:
  publish: true
  platforms: [claude]
  validation: [ai-targeted-language]
---
```

Target frontmatter (in release/):
```yaml
---
name: example
description: Does something
---
```

---

## Step 3: Copy to release/ Directory

**For each artifact and platform:**

1. **Determine target path:**
   - `release/{platform}/{type}/{artifact-name}/`
   - Preserve directory structure from `src/{platform}/`

2. **Create target directory if needed:**
   ```bash
   mkdir -p release/claude/skills/example
   ```

3. **Copy transformed artifact:**
   - Use Write tool to create file in release/
   - Apply transformations during copy
   - Preserve file structure (SKILL.md + references/ for skills)

4. **Verify copy:**
   - Read back target file
   - Verify transformations applied correctly

---

## Step 4: Commit Publication

**After all artifacts copied:**

1. **Stage all changes in release/:**
   ```bash
   git add release/
   ```

2. **Create commit with detailed message:**
   ```bash
   git commit -m "Publish AI artifacts to release/

   Published artifacts:
   - example-skill → claude
   - validator-agent → claude, copilot, github

   Validation: All published artifacts passed compliance checks

   Transformations applied:
   - Removed release frontmatter from all copies
   - Transformed SKILL.md → agent.md for Copilot targets"
   ```

**MUST:**
- Include list of published artifacts in commit message
- Note validation status
- List transformations applied
- Follow conventional commit format

**MUST NOT:**
- Commit source files in `src/` (only commit release/)
- Push to remote (PR creation handles this)
