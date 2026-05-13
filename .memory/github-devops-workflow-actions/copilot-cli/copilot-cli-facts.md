# GitHub DevOps Workflow Actions — Copilot CLI Configuration - Facts

**Topic:** github-devops-workflow-actions / Subtopic: copilot-cli

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** Specifying model in Copilot CLI for GitHub Actions workflows

**Introduces terms:** [Model selection priority](../github-devops-workflow-actions-terms.md#model-selection-priority)

**Uses terms:** [`--model` flag](../github-devops-workflow-actions-terms.md#--model-flag), [`COPILOT_MODEL` environment variable](../github-devops-workflow-actions-terms.md#copilot_model-environment-variable)

**Observation:**

GitHub Copilot CLI supports model specification via `--model=<model>` flag. Model selection priority: custom agent → CLI flag → env var → config file → default.

**Source:** [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference)

**Date captured:** 2026-04-08

---

## FINDING-2026-04-08-2

**Topic:** Custom instructions configuration for Copilot CLI

**Observation:**

Copilot uses custom instructions from CLAUDE.md, GEMINI.md, AGENTS.md at repository root and `.github/instructions/**/*.instructions.md` for path-specific instructions.

**Source:** [GitHub Docs — Copilot CLI Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference)

**Date captured:** 2026-04-09

---

## FINDING-2026-04-08-3

**Topic:** Specifying custom instructions directories for Copilot CLI

**Introduces terms:** [Custom instructions](../github-devops-workflow-actions-terms.md#custom-instructions)

**Uses terms:** [`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable](../github-devops-workflow-actions-terms.md#copilot_custom_instructions_dirs-environment-variable)

**Observation:**

Use `COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable with comma-separated directory list. Copilot searches for AGENTS.md and `.github/instructions/**/*.instructions.md` files. No command-line flag exists for this configuration.

**Source:** [GitHub Docs — Copilot CLI: Add Custom Instructions](https://docs.github.com/en/copilot/how-tos/copilot-cli/customize-copilot/add-custom-instructions)

**Date captured:** 2026-04-09

---
