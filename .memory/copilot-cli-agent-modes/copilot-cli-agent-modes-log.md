# GitHub Copilot CLI Agent Modes - Operation Log

**Topic:** copilot-cli-agent-modes

**Session started:** 2026-04-08

## Operations

### OP-2026-04-08-001: Topic bootstrap

**Operation type:** Session initialisation

**Files created:**
- `copilot-cli-agent-modes-index.md` - Topic index initialised
- `copilot-cli-agent-modes-log.md` - This log
- `copilot-cli-agent-modes-facts.md` - Fact file initialised

**Key output:**
- Topic structure created, ready for research
- Research focus: How to invoke different agent modes with Copilot CLI

### OP-2026-04-08-002: Research completion on model specification

**Operation type:** Research completion with authoritative documentation

**Files created/modified:**
- `copilot-cli-agent-modes-facts.md` - Added FINDING-2026-04-08-5 (model specification via --model flag)
- `copilot-cli-agent-modes-index.md` - Updated to reflect research focus and completion
- `copilot-cli-agent-modes-log.md` - This entry

**Key findings:**
- FINDING-2026-04-08-5: `--model=<model>` flag specifies which Copilot model to use in CLI
- Three configuration methods: CLI flag, environment variable (`COPILOT_MODEL`), config file (`~/.copilot/config.json`)
- Model selection priority order documented
- Example models: claude-haiku-4.5, claude-sonnet-4.6, gpt-5.3-codex, gpt-5.2
- Complete list of available models accessible via `copilot help` in terminal

**Research status:** COMPLETE

Model specification for Copilot-provided models in Copilot CLI is fully documented with authoritative source.

**Timestamp:** 2026-04-08

---
