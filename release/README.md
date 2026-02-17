# Release

This directory contains platform-specific releases designed to be cloned into other workspaces.

## Structure

| Directory | Install target | Platform |
|-----------|---------------|----------|
| `claude/` | `.claude/` in target workspace | Claude Code |
| `copilot/` | `.github/` in target workspace | GitHub Copilot |

## Installation

Each platform directory contains a setup prompt that will create and populate the required project-specific root file (`CLAUDE.md` or `copilot-instructions.md`) for the target workspace.

### Claude Code

Copy the contents of `claude/` into `.claude/` in your target workspace, then run the setup prompt.

### GitHub Copilot

Copy the contents of `copilot/` into `.github/` in your target workspace, then run the setup prompt.
