# Claude Config Facts: Subagents Subtopic - Disproven Findings

Archive of findings disproven during verification.

---

## FINDING-2026-03-04-25: Subagents File Structure and Locations [DISPROVEN]

**Source:** [Create custom subagents - Claude Code Docs](https://code.claude.com/docs/en/sub-agents)

**Keywords:** configuration, file, priority, scope, subagent

**Verified:** [VERIFICATION FAILED on 2026-04-04 - Context poisoning detected]

**Disproof Summary:**
The `.agent.md` extension was claimed as a standard convention for Claude Code subagent files. Direct verification against official Claude Code documentation shows no specification of filename format. The extension matches Copilot agent file naming convention, not Claude Code. The finding was contaminated by local codebase inspection which contains both Copilot and Claude Code files.

**Original Claim:**
Subagents use `.agent.md` extension "by convention, not required" in paths like `.claude/agents/<name>.agent.md`

**Actual Documentation:**
- Subagent file format: Markdown with YAML frontmatter
- Storage location: `agents/` directory (plugin root)
- **No filename extension specified in official documentation**
- **No mention of `.agent.md` extension**
- Similar to skill pattern: `skills/<name>/SKILL.md` suggests `agents/<name>.md`

**Root Cause Analysis:**
1. Knowledge base research consulted local codebase structure as documentation source
2. Local codebase contains `.agent.md` files (Copilot convention)
3. Files treated as evidence of Claude Code standard
4. Pattern mirrors prior disproof: Prompts feature (Copilot) misidentified as Claude Code

**Classification:** Context poisoning from mixed Copilot/Claude Code conventions in local codebase

**Corrective Action:**
- Update claude-config-subagents-facts.md to remove this finding
- Correct dependent documentation to use `.md` extension
- Analysis skill refactoring plan corrected: `.agent.md` → `.md`

---
