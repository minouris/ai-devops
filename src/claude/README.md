# Claude Code Artifacts

Distributable Claude Code artifacts including skills, prompts, rules, and agents.

## Contents

### Skills (`skills/`)

Custom skills that can be invoked with `/skill-name` in Claude Code:

- **[analysis.md](skills/analysis.md)** - Research and analysis workflow with systematic fact capture, verification, and curated output generation
  - Supports procedural research (finding and testing procedures)
  - Supports analytical research (examining artifacts and capturing findings)
  - Manages `.memory/` fact files with verification and archival workflows
  - Invocation: `/analysis`

### Prompts (`prompts/`)

Reusable prompt workflows for specific tasks:

- **[verify-memory-facts.md](prompts/verify-memory-facts.md)** - Verify and distill facts in `.memory` files by checking sources against authoritative documentation
  - Checks facts against official documentation using WebFetch and WebSearch
  - Archives outdated or inaccurate information
  - Tags verified facts with `[VERIFIED on {date} by {source-url}]`
  - Skips facts verified within the last 30 days automatically
  - Usage: Reference in analysis skill or invoke manually with `memoryFilePath=.memory/{filename}.md`

### Rules (`rules/`)

Project-level instructions that apply to all Claude Code sessions:

- **[documentation-first.md](rules/documentation-first.md)** - Mandatory documentation consultation requirements
- **[documentation-standards.md](rules/documentation-standards.md)** - UK English, tone, and formatting standards
- **[git-commits.md](rules/git-commits.md)** - Git commit message and workflow standards
- Additional rules for markdown formatting, reference items, design documents, etc.

### Agents (`agents/`)

Legacy agent definitions (for reference; use skills/ for new workflows).

### Commands (`commands/`)

Custom commands for common operations.

## Installation

### For a New Project

Copy the relevant artifacts to your project's `.claude/` directory:

```bash
# Copy skills
cp src/claude/skills/analysis.md .claude/skills/

# Copy prompts
cp src/claude/prompts/verify-memory-facts.md .claude/prompts/

# Copy rules (select the ones you need)
cp src/claude/rules/documentation-first.md .claude/rules/
cp src/claude/rules/documentation-standards.md .claude/rules/
cp src/claude/rules/git-commits.md .claude/rules/
```

### For Global Use

Copy to your global Claude Code configuration:

```bash
# Copy skills
cp src/claude/skills/analysis.md ~/.claude/skills/

# Copy prompts
cp src/claude/prompts/verify-memory-facts.md ~/.claude/prompts/
```

## Usage

### Analysis Skill

The analysis skill provides systematic research workflows with fact capture and verification:

1. **Invoke the skill:**
   ```
   /analysis
   ```

2. **Specify research type:**
   - Procedural research: Finding and testing procedures
   - Analytical research: Examining code/artifacts and capturing findings

3. **Research phase:**
   - Claude captures all findings in `.memory/[PROJECT]-[domain]-facts.md`
   - Updates analysis index in `.memory/[PROJECT]-analysis-index.md`
   - Archives disproven findings to `-disproven.md` files
   - Continues research without requiring approval for each finding

4. **Output phase (when you explicitly request it):**
   - For procedural: "Create procedure guide for [topic]"
   - For analytical: "Create analysis document on [topic]"
   - Claude verifies facts, creates draft in `.memory/[NAME]-PENDING.md`
   - After your approval, creates final output in specified location

### Fact Verification

The verify-memory-facts prompt checks facts against authoritative sources:

**Automatic verification (via analysis skill):**
- When creating analytical reports, fact verification runs automatically
- Facts verified within 30 days are skipped
- New facts are verified and tagged

**Manual verification:**
- Reference the prompt with: `memoryFilePath=.memory/{filename}.md`
- Force re-verification: "force re-verify all facts in {filename}"

## File Structure

When using the analysis skill, expect this structure:

```
.memory/
├── {PROJECT}-analysis-index.md          # Index of all fact files
├── {PROJECT}-{domain}-facts.md          # Domain-specific fact file
├── {PROJECT}-{domain}-facts-disproven.md # Archived disproven findings
├── {NAME}-PENDING.md                    # Draft outputs awaiting approval
└── verification_log.md                  # Fact verification history
```

Final outputs (guides, analyses) are placed in the root or location you specify.

## Principles

### Documentation-First

All artifacts follow documentation-first principles:
- Verify against official documentation before capturing facts
- Include citations for all technical claims
- Explicitly state when information cannot be verified
- Never rely solely on general knowledge

### Processing Artifacts vs. Final Outputs

- `.memory/` contains processing artifacts (fact files, drafts, disproven archives)
- Root contains only final approved outputs
- Never commit drafts or unapproved outputs

### Transparency and Traceability

- All research is captured in fact files
- Disproven findings are archived, never deleted
- Timestamps on all entries
- Citations trace from output → fact file → original source

## Customisation

### Adapting the Analysis Skill

You can customise the analysis skill for your domain:

1. **Modify fact file format** - Adjust the `FINDING-YYYY-MM-DD-N` structure
2. **Change verification frequency** - Adjust the 30-day verification window
3. **Add domain-specific workflows** - Extend with new research patterns
4. **Customise output formats** - Modify the final analysis/guide templates

### Creating New Skills

Use the analysis skill as a template:

1. Create `{skill-name}.md` with frontmatter:
   ```yaml
   ---
   name: skill-name
   description: Brief description
   ---
   ```

2. Define the workflow and tool usage
3. Place in `.claude/skills/` or `~/.claude/skills/`
4. Invoke with `/skill-name`

## Contributing

When contributing new artifacts:

1. Place source in `src/claude/{type}/`
2. Use Claude Code tool names (Read, Write, Edit, Bash, WebFetch, WebSearch, Grep, Glob)
3. Follow documentation-first principles
4. Include clear usage examples
5. Document any dependencies or related artifacts

## Licence

These artifacts are provided as-is for use in Claude Code projects.
