# Terms Index

| Term | Short Description |
|------|-------------------|
| [Automatic caching via setup actions](github-devops-workflow-actions-terms.md#automatic-caching-via-setup-actions) | Language-specific setup actions that include built-in automatic caching of package manager artifacts without manual configuration. |
| [`--model` flag](github-devops-workflow-actions-terms.md#--model-flag) | Command-line argument specifying which AI model Copilot CLI uses when executing a prompt. |
| [`--no-ask-user` flag](github-devops-workflow-actions-terms.md#--no-ask-user-flag) | Copilot CLI flag preventing interactive prompts during automated workflow execution. |
| [`actions/checkout` action](github-devops-workflow-actions-terms.md#actionscheckout-action) | GitHub Actions action that retrieves repository code and places it in the default working directory. |
| [`COPILOT_CUSTOM_INSTRUCTIONS_DIRS` environment variable](github-devops-workflow-actions-terms.md#copilot_custom_instructions_dirs-environment-variable) | Environment variable accepting comma-separated list of directories where Copilot CLI searches for custom instruction files. |
| [`COPILOT_GITHUB_TOKEN` environment variable](github-devops-workflow-actions-terms.md#copilot_github_token-environment-variable) | Environment variable containing Personal Access Token for Copilot CLI authentication in workflows. |
| [`COPILOT_MODEL` environment variable](github-devops-workflow-actions-terms.md#copilot_model-environment-variable) | Environment variable setting the default model for Copilot CLI execution when no `--model` flag is provided. |
| [Cache restoration algorithm](github-devops-workflow-actions-terms.md#cache-restoration-algorithm) | Three-tier search mechanism for retrieving cached artifacts: exact key match → partial restore-keys match → cache miss. |
| [Cache scope isolation](github-devops-workflow-actions-terms.md#cache-scope-isolation) | Deliberate hierarchy controlling which workflows access which caches based on branch relationships and pull request context. |
| [`cache-hit` output](github-devops-workflow-actions-terms.md#cache-hit-output) | Boolean-like output from cache action indicating cache restore result: `'true'` for exact match, `'false'` for partial match, or empty string for miss. |
| [`contains()` function](github-devops-workflow-actions-terms.md#contains-function) | GitHub Actions expression function that checks if an array includes a specific item; performs case-insensitive matching. |
| [Copilot CLI invocation](github-devops-workflow-actions-terms.md#copilot-cli-invocation) | Executing Copilot CLI in non-interactive workflow steps using `-p PROMPT` flag syntax with required authentication. |
| [Custom actions](github-devops-workflow-actions-terms.md#custom-actions) | Reusable workflow components created using Docker, JavaScript, or Composite approaches that can be invoked in workflow steps. |
| [Custom instructions](github-devops-workflow-actions-terms.md#custom-instructions) | Project-specific context files that provide Copilot with additional information on how to understand and work with a project. |
| [Event triggers](github-devops-workflow-actions-terms.md#event-triggers) | Events that automatically initiate GitHub Actions workflows, configured via the `on` keyword in workflow files. |
| [`github.event.issue` context object](github-devops-workflow-actions-terms.md#githubeeventissue-context-object) | Context object containing issue data available in workflows triggered by the issues event. |
| [GitHub CLI preinstallation](github-devops-workflow-actions-terms.md#github-cli-preinstallation) | GitHub CLI (`gh`) is preinstalled on all GitHub-hosted runners; requires only authentication, not installation. |
| [GitHub Copilot](github-devops-workflow-actions-terms.md#github-copilot) | AI coding assistant that provides code suggestions and assistance across multiple GitHub environments. |
| [GitHub context object](github-devops-workflow-actions-terms.md#github-context-object) | Context object providing access to information about the event, runner, repository, and triggering context within workflow steps. |
| [GitHub-hosted runner provisioning](github-devops-workflow-actions-terms.md#github-hosted-runner-provisioning) | Each GitHub Actions job executes on a freshly-provisioned virtual machine without repository code. |
| [`GH_TOKEN` environment variable](github-devops-workflow-actions-terms.md#gh_token-environment-variable) | Environment variable for GitHub CLI authentication in workflows, typically set to `${{ secrets.GITHUB_TOKEN }}`. |
| [`GITHUB_TOKEN` automatic token](github-devops-workflow-actions-terms.md#github_token-automatic-token) | Automatic token available in GitHub Actions workflows with scopes determined by job-level `permissions` configuration. |
| [`GITHUB_WORKSPACE` environment variable](github-devops-workflow-actions-terms.md#github_workspace-environment-variable) | Default working directory on runner; example path: `/home/runner/work/my-repo-name/my-repo-name`. |
| [Issue activity types](github-devops-workflow-actions-terms.md#issue-activity-types) | Specific issue event triggers: opened, edited, deleted, closed, reopened, assigned, unassigned, labeled, unlabeled, pinned, unpinned, transferred, milestoned, demilestoned, locked, unlocked, typed, untyped. |
| [`issues` event](github-devops-workflow-actions-terms.md#issues-event) | GitHub Actions trigger fired when issue lifecycle events occur within the repository. |
| [`issues: read` permission](github-devops-workflow-actions-terms.md#issues-read-permission) | Workflow permission granting read-only access to repository issues. |
| [`issues: write` permission](github-devops-workflow-actions-terms.md#issues-write-permission) | Workflow permission granting read and write access to repository issues. |
| [Label filtering](github-devops-workflow-actions-terms.md#label-filtering) | Using `contains()` function in job-level `if` conditions to execute jobs only when specific labels present or absent. |
| [Model selection priority](github-devops-workflow-actions-terms.md#model-selection-priority) | Hierarchical precedence determining which model Copilot CLI uses: custom agent → CLI flag → environment variable → config file → default. |
| [npm installation of Copilot CLI](github-devops-workflow-actions-terms.md#npm-installation-of-copilot-cli) | Installing Copilot CLI globally on runners using `npm install -g @github/copilot`. |
| [Preinstalled software on runners](github-devops-workflow-actions-terms.md#preinstalled-software-on-runners) | System tools and applications available on all GitHub-hosted runners without installation. |
| [Run keyword](github-devops-workflow-actions-terms.md#run-keyword) | Workflow step keyword that executes shell commands or scripts with configurable shell environments. |
| [Skill invocation via Copilot CLI](github-devops-workflow-actions-terms.md#skill-invocation-via-copilot-cli) | Calling custom skills and agents through Copilot CLI using prompts like `/skill-name $ARGUMENTS` in workflows. |
| [Steps](github-devops-workflow-actions-terms.md#steps) | Individual tasks within a GitHub Actions job that execute sequentially, either running shell commands or invoking reusable actions. |
| [Uses keyword](github-devops-workflow-actions-terms.md#uses-keyword) | Workflow step keyword that invokes reusable custom actions with inputs passed via the `with` keyword. |
| [Workflow file](github-devops-workflow-actions-terms.md#workflow-file) | YAML file stored in `.github/workflows/` directory that defines a GitHub Actions workflow configuration. |
| [Workflow_dispatch trigger](github-devops-workflow-actions-terms.md#workflow_dispatch-trigger) | Event trigger enabling manual workflow execution from GitHub interface with custom input parameters. |

