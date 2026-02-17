# Documentation Utility Design

## Table of Contents

- [Overview](#overview)
- [Purpose and Rationale](#purpose-and-rationale)
- [Architecture](#architecture)
  - [Command Framework](#command-framework)
  - [Shared Components](#shared-components)
  - [Command Structure](#command-structure)
- [Commands](#commands)
  - [Renumber Sections](#renumber-sections)
  - [Renumber Documents](#renumber-documents)
  - [Add Table of Contents](#add-table-of-contents)
  - [Add Navigation](#add-navigation)
- [Implementation Approach](#implementation-approach)
  - [Technology Choices](#technology-choices)
  - [Error Handling](#error-handling)
  - [Validation](#validation)
- [Future Enhancements](#future-enhancements)

## Overview

The documentation utility (docutil) is a command-line tool designed to automate common documentation operations for design documents. It provides commands for renumbering sections, generating tables of contents, and adding navigation elements, ensuring consistency with established documentation standards.

[↑ Back to Top](#table-of-contents)

## Purpose and Rationale

### Problem Statement

Design documents require consistent formatting, numbering, and navigation elements as defined in the project's documentation standards. Manual maintenance of these elements is error-prone and time-consuming, particularly when:

- Sections are added, removed, or reordered, requiring renumbering
- Cross-references need updating after renumbering
- Table of Contents entries must stay synchronized with headings
- Navigation links need consistent formatting across all documents

### Solution Approach

A unified command-line utility addresses these challenges by:

- Automating repetitive formatting and numbering tasks
- Ensuring consistency with regex-validated standards
- Reducing human error in cross-reference maintenance
- Enabling quick updates when document structure changes

### Benefits

- **Consistency**: All documents follow the same standards automatically
- **Efficiency**: Bulk operations on multiple documents
- **Accuracy**: Automated validation prevents formatting errors
- **Maintainability**: Single codebase for all documentation operations

[↑ Back to Top](#table-of-contents)

## Architecture

### Command Framework

The utility uses a command-based architecture where each operation is implemented as a subcommand. The spafw37 framework (or similar) provides:

- Command routing and argument parsing
- Shared context across commands
- Consistent error handling
- Help text generation

### Shared Components

Common functionality shared across commands includes:

- **Markdown Parser**: Extracts headings, links, and structure from markdown files
- **Anchor Generator**: Converts section titles to valid markdown anchors (lowercase, hyphens)
- **Link Validator**: Verifies internal links point to valid anchors
- **File Handler**: Manages file reading, writing, and backup operations
- **Pattern Matcher**: Applies regex patterns from documentation standards

### Command Structure

Each command follows a consistent pattern:

1. Parse input arguments (file paths, options)
2. Read and validate input files
3. Parse markdown structure
4. Apply transformations
5. Validate output against standards
6. Write results (with backup of originals)

[↑ Back to Top](#table-of-contents)

## Commands

### Renumber Sections

**Purpose**: Renumber all section headings within a document and update internal references.

**Operation**:
- Parse all markdown headings (H1 through H6)
- Assign sequential section numbers starting from x.1 (where x is document section)
- Maintain hierarchical structure (x.1, x.1.1, x.1.1.1)
- Update all internal references to use new section numbers
- Update anchor IDs in links

**Validation**:
- Verify sequential numbering without gaps
- Confirm all internal references point to valid sections
- Check section numbers match patterns from section-numbering.md rules

[↑ Back to Top](#table-of-contents)

### Renumber Documents

**Purpose**: Renumber document filename prefixes within a directory and update cross-document references.

**Operation**:
- Scan directory for numbered documents (01-name.md format)
- Assign sequential document numbers
- Rename files with new prefixes
- Update all cross-document references across the directory
- Maintain relative paths in links

**Validation**:
- Verify all cross-references resolve to existing files
- Check filename patterns match standards
- Confirm no broken links after renumbering

[↑ Back to Top](#table-of-contents)

### Add Table of Contents

**Purpose**: Generate and insert a Table of Contents listing all H2 and H3 headings.

**Operation**:
- Parse document to extract H2 and H3 headings
- Generate markdown list with links to anchors
- Insert or update ToC immediately after H1 heading
- Create proper anchor IDs (lowercase, hyphens, section numbers)

**Validation**:
- Verify ToC appears after H1 heading
- Check all ToC links point to valid anchors
- Confirm format matches navigation standards

[↑ Back to Top](#table-of-contents)

### Add Navigation

**Purpose**: Insert navigation elements including "Back to Top" links and document series navigation.

**Operation**:
- Add "Back to Top" links at end of all H2 and H3 sections
- For document series: add header navigation before H1
- For document series: add footer navigation with "See Also" section
- Detect if document is part of a series based on directory structure

**Validation**:
- Verify "Back to Top" links present in all sections
- Check navigation link format matches standards
- Confirm series navigation includes all required elements

[↑ Back to Top](#table-of-contents)

## Implementation Approach

### Technology Choices

**Language**: Python 3.8+
- Robust text processing capabilities
- Rich ecosystem of markdown parsing libraries
- Better suited for file manipulation than bash
- Cross-platform compatibility

**Framework**: spafw37 or similar command framework
- Provides command routing and argument parsing
- Enables shared context across commands
- Simplifies help text and error handling

**Markdown Parsing**: Python-Markdown or mistletoe
- Parse markdown to AST for structure analysis
- Extract headings, links, and content
- Generate valid markdown output

### Error Handling

The utility implements defensive error handling:

- **Backup originals**: Create .bak files before modifications
- **Dry-run mode**: Preview changes without writing files
- **Validation errors**: Report specific issues with line numbers
- **Rollback capability**: Restore from backup on failure

### Validation

Each command validates both input and output:

- **Pre-validation**: Check input files match expected format
- **Post-validation**: Verify output conforms to standards
- **Pattern matching**: Apply regex patterns from rule files
- **Link validation**: Ensure all references resolve correctly

[↑ Back to Top](#table-of-contents)

## Future Enhancements

Potential additions to the utility include:

**Validate Command**: Check documents against all standards without modifications

**Fix Command**: Automatically correct common formatting issues

**Extract Command**: Generate reports showing document structure and cross-references

**Template Command**: Create new documents from templates with proper structure

**Batch Mode**: Apply operations to multiple documents in parallel

**Reference Item Commands**: Validate reference item format and generate traceability matrices

These enhancements would expand the utility's capabilities while maintaining the unified command-based architecture.

[↑ Back to Top](#table-of-contents)
