# Claude Skill Distribution - Research Findings

**Topic:** Claude Skill Distribution Strategies
**Research Focus:** Version-controlled, dependency-aware distribution of Claude Skills across multiple projects with central source updates

**Status:** Research In Progress

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

## Findings

### FINDING-2026-04-04-1
**Captured:** 2026-04-04 08:00
**Source:** `/workspaces/ai-devops/src/claude/README.md`, `/workspaces/ai-devops/src/claude/skills/`
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Skills: Open Standard Format and Storage Location**

Claude Code skills are based on the open standard `agentskills.io` specification (originally developed by Anthropic, adopted by GitHub Copilot, Claude Code, and other agents).

- **Storage locations:** `.github/skills/[skill-name]/SKILL.md` or `.claude/skills/[skill-name]/SKILL.md`
- **File format:** YAML frontmatter (name, description, license, metadata) + Markdown body
- **Progressive disclosure pattern:** Metadata (~100 tokens) loaded at agent startup; full body (<5000 tokens) loaded when activated
- **Portable:** Runs across different AI agent platforms (Anthropic Claude, GitHub Copilot, VS Code)

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-2
**Captured:** 2026-04-04 08:00
**Source:** `/workspaces/ai-devops/src/claude/README.md` - "Installation" section
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Manual Copy Distribution Pattern (Current Approach)**

The current recommended distribution method for Claude Code skills and artifacts is manual copying:

For new projects:
```bash
cp src/claude/skills/analysis.md .claude/skills/
cp src/claude/prompts/verify-memory-facts.md .claude/prompts/
cp src/claude/rules/documentation-first.md .claude/rules/
```

For global use:
```bash
cp src/claude/skills/analysis.md ~/.claude/skills/
```

**Characteristics:**
- Simple, file-based distribution
- No built-in versioning
- No automatic dependency management
- No update propagation mechanism
- Reproducible within a single project via copying

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-3
**Captured:** 2026-04-04 08:00
**Source:** `/workspaces/ai-devops/release/github/sync-instructions.sh`
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**GitHub API Pull-Based Sync Mechanism (Existing Implementation)**

The ai-devops project includes a shell script (`sync-instructions.sh`) that implements a pull-based distribution mechanism for syncing instruction files from upstream repositories.

**Implementation:**
- Uses GitHub CLI (`gh api`) to fetch file contents from source repo
- Base64 decodes content received from GitHub API
- Overwrites local files with fetched content
- Uses `git diff` to show what changed
- Manual `git add` and commit by user after pull

**Configuration:**
- Source repo variable: `minouris/nightingale-truenas`
- Source branch: `main`
- Syncs: `.github/copilot-instructions.md`, instruction files, prompt files

**Limitations:**
- One-way pull only (push requires manual process via PR)
- No version pinning
- No dependency tracking
- Overwrites all pulled files (no merge/conflict resolution)
- Manual commit step required

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-4
**Captured:** 2026-04-04 08:00
**Source:** `/workspaces/ai-devops/devcontainer.json` - mounts section
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Devcontainer Mount Pattern for Distribution**

The project uses devcontainer mounts to distribute Claude Code artifacts:

```json
"mounts": [
  "source=${localWorkspaceFolder}/.devcontainer/.claude-data,target=/home/vscode/.claude,type=bind",
  "source=${localWorkspaceFolder}/src/claude,target=${containerWorkspaceFolder}/.claude,type=bind"
]
```

**Characteristics:**
- Direct filesystem mounting in container
- Artifacts in `src/claude/` visible as `.claude/` in container
- Allows local modifications without copying
- Devcontainer-specific (not applicable to direct filesystem use)

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-5
**Captured:** 2026-04-04 08:01
**Source:** General knowledge - npm documentation patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**npm (Node Package Manager) - TypeScript/JavaScript Distribution Pattern**

npm provides a centralised registry for package distribution with dependency management:

**Key characteristics:**
- Registry-based: packages published to npmjs.com or private registries
- Version management: semver versioning (major.minor.patch)
- Dependency resolution: automatic transitive dependency installation via `package.json`
- Installation model: `npm install @scope/package-name@version`
- Update model: `npm update` or `npm install @scope/package-name@latest`
- Lock files: `package-lock.json` for reproducible deployments
- Source repositories: Git URLs, Git branches supported as fallback

**Distribution workflow:**
1. Author publishes package to npm registry
2. Consumer defines dependency in `package.json`
3. npm resolves and downloads all transitive dependencies
4. Lock file ensures deterministic builds
5. Updates available via `npm update` or manual version bump

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-6
**Captured:** 2026-04-04 08:01
**Source:** General knowledge - pip/PyPI documentation patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**pip (Python Package Installer) - Python Distribution Pattern**

pip provides package management for Python with PyPI registry:

**Key characteristics:**
- Registry-based: packages published to PyPI or private package repositories
- Version management: PEP 440 versioning scheme
- Dependency resolution: automatic via setup.py or pyproject.toml
- Installation model: `pip install package-name==version`
- Update model: `pip install --upgrade package-name`
- Requirements files: `requirements.txt` for pin-able dependency trees
- Virtual environments: isolated environment management

**Distribution workflow:**
1. Author publishes package to PyPI
2. Consumer creates `requirements.txt` dependency
3. `pip install -r requirements.txt` downloads and installs all dependencies
4. Virtual environment isolates project dependencies
5. Updates available via manual version bump

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-7
**Captured:** 2026-04-04 08:01
**Source:** General knowledge - Maven documentation patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Maven - Java Distribution Pattern**

Maven provides centralised repository (Maven Central) for Java package distribution:

**Key characteristics:**
- Registry-based: Maven Central Repository or private Nexus/Artifactory
- Version management: semantic versioning + SNAPSHOT/RELEASE designation
- Dependency management: declarative in `pom.xml`, transitive dependency resolution
- Installation model: `mvn clean install` downloads dependencies automatically
- Update model: Version bump in `pom.xml` + `mvn clean install`
- Coordinates: `groupId:artifactId:version` uniquely identifies artifacts

**Distribution workflow:**
1. Author deploys package to Maven Central via Nexus/Artifactory
2. Consumer declares dependency in `pom.xml`
3. Maven resolves transitive dependencies automatically
4. Downloads happen during build phase
5. Version updates controlled via pom.xml

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---

### FINDING-2026-04-04-8
**Captured:** 2026-04-04 08:01
**Source:** General knowledge - Gradle documentation patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Gradle - Java/Kotlin Distribution Pattern**

Gradle provides flexible build system with Maven Central and custom repository support:

**Key characteristics:**
- Registry-based: Maven Central, Gradle Plugin Portal, custom repositories
- Version management: semantic versioning + dynamic version expressions
- Dependency management: declarative in `build.gradle`, supports transitive resolution
- Installation model: `gradle build` downloads dependencies during build
- Update model: Version expression in `build.gradle` (e.g., `1.+`, `latest.release`)
- Lock mechanism: `gradle.lockfile` for reproducible builds

**Distribution workflow:**
1. Author publishes to Maven Central or Gradle Plugin Portal
2. Consumer declares in `build.gradle` with dependency notation
3. Gradle resolves and downloads during build
4. Dynamic versions enable flexible update strategies
5. Lock file ensures reproducible builds

---

### FINDING-2026-04-04-9
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of industry patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Common Patterns Across Package Managers**

All major package managers (npm, pip, Maven, Gradle) implement similar core patterns:

**Shared characteristics:**
1. **Centralised registry:** Single source of truth for available packages
2. **Version management:** Semantic versioning (major.minor.patch) or equivalent
3. **Dependency resolution:** Automated transitive dependency handling
4. **Lock files:** Reproducibility mechanism (package-lock.json, requirements.txt, gradle.lockfile)
5. **Version pinning:** Consumer controls when to pull updates
6. **Update availability:** Check commands (npm outdated, pip list --outdated)
7. **Installation atomicity:** Updates applied cleanly without partial state

---

### FINDING-2026-04-04-10
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 1: Package Manager Approach**

For TypeScript/JavaScript skills, use npm with @scope namespace:

**Implementation:**
- Publish individual skills as @anthropic-ai/skills-* packages to npm
- Or single monorepo package @anthropic-ai/skills with skill list
- Consumers: `npm install @anthropic-ai/skills`
- Copy from node_modules/.claude/skills into project .claude/skills/
- Version control via package.json + package-lock.json

**Advantages:**
- Familiar to JavaScript developers
- Built-in dependency resolution and version management
- Clear semantic versioning model
- Central registry (npmjs.com) for discovery

**Limitations:**
- Requires Node.js/npm ecosystem in project
- Language-specific (TypeScript/JavaScript only)
- Adds npm as build dependency

---

### FINDING-2026-04-04-11
**Captured:** 2026-04-04 08:02
**Source:** Anthropic GitHub, agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 2: Git-Based Registry Approach**

Centralised Git repository with GitHub Releases for versioning:

**Implementation:**
- Create `claude-skills-registry` repository with skill directory structure
- Tag releases with semantic versions (v1.0.0, v1.1.0, etc.)
- Consumers clone/pull specific tag or use GitHub raw content URLs
- Script updates: pull from release tags, commit changes locally
- Version control: pin to specific release tags in sync scripts

**Update flow:**
1. Author publishes skill to central registry repo
2. Tags release with version number
3. Consumer runs sync script targeting specific release tag
4. Script pulls via GitHub API or git submodule
5. Changes committed locally for reproducibility

**Advantages:**
- Platform-agnostic (works with any language/project)
- Portable across different CI/CD systems
- Clear versioning via Git tags
- Multiple skills in single repository

**Limitations:**
- Manual version management
- No transitive dependency resolution
- Requires Git + GitHub API in consumer projects
- Pull-based model (consumer must initiate updates)

---

### FINDING-2026-04-04-12
**Captured:** 2026-04-04 08:02
**Source:** Synthesis of agentskills.io patterns
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 3: Hybrid Central Repository Approach**

Centralised repository with multiple language package managers as mirrors:

**Implementation:**
- Central authority: GitHub repository with canonical skill definitions
- npm mirror: Published to @anthropic-ai/skills namespace
- PyPI mirror: Published as anthropic-ai-skills package
- Maven Central mirror: Published as com.anthropic.skills artifacts
- Gradle Plugin Portal: For Gradle-specific distribution

**Version coordination:**
- Single source of truth in Git
- All mirrors tagged with same semantic version
- Release workflow automates publishing to all registries
- Consumers get native package manager experience for their language stack

**Advantages:**
- Single source of truth (Git repository)
- Native package manager experience across languages
- Central updates propagate to all registries
- Clear versioning and reproducibility

**Limitations:**
- Complex release/publish pipeline
- Requires maintaining integrations with multiple registries
- Dependency management varies by ecosystem

---

### FINDING-2026-04-04-13
**Captured:** 2026-04-04 08:02
**Source:** Synthesis from ai-devops sync-instructions.sh pattern
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Distribution Strategy 4: API-Based Update Service**

Lightweight HTTP API that serves skill metadata and content:

**Implementation:**
- Central HTTP API endpoint serving skill registry (JSON or YAML)
- Registry includes: skill name, description, version, content hash, download URL
- Consumer SDK/CLI tool queries API and downloads skills
- Version management: API serves specific versions via URL path
- Updates: Consumer runs CLI tool to check and pull latest versions

**Registry format:**
```json
{
  "skills": [
    {
      "name": "analysis",
      "description": "Research and analysis workflow",
      "version": "1.0.0",
      "sha256": "abc123...",
      "download_url": "https://api.skills.anthropic.io/download/analysis/1.0.0"
    }
  ]
}
```

**Update flow:**
1. Author publishes skill and updates central API registry
2. Consumer CLI queries API for available skills and versions
3. CLI downloads and verifies skill via hash
4. Skill integrated into project's .claude/skills/

**Advantages:**
- Language-agnostic
- Versioning separated from Git
- Lightweight HTTP API (no package manager overhead)
- Discovery mechanism built-in

**Limitations:**
- Requires maintaining HTTP API service
- No built-in dependency resolution
- SDK/CLI tool must be maintained across platforms

---

### FINDING-2026-04-04-14
**Captured:** 2026-04-04 08:03
**Source:** Industry analysis and agentskills.io specification
**Verified:** [NOT YET VERIFIED - requires verification workflow]

**Recommended Approach for Claude Code Skills Distribution**

Given the characteristics of skills and the need for multi-language support:

**Phase 1: Immediate (Git-Based Registry)**
- Use Strategy 2 (Git-Based Registry Approach)
- Create `anthropic/claude-skills` repository on GitHub
- Each skill in `skills/[skill-name]/SKILL.md` structure
- Release versions as Git tags with semantic versioning
- Simple sync script pulls from specific release tags
- Minimal infrastructure required

**Phase 2: Medium-term (Hybrid with Package Managers)**
- Implement Strategy 3 (Hybrid Central Repository)
- Publish to npm, PyPI, Maven Central, Gradle Plugin Portal
- Maintain single Git source of truth
- Automate publishing via CI/CD pipeline to all registries
- Consumers get native package manager experience

**Phase 3: Long-term (Managed Distribution Service)**
- Implement Strategy 4 (API-Based Update Service)
- Anthropic-hosted registry and discovery service
- SDK/CLI tool for easy skill discovery and installation
- Built-in update checking and management
- Standardised skill metadata and versioning

---
