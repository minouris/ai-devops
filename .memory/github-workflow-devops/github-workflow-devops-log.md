# GitHub Workflow DevOps - Operation Log

**Topic:** github-workflow-devops

**Session started:** 2026-04-08

## Operations

### OP-2026-04-08-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `github-workflow-devops-index.md` - Topic index initialised
- `github-workflow-devops-log.md` - This log
- `github-workflow-devops-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: Install and authenticate GitHub CLI in workflows

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-002: Procedural research on GitHub CLI in workflows

**Operation type:** Research and fact capture

**Files created/modified:**
- `github-workflow-devops-facts.md` - Added FINDING-2026-04-08-1, 2026-04-08-2

**Key findings captured:**
- FINDING-2026-04-08-1: GitHub CLI is preinstalled on all GitHub-hosted runners; no installation required
- FINDING-2026-04-08-2: Authentication via `GH_TOKEN` environment variable set to `${{ secrets.GITHUB_TOKEN }}`

**Supporting sources:**
- GitHub Docs: Use GitHub CLI in GitHub Actions workflows

**Research focus:**
Discovered that GitHub CLI setup is minimal since it's pre-installed. Authentication is the primary configuration requirement.

**Next steps:**
- May research custom runner installation if needed
- May research advanced API usage patterns
- Ready to record additional facts from user guidance

**Timestamp:** 2026-04-08

---

### OP-2026-04-08-003: Additional research on Copilot CLI installation

**Operation type:** Fact capture and clarification

**Files created/modified:**
- `github-workflow-devops-facts.md` - Added FINDING-2026-04-08-3

**Key finding:**
- FINDING-2026-04-08-3: Copilot CLI is NOT preinstalled (unlike GitHub CLI). Must be installed explicitly via `npm install -g @github/copilot`

**Research insight:**
User asked clarifying question about Copilot CLI preinstallation, which revealed important distinction from GitHub CLI. Copilot CLI requires Node.js setup and installation step before authentication can occur.

**Timestamp:** 2026-04-08

---
