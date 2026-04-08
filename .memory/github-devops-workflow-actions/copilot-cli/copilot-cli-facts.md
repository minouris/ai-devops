# GitHub Copilot CLI Agent Modes - Fact File

**Topic:** copilot-cli-agent-modes

**Status:** Research complete

---

## FINDING-2026-04-08-1

**Topic:** Availability of official GitHub documentation on Copilot CLI agent modes

**Observation:**

Official documentation could not be found for Copilot CLI agent mode invocation. Searched GitHub's official documentation at the following locations:

- `https://docs.github.com/en/copilot/how-tos/copilot-cli/using-the-copilot-cli` — HTTP 404
- `https://docs.github.com/en/copilot/customizing-copilot-cli/configuring-models-for-copilot-cli` — HTTP 404
- `https://docs.github.com/en/copilot/copilot-cli/about-the-copilot-cli` — HTTP 404
- `https://docs.github.com/en/copilot/reference/copilot-cli-commands` — HTTP 404
- `https://docs.github.com/en/copilot/copilot-cli` — HTTP 404

All standard GitHub documentation paths for Copilot CLI returned HTTP 404 errors, indicating these documentation pages either do not exist or are not yet published.

**Implication:**

GitHub's official documentation does not currently document agent mode invocation for Copilot CLI, or agent modes may not be a supported feature of Copilot CLI as of the available documentation.

**Source:** GitHub Docs search attempt

## FINDING-2026-04-08-2

**Topic:** Copilot CLI overview and agent references

**Observation:**

The main Copilot CLI documentation at `https://docs.github.com/en/copilot/how-tos/copilot-cli` provides an overview and references agent-related functionality:

- **Custom agents** — Documentation mentions "Creating and using custom agents for GitHub Copilot CLI" as a customization option
- **Autopilot mode** — References "Delegating tasks to GitHub Copilot CLI" through an autopilot feature
- **Agent specialization** — Notes that users can "Create specialized agents with tailored expertise for specific development tasks"

However, the overview page does NOT provide:
- Enumeration of built-in agent modes (Claude SDK Agent, Codex Agent, etc.)
- CLI syntax for invoking specific agent modes
- Flags or options for mode selection
- Differences between available agents

The page itself links to more detailed documentation on these topics, but those specific documentation pages were not accessible via standard GitHub Docs URLs.

**Source:** [GitHub Docs — Copilot CLI How-Tos](https://docs.github.com/en/copilot/how-tos/copilot-cli)

---

## FINDING-2026-04-08-3

**Topic:** Model specification capability in Copilot CLI

**Observation:**

GitHub's Copilot CLI documentation references the ability to use custom LLM models. The main documentation page mentions an article titled "Using your own LLM models in GitHub Copilot CLI" which indicates that users can "Use a model from an external provider of your choice in Copilot by supplying your own API key."

This confirms that model specification is a supported feature in Copilot CLI, but the specific syntax, flags, and implementation details are not present in the overview page. The documentation structure suggests detailed information exists in a dedicated article, but access to that article via standard documentation URL patterns has not yet been established.

**Attempted documentation URLs:**
- `https://docs.github.com/en/copilot/how-tos/copilot-cli/use-your-own-llm-models-in-copilot-cli` — HTTP 404
- `https://docs.github.com/en/copilot/how-tos/copilot-cli/configuring-models-for-copilot-cli` — HTTP 404

**Source:** [GitHub Docs — Copilot CLI How-Tos](https://docs.github.com/en/copilot/how-tos/copilot-cli) (overview page mentions "Using your own LLM models in GitHub Copilot CLI" as available resource)

---

## FINDING-2026-04-08-4

**Topic:** Documentation structure for Copilot CLI model specification

**Observation:**

GitHub's documentation contains a hierarchical structure of reference pages that reference each other:

1. Main Copilot CLI overview — Links to articles including "Using your own LLM models in GitHub Copilot CLI"
2. `/en/copilot/reference/copilot-cli-reference` — Describes itself as having "commands and keyboard shortcuts to help you use Copilot CLI effectively" but does not include detailed flags/options
3. `/en/copilot/reference/ai-models` — Overview page referencing linked resources for model details
4. Mentioned but not accessible: "supported models page", "model comparison page", etc.

All intermediate reference pages defer to linked documentation, creating a chain of references. The actual implementation details (command flags for model specification, available model names for Copilot accounts) exist in the documentation structure but access to the final detailed pages requires the correct URL path.

**Research Gap:**

Unable to locate the actual command reference with model specification flags or the models page listing available models for Copilot CLI use. The documentation structure indicates this information exists but the correct URLs have not been established.

**Source:** Navigation of GitHub's `/en/copilot/reference/` documentation pages

---

## FINDING-2026-04-08-5

**Topic:** Specifying model with Copilot CLI --model flag

**Observation:**

GitHub Copilot CLI supports model specification via the `--model=<model>` flag. Three methods exist for specifying which model to use:

**1. Command-line flag:**
```bash
copilot -p "YOUR_PROMPT" --model claude-haiku-4.5
```

**2. Environment variable:**
Set `COPILOT_MODEL` environment variable before running commands:
```bash
export COPILOT_MODEL=claude-haiku-4.5
copilot -p "YOUR_PROMPT"
```

**3. Configuration file:**
Persists model preference in `~/.copilot/config.json`:
```json
{
  "model": "claude-haiku-4.5"
}
```

**Model Selection Priority:**
Copilot CLI checks for model specifications in this order (first match wins):
1. Custom agent definition
2. Command-line option (`--model=<model>`)
3. Environment variable (`COPILOT_MODEL`)
4. Configuration file (`~/.copilot/config.json`)
5. Default model (if none specified)

**Available Models (examples from documentation):**
- `claude-haiku-4.5` — Fast, lower-cost option for straightforward tasks
- `claude-sonnet-4.6` — Example provided
- `gpt-5.3-codex` — More powerful model for complex reasoning
- `gpt-5.2` — Example provided

**Note:** The documentation states "You can find the model strings for all available models in the description of the `--model` option when you enter `copilot help` in your terminal." Users should check their local CLI help for the complete list of available models for their account.

**Source:** [GitHub Docs — Copilot CLI Programmatic Reference](https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-programmatic-reference)

**Date captured:** 2026-04-08

---
