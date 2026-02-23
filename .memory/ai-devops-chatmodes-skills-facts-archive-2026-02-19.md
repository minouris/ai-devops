# AI DevOps: Chatmodes vs Skills Research – Rejected Facts Archive

**Archive Date:** 2026-02-19
**Source File:** `.memory/ai-devops-chatmodes-skills-facts.md`
**Archived By:** verify-memory-facts process

**Purpose:** This file contains facts from `ai-devops-chatmodes-skills-facts.md` that were found to be
outdated, inaccurate, or unverifiable during fact verification on 2026-02-19.

---

## Rejected Facts

---

### REJECTED-FINDING-2026-02-17-5-A (PARTIAL — Slash commands as separate category)

**Originally Captured:** 2026-02-17 HH:MM
**Disproven:** 2026-02-19
**Original Source:** Reddit, HumanLayer Blog, Medium/Dometrain

**Original Fact (the specific claim rejected):**
> "Slash Commands (custom commands): similar to skills but user-invoked. Design intent: Primarily designed for user invocation (vs skills designed for Claude to use). Note: May be merged with skills in future (request pending with Anthropic)."

~~Slash commands and skills are distinct categories. Slash commands may merge with skills in the future (request pending).~~

**Contradicting Evidence:**
- Checked: [Claude Code skills documentation](https://code.claude.com/docs/en/skills) (accessed 2026-02-19)
- Found: "Custom slash commands have been merged into skills. A file at `.claude/commands/review.md` and a skill at `.claude/skills/review/SKILL.md` both create `/review` and work the same way."
- Also: "Files in `.claude/commands/` still work and support the same frontmatter. Skills are recommended since they support additional features."

**Reason for Disproof:** The claim that slash commands and skills "may merge in future" is incorrect. The merge has already been completed. Custom slash commands in `.claude/commands/` are now treated as skills. The distinction is no longer accurate; they are the same underlying system.

---

### REJECTED-FINDING-2026-02-17-6-A (PARTIAL — Backward compatibility of `.chatmode.md` files)

**Originally Captured:** 2026-02-17 HH:MM
**Disproven:** 2026-02-19
**Original Source:** VS Code Documentation

**Original Fact (the specific claim rejected):**
> "VS Code still recognizes old chatmode files as custom agents (backward compatibility)"
> "Previously used `.chatmode.md` extension in `.github/chatmodes/` folder — VS Code still recognizes old chatmode files as custom agents (backward compatibility)"

~~VS Code automatically detects `.chatmode.md` files in `.github/chatmodes/` and treats them as custom agents without modification.~~

**Contradicting Evidence:**
- Checked: [VS Code Custom Agents documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents) (accessed 2026-02-19, page updated 2026-02-04)
- Found (in FAQ): "If you have existing `.chatmode.md` files, **rename them** to `.agent.md` to convert them to the new custom agent format and **place them in the appropriate location** (`chat.agentFilesLocations`) to continue using them."

**Reason for Disproof:** The rename of old `.chatmode.md` files is required — they are not automatically recognised in place. The old format requires manual migration (rename + move), not automatic backward compatibility.

---

### REJECTED-FINDING-2026-02-17-15-A (PARTIAL — Thinking level triggers via prompt phrases)

**Originally Captured:** 2026-02-17 HH:MM
**Disproven:** 2026-02-19
**Original Source:** Claude Code Official Documentation (cited, but specific claim contradicts current docs)

**Original Fact (the specific claim rejected):**
> "Activation levels: Low: Triggered by 'think'; Medium: Triggered by 'think hard'; Max: Triggered by 'think harder', 'ultrathink'"

~~Phrases such as "think", "think hard", "ultrathink" trigger different levels of extended thinking and allocate thinking tokens.~~

**Contradicting Evidence:**
- Checked: [Claude Code Common Workflows — Extended Thinking](https://code.claude.com/docs/en/common-workflows) (accessed 2026-02-19)
- Found: "Phrases like 'think', 'think hard', 'ultrathink', and 'think more' are **interpreted as regular prompt instructions and don't allocate thinking tokens**."
- Current activation method: Toggle via `Option+T` / `Alt+T`, the `/config` command, or the `alwaysThinkingEnabled` setting.

**Reason for Disproof:** Official documentation explicitly states these phrases do not allocate thinking tokens. The claim is directly contradicted by the current Claude Code documentation.

---

### REJECTED-FINDING-2026-02-17-15-B (PARTIAL — "Fast Mode" for Opus 4.6)

**Originally Captured:** 2026-02-17 HH:MM
**Disproven:** 2026-02-19
**Original Source:** Claude Code Official Documentation (cited as "research preview")

**Original Fact (the specific claim rejected):**
> "Fast Mode: Lower-latency responses with higher cost for Opus 4.6. Fast mode on Opus 4.6 (<200K context): $30/MTok input, $150/MTok output..."

~~"Fast Mode" is a named operational mode in Claude Code for Opus 4.6, providing lower latency at higher cost.~~

**Contradicting Evidence:**
- Checked: [Claude Code settings docs](https://code.claude.com/docs/en/settings) and [Common Workflows](https://code.claude.com/docs/en/common-workflows) (accessed 2026-02-19)
- Found: No "Fast Mode" mentioned in current documentation. The performance/cost tradeoff for Opus 4.6 is now controlled via the `CLAUDE_CODE_EFFORT_LEVEL` environment variable with values `low`, `medium`, `high` (default).
- The settings docs reference `CLAUDE_CODE_EFFORT_LEVEL`: "Control thinking depth for Opus 4.6: low, medium, high (default). See Adjust effort level."

**Reason for Disproof:** "Fast Mode" as a named mode cannot be verified in current official documentation. The concept has been superseded by the effort level system for Opus 4.6.

---

### REJECTED-FINDING-2026-02-18-1-A (FULL — File location `.claude/modes/` for Claude Code custom modes)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "Stored as `.claude/modes/*.agent.md` files. File Structure for Custom Modes: `.claude/modes/` — Custom mode definitions"

~~Claude Code custom modes (subagents) are stored in `.claude/modes/` using `.agent.md` extension.~~

**Contradicting Evidence:**
- Checked: [Claude Code sub-agents documentation](https://code.claude.com/docs/en/sub-agents) (accessed 2026-02-19)
- Found: "Subagents are Markdown files with YAML frontmatter. Store them in different locations depending on scope: `.claude/agents/` for current project, `~/.claude/agents/` for all projects."
- No mention of `.claude/modes/` directory anywhere in official documentation.

**Reason for Disproof:** The directory `.claude/modes/` does not exist in the official Claude Code specification. The correct directory is `.claude/agents/` for project-scoped subagents. The finding came from a third-party reference implementation (claude-code-container devcontainer docs), not official Anthropic documentation.

---

### REJECTED-FINDING-2026-02-18-1-B (FULL — `.agent.md` extension for Claude Code subagents)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "Filename convention: Use `.agent.md` extension for mode definitions (same as GitHub Copilot agents, different semantics)"

~~Claude Code custom modes/subagents use `.agent.md` file extension.~~

**Contradicting Evidence:**
- Checked: [Claude Code sub-agents documentation](https://code.claude.com/docs/en/sub-agents) and [VS Code Custom Agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents) (accessed 2026-02-19)
- Found (sub-agents docs): "Subagent files use YAML frontmatter for configuration, followed by the system prompt in Markdown" — examples show plain `.md` files (no `.agent.md`).
- Found (VS Code docs): "VS Code also detects `.md` files in the `.claude/agents` folder, following the **Claude sub-agents format**. This enables you to use the **same agent definitions across VS Code and Claude Code**." Both cases use plain `.md` extension.

**Reason for Disproof:** Claude Code uses plain `.md` files in `.claude/agents/`, not `.agent.md`. The `.agent.md` extension is a GitHub Copilot (VS Code) convention. Using `.agent.md` for Claude Code files is not documented and would not be automatically detected by Claude Code.

---

### REJECTED-FINDING-2026-02-18-1-C (PARTIAL — `version` field in Claude Code subagent frontmatter)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "YAML frontmatter: `version: 1.0.0`"

~~Claude Code subagent YAML frontmatter supports a `version` field.~~

**Contradicting Evidence:**
- Checked: [Claude Code sub-agents — supported frontmatter fields](https://code.claude.com/docs/en/sub-agents) (accessed 2026-02-19)
- Found: Documented frontmatter fields are `name`, `description`, `tools`, `disallowedTools`, `model`, `permissionMode`, `maxTurns`, `hooks`, `skills`, `memory`, `mcpServers`. No `version` field listed.

**Reason for Disproof:** `version` is not a supported YAML frontmatter field in Claude Code subagent definitions. Its inclusion in example code from a third-party reference may be silently ignored or cause unexpected behaviour.

---

### REJECTED-FINDING-2026-02-18-2-A (PARTIAL — Undocumented permission modes `delegate` and `dont_ask`)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "5. `delegate` Mode: Tool execution delegated to SDK or calling context"
> "6. `dont_ask` Mode: Proceed without callback prompts"

~~Claude Code `permissionMode` supports `delegate` and `dont_ask` as valid values.~~

**Contradicting Evidence:**
- Checked: [Claude Code sub-agents — permission modes](https://code.claude.com/docs/en/sub-agents) (accessed 2026-02-19)
- Found documented modes table: `default`, `acceptEdits`, `dontAsk`, `bypassPermissions`, `plan` — exactly 5 modes. No `delegate` or `dont_ask` listed.
- Note: `dontAsk` (camelCase) is valid; `dont_ask` (underscore) does not appear in documentation.

**Reason for Disproof:** `delegate` and `dont_ask` are not documented `permissionMode` values. The correct camelCase form for the fifth mode is `dontAsk`, not `dont_ask`. These modes appear to have originated from a third-party document, not official Anthropic documentation.

---

### REJECTED-FINDING-2026-02-18-6-A (FULL — Claude Code uses `.agent.md` files and `.claude/modes/` location)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "Both platforms converged on `.agent.md` for agent-like features."
> "Claude Code `.agent.md` (custom modes): Location: `.claude/modes/`"

~~Claude Code and GitHub Copilot both use `.agent.md` files, with Claude Code storing them in `.claude/modes/`.~~

**Contradicting Evidence:**
- Checked: [VS Code Custom Agents documentation](https://code.visualstudio.com/docs/copilot/customization/custom-agents) and [Claude Code sub-agents docs](https://code.claude.com/docs/en/sub-agents) (accessed 2026-02-19)
- Found (VS Code docs): Claude-format agents are "`.md` files in the `.claude/agents` folder" (not `.agent.md`).
- Found (sub-agents docs): Claude Code subagents are stored in `.claude/agents/` (project) or `~/.claude/agents/` (user). No `.claude/modes/` directory exists.

**Reason for Disproof:** Two errors in one claim. First, Claude Code does not use `.agent.md` — it uses plain `.md` files. Second, the directory is `.claude/agents/`, not `.claude/modes/`. This finding originated from a third-party devcontainer reference document, not Anthropic official documentation.

---

### REJECTED-FINDING-2026-02-18-7-A (PARTIAL — Wrong file path and extension in example)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container (.devcontainer/doc/claude_code_custom_modes.md)

**Original Fact:**
> "File: `.claude/modes/problem-definer.agent.md`" (with YAML field `version: 1.0.0`)

~~Claude Code custom mode files use `.agent.md` extension in a `.claude/modes/` directory with a `version` frontmatter field.~~

**Contradicting Evidence:** Same as REJECTED-FINDING-2026-02-18-1-A, -1-B, and -1-C above.

**Reason for Disproof:** Correct path is `.claude/agents/problem-definer.md` using plain `.md` extension. `version` field is not supported. The example is technically useful for the permission mode pattern it illustrates (which is valid), but the file path, extension, and frontmatter field are incorrect.

---

### REJECTED-FINDING-2026-02-18-8-A (PARTIAL — Slash commands listed as separate future merge)

**Originally Captured:** 2026-02-18 HH:MM
**Disproven:** 2026-02-19
**Original Source:** claude-code-container research, prior findings synthesis

**Original Fact:**
> "5. Slash Commands / Plugins — User-invoked workflows. May merge with skills in future."
> "`.claude/modes/*.agent.md` files" under "Custom Modes"

~~Slash commands are a separate category from skills in Claude Code and may merge in the future. Custom modes use `.claude/modes/` directory.~~

**Contradicting Evidence:** Same as REJECTED-FINDING-2026-02-17-5-A and REJECTED-FINDING-2026-02-18-1-A above.

**Reason for Disproof:** Slash commands have already merged with skills per current official documentation. The `.claude/modes/` directory does not exist. This finding inherited errors from previously rejected findings.

---

## Archive Notes

- Total findings checked: 18 (15 original + 3 refinements + 1 final summary update)
- Findings with rejected claims: 8 findings had claims partially or fully rejected
- Individual rejected claims: 10
- Findings fully accepted without modification: 10
- Verification method: `fetch_webpage` against official documentation
- Authoritative sources consulted:
  - [agentskills.io specification](https://agentskills.io/specification) (accessed 2026-02-19)
  - [GitHub Docs — About agent skills](https://docs.github.com/en/copilot/concepts/agents/about-agent-skills) (accessed 2026-02-19)
  - [GitHub Docs — Creating agent skills](https://docs.github.com/en/copilot/how-tos/use-copilot-agents/coding-agent/create-skills) (accessed 2026-02-19)
  - [VS Code — Custom agents](https://code.visualstudio.com/docs/copilot/customization/custom-agents) (page updated 2026-02-04, accessed 2026-02-19)
  - [VS Code — Prompt files](https://code.visualstudio.com/docs/copilot/customization/prompt-files) (page updated 2026-02-04, accessed 2026-02-19)
  - [Claude Code settings](https://code.claude.com/docs/en/settings) (accessed 2026-02-19)
  - [Claude Code — Create custom subagents](https://code.claude.com/docs/en/sub-agents) (accessed 2026-02-19)
  - [Claude Code — Extend Claude with skills](https://code.claude.com/docs/en/skills) (accessed 2026-02-19)
  - [Claude Code — Common workflows](https://code.claude.com/docs/en/common-workflows) (accessed 2026-02-19)

---
