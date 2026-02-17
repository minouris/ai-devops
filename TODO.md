# Project TODOs

## Documentation Utility

Implement the documentation utility tool for automated documentation operations.

**Design**: See [design/docutil-design.md](design/docutil-design.md)

**Key Commands**:
- `docutil renumber-sections <file>` - Renumber headings and update references
- `docutil renumber-documents <directory>` - Renumber document prefixes
- `docutil add-toc <file>` - Generate/update Table of Contents
- `docutil add-navigation <file>` - Add navigation elements

**Technology**: Python with command framework (spafw37 or similar)
