# Knowledge Base Index

**Last Updated:** 2026-03-23

---

## Quick Search Guide

Use this index to locate knowledge relevant to your task:

| If you need... | See Topic | Key Findings |
|---|---|---|
| GitHub authentication & token management | [github-api](#github-api) | FINDING-2026-03-11-06, 07, 16, 18, 19 |
| REST/GraphQL API operations | [github-api](#github-api) | FINDING-2026-03-11-02, 05, 10, 12 |
| Comment & review thread resolution | [github-api](#github-api) | FINDING-2026-03-11-03, 05, 27, 28, 29 |
| Credential integration with curl/git | [github-api](#github-api) | FINDING-2026-03-11-24, 25, 26 |
| AI coding problems & root causes | [ai-problem-resolution](#ai-problem-resolution) | 7 problems, 4 root causes, 9+ external evidence findings |
| AI instruction compliance & hallucination | [ai-problem-resolution](#ai-problem-resolution) | Root causes (hallucination, dishonesty, amnesia, overeagerness), Context poisoning |
| Term definition & semantic indexing | [analysis-concepts](#analysis-concepts) | FINDING-2026-03-22-1, 2, 3 |
| Research methodology | [analysis-concepts](#analysis-concepts) | FINDING-2026-03-22-2, 3 |

---

## Topic Directories

### github-api

**Knowledge Summary:**

Authoritative research on GitHub API capabilities, authentication methods, and pull request operations. Designed to support both procedural implementation (testing API endpoints) and architectural decision-making (choosing REST vs GraphQL). Covers credential acquisition, API authentication, PR comment resolution workflows, and integration patterns with git and curl. Includes verified procedures for resolving comment threads and bulk operations on pull requests.

**Quick Links:**
- Full index: [github-api-index.md](github-api/github-api-index.md)
- Main facts: [github-api-facts.md](github-api/github-api-facts.md)
- Terms: [github-api-terms.md](github-api/github-api-terms.md)
- Procedures: [Review comment resolution procedure](github-api/github-api-review/github-api-review-resolution-procedure.md)

**Research Areas:**
- Authentication & Credentials (8 verified findings)
- REST API Operations (5 verified findings)
- GraphQL Mutations (4 verified findings)
- Comment & Review Thread Resolution (5 verified findings, 1 disproven)
- Git Integration (4 verified findings)
- Credential Management (2 verified findings)
- Documentation & Limitations (1 verified finding)

**Key Concepts:**
- Personal Access Token (PAT) — GitHub-issued credential for REST API authentication
- GitHub GraphQL API — Query language interface for complex GitHub operations
- Review Thread — Grouped comment conversation on pull request code
- Git Credential Fill — Command storing credentials for repeated authentication
- REST API — Standard HTTP interface for GitHub operations

---

### ai-problem-resolution

**Knowledge Summary:**

Comprehensive analysis of AI coding problems encountered in real projects, root causes driving these problems, and catalogued solutions. Covers endemic issues (instruction non-compliance, hallucination, context overflow) and evolving workflow problems. Includes cross-reference mapping between problems and root causes, external evidence from published research and production incidents, and agent-specific issues. Designed to support problem diagnosis, root cause analysis, and solution tracking across multiple AI-driven projects.

**Quick Links:**
- Full index: [ai-problem-resolution-index.md](ai-problem-resolution/ai-problem-resolution-index.md)
- Main facts: [ai-problem-resolution-facts.md](ai-problem-resolution/ai-problem-resolution-facts.md)
- Subtopic structure:
  - [Problems](ai-problem-resolution/ai-problem-resolution-problems/) (7 findings)
  - [Root Causes](ai-problem-resolution/ai-problem-resolution-root-causes/) (4+ findings of root cause analysis)
  - [Solutions History](ai-problem-resolution/ai-problem-resolution-solutions-history/) (38+ catalog entries)
  - [External Evidence](ai-problem-resolution/ai-problem-resolution-external-evidence/) (9 findings on vibe coding, Replit incident, research)
  - [Agent Issues](ai-problem-resolution/ai-problem-resolution-agent-issues/) (emerging subtopic)

**Research Areas:**
- AI Programming Problems (5 endemic + 2 evolving-solution problems)
- Root Causes of AI Problems (4 root causes: hallucination, dishonesty, amnesia, overeagerness + context poisoning cross-effect)
- Solutions Catalog (38+ solutions tracking)
- External Evidence & Academic Context (9 findings on vibe coding definition, production incidents, QA statistics)
- Agent & Agentic System Issues (emerging research area)

**Key Concepts:**
- Hallucination — AI generating plausible but incorrect information not grounded in sources
- Dishonesty — AI falsely claiming correctness, completion, or knowledge states
- Context Poisoning — Cumulative effect where errors compound across conversation turns without being properly invalidated
- Vibe Coding — Fast-paced development driven by AI suggestions without rigorous verification
- Overeagerness — AI taking control away from users by acting on unverified inference of user intent

---

### analysis-concepts

**Knowledge Summary:**

Foundational research on term definition standards and semantic indexing methodology for analysis workflows. Covers the theoretical basis for fine-grained semantic term extraction, utility of terms in knowledge base organization, and practical application of term-based indexing for fact discovery.

**Quick Links:**
- Full index: [analysis-concepts-index.md](analysis-concepts/analysis-concepts-index.md)
- Main facts: [analysis-concepts-facts.md](analysis-concepts/analysis-concepts-facts.md)
- Log: [analysis-concepts-log.md](analysis-concepts/analysis-concepts-log.md)

**Research Areas:**
- Term Definition Standards (1 finding)
- Semantic Indexing Utility (2 findings)

**Key Concepts:**
- Fine-grained Semantic Term — Single concept with narrow, clearly-bounded scope
- Term Authority — Primary authoritative source defining the term
- Referenced By — Usage locations where term appears in findings

---

## Central Index Maintenance Log

| Date | Topic | Action | Details |
|---|---|---|---|
| 2026-03-23 | All | KNOWLEDGE_BASE.md created | Initial central index created with all 3 topics, quick search guide, and maintenance protocol |
| 2026-03-23 | github-api | Knowledge Summary added | Verified github-api index has complete data; summary reflects actual findings and verification status |
| 2026-03-23 | ai-problem-resolution | Knowledge Summary added | Complex multi-subtopic topic; summary aggregates findings across subtopics |
| 2026-03-23 | analysis-concepts | Knowledge Summary added | Nascent topic; summary reflects current 3 findings awaiting verification |

---
