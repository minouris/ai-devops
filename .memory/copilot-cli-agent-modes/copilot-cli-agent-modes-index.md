# GitHub Copilot CLI Agent Modes - Topic Index

**Topic Slug:** copilot-cli-agent-modes

**Topic Name:** GitHub Copilot CLI Agent Modes

**Created:** 2026-04-08

---

## Knowledge Summary

Research into specifying AI models with GitHub Copilot CLI. Focuses on the `--model=<model>` flag, available Copilot-provided models, and configuration precedence. Original research direction (agent modes) clarified to mean Agent Skills and model specification via CLI.

---

## Research Areas

- Model specification via `--model` flag (COMPLETE)
- Configuration methods: CLI flag, environment variable, config file (COMPLETE)
- Available Copilot models (claude-haiku-4.5, claude-sonnet-4.6, gpt-5.3-codex, gpt-5.2)
- Model selection priority order (COMPLETE)

---

## Key Concepts

- **GitHub Copilot CLI** — Command-line interface for Copilot
- **`--model=<model>` flag** — CLI option to specify which model to use
- **`COPILOT_MODEL` environment variable** — Persistent model preference via environment
- **`~/.copilot/config.json`** — Persistent model preference via configuration file
- **Model priority** — Selection order: custom agent → CLI flag → env var → config file → default

---

## Navigation

- Main facts: [copilot-cli-agent-modes-facts.md](copilot-cli-agent-modes-facts.md)
- Operation log: [copilot-cli-agent-modes-log.md](copilot-cli-agent-modes-log.md)

---
