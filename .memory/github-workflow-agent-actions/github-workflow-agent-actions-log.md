# GitHub Workflow Agent Actions - Operation Log

**Topic:** github-workflow-agent-actions

**Session started:** 2026-04-07

## Operations

### OP-2026-04-07-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-workflow-agent-actions-index.md` - Topic index initialised
- `github-workflow-agent-actions-log.md` - This log
- `github-workflow-agent-actions-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: How to run a GitHub Copilot prompt as a workflow action

**Timestamp:** 2026-04-07

---

### OP-2026-04-08-001: Procedural research — authentication and action inputs

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-workflow-agent-actions-facts.md` - Added FINDING-2026-04-07-3, 2026-04-07-4, 2026-04-07-5

**Key findings:**
- Documented action input parameters (prompt, api_key, claude_args, model, max_tokens, settings)
- Documented permission requirements (contents, issues, pull-requests, id-token)
- Clarified authentication methods: API key, cloud provider, OIDC
- Provided minimal working workflow structure with variations

**Next steps:**
- Continue research on advanced usage patterns
- Document error handling and output capture
- Confirm findings against updated documentation if available

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-002: Research completion and documentation

**Operation type:** Session conclusion and knowledge base update

**Files created/modified:**
- `github-workflow-agent-actions-facts.md` - Added FINDING-2026-04-07-6 (project reference implementation)
- `github-workflow-agent-actions-log.md` - This entry

**Key findings:**
- Confirmed complete workflow pattern using project's inspect-ai-problem-issue.yml as reference
- All input parameters documented (prompt, api_key, claude_args, permissions)
- Authentication methods verified (API key, cloud providers, OIDC)
- Minimal and complete working examples provided

**Research status:** COMPLETE

All key aspects of running a GitHub Copilot prompt (Claude skill) as a GitHub Actions workflow action have been documented with sources and real-world examples from this project.

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-003: Research restart with GitHub official documentation

**Operation type:** Research reset and fact capture from authoritative sources

**Files created/modified:**
- `github-workflow-agent-actions-facts-disproven.md` - Created; archived findings 1-6 (external project sources)
- `github-workflow-agent-actions-facts.md` - Cleared; added FINDING-2026-04-08-1 through 2026-04-08-6

**Key findings from GitHub official documentation:**
- FINDING-2026-04-08-1: Custom actions via Docker, JavaScript, or Composite approaches
- FINDING-2026-04-08-2: Workflow file structure and core properties
- FINDING-2026-04-08-3: Event triggers and custom inputs
- FINDING-2026-04-08-4: Command execution in workflow steps
- FINDING-2026-04-08-5: Invoking custom actions and passing inputs
- FINDING-2026-04-08-6: GitHub Copilot functionality; no documented workflow invocation mechanism

**Critical finding:** GitHub's official documentation describes custom actions and workflow automation, but does NOT document a mechanism for invoking Copilot prompts directly from GitHub Actions workflows. Copilot integration is documented for IDE/CLI/web interfaces only.

**Implications:**
Running "a GitHub Copilot prompt as a workflow action" would require either:
1. Creating a custom action that internally uses Copilot (not documented by GitHub)
2. Using a third-party action that bridges Copilot and workflows (external solution, not GitHub's)
3. Clarification: is the user asking about something different?

**Next steps:** Await user clarification on actual requirement.

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-004: Discovery of authoritative GitHub documentation on Copilot in workflows

**Operation type:** Research completion with correct source material

**Files created/modified:**
- `github-workflow-agent-actions-facts.md` - Added FINDING-2026-04-08-7 (authoritative GitHub documentation)

**Key finding:**
- FINDING-2026-04-08-7: GitHub Copilot CLI invocation in workflows via `copilot -p PROMPT` command

**Critical Resolution:**
User provided correct documentation reference: GitHub DOES document how to invoke Copilot in workflows via Copilot CLI. The mechanism is direct command invocation within workflow steps, not through a separate action.

**Setup summary:**
1. Trigger workflow (schedule/manual)
2. Checkout repository
3. Install Copilot CLI globally: `npm install -g @github/copilot`
4. Create PAT with "Copilot Requests" permission
5. Set `COPILOT_GITHUB_TOKEN` environment variable
6. Run: `copilot -p "PROMPT" --allow-tool=[TOOLS] --no-ask-user`

**Source:** [GitHub Docs — Automate Copilot CLI with Actions](https://docs.github.com/en/copilot/how-tos/copilot-cli/automate-copilot-cli/automate-with-actions)

**Research status:** COMPLETE

All aspects of running a GitHub Copilot prompt as a GitHub Actions workflow have been documented with official GitHub sources.

**Timestamp:** 2026-04-08

---

### OP-2026-04-09-001: Research on custom instructions folder configuration

**Operation type:** Procedural research

**Files created/modified:**
- `github-workflow-agent-actions-facts.md` - Added FINDING-2026-04-09-1 (custom instructions investigation)

**Key finding:**
- FINDING-2026-04-09-1: Custom instructions feature exists in GitHub documentation but technical specifications are incomplete

**Research approach:**
- Consulted GitHub Docs CLI reference — lists available flags but no custom instructions folder option
- Consulted GitHub Docs Copilot customizing — mentions feature but detailed configuration documentation not accessible
- Searched for official documentation on file paths, command-line flags, configuration format

**Gaps identified:**
- No CLI flag documented for specifying custom instructions folder
- File path/directory location not specified in accessible documentation
- File format and naming conventions not documented
- How Copilot CLI discovers or reads instructions not specified

**Next steps:**
- May require empirical testing to discover if/how Copilot CLI respects project-level instruction files
- Check actual Copilot CLI `help` output for undocumented flags
- Consult community resources or GitHub support for clarification

**Timestamp:** 2026-04-09

---

### OP-2026-04-09-002: Research completion — custom instructions directory configuration

**Operation type:** Research with authoritative source discovery

**Files created/modified:**
- `github-workflow-agent-actions-facts.md` - Added FINDING-2026-04-09-2 (custom instructions directory configuration)

**Key finding:**
- FINDING-2026-04-09-2: Copilot CLI uses `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable to specify custom instruction directories

**Critical information:**
- Environment variable: `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` (comma-separated list)
- File discovery: `AGENTS.md`, `.github/instructions/**/*.instructions.md`
- Repository-level files: `CLAUDE.md`, `GEMINI.md`, `AGENTS.md` (auto-discovered)
- Applicable to GitHub Actions workflows via environment variable configuration
- No command-line flag exists; environment variable is the documented approach

**Solution for workflows:**
```yaml
env:
  COPILOT_CUSTOM_INSTRUCTIONS_DIRS: /path/to/instructions,/another/path
run: copilot -p "PROMPT" --no-ask-user
```

**Source:** [GitHub Docs — Copilot CLI: Add Custom Instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions)

**Research status:** COMPLETE

**Timestamp:** 2026-04-09

---

