# Get CLI Documentation

Complete documentation for the Get CLI project. Start here to understand the codebase, architecture, and development standards.

## Quick Navigation

### Getting Started
- **[README.md](../README.md)** — Project overview, installation, and quick-start commands

### Core Documentation

| Document | Purpose | Audience |
|----------|---------|----------|
| [**Project Overview**](./project-overview-pdr.md) | Vision, features, requirements, success metrics | Product managers, developers |
| [**Codebase Summary**](./codebase-summary.md) | Directory structure, module breakdown, statistics | New developers, architects |
| [**Code Standards**](./code-standards.md) | Dart conventions, naming, patterns, best practices | All developers |
| [**System Architecture**](./system-architecture.md) | Architecture patterns, data flow, design decisions | Architects, senior developers |
| [**Project Roadmap**](./project-roadmap.md) | Phases, timeline, known issues, future plans | Product team, maintainers |

## Documentation by Role

### New Developer
1. Read [README.md](../README.md) for quick start
2. Skim [Codebase Summary](./codebase-summary.md) for structure overview
3. Review [Code Standards](./code-standards.md) before writing code
4. Reference [System Architecture](./system-architecture.md) when debugging

### Contributor
1. Start with [Code Standards](./code-standards.md)
2. Review [System Architecture](./system-architecture.md) for patterns
3. Check [Project Roadmap](./project-roadmap.md) for open issues
4. Read [Project Overview](./project-overview-pdr.md) for context

### Architect/Lead
1. Read [Project Overview](./project-overview-pdr.md) for vision
2. Study [System Architecture](./system-architecture.md) in detail
3. Reference [Codebase Summary](./codebase-summary.md) for structure
4. Review [Project Roadmap](./project-roadmap.md) for planning

### Maintainer
1. Monitor [Project Roadmap](./project-roadmap.md) for status
2. Reference [Code Standards](./code-standards.md) for code reviews
3. Use [System Architecture](./system-architecture.md) for design decisions
4. Update [Codebase Summary](./codebase-summary.md) after major changes

## Documentation Structure

### project-overview-pdr.md (220 lines)
**What:** Product requirements and vision
**Covers:**
- Executive summary
- Target audience & features
- Architecture patterns
- Technical requirements
- Installation & configuration
- Future roadmap (6 phases)

### codebase-summary.md (294 lines)
**What:** Codebase structure and modules
**Covers:**
- Repository statistics (96 files, 8,401 LOC)
- Directory breakdown with LOC per module
- Module descriptions (Commands, Common, Core, Functions, Samples)
- Key classes and patterns
- Dependency graph
- Testing status (coverage assessment)

### code-standards.md (487 lines)
**What:** Development standards and conventions
**Covers:**
- Dart style guidelines
- Naming conventions (files, classes, functions)
- Code patterns (5 patterns)
- Error handling & logging
- File operations & configuration
- Testing conventions
- Security guidelines
- Code review checklist

### system-architecture.md (471 lines)
**What:** Design patterns and data flows
**Covers:**
- High-level architecture (ASCII diagram)
- Command pattern implementation
- Module interaction flows
- Data flow diagrams (5 major flows)
- Architectural patterns (5 patterns)
- Error handling strategy
- i18n architecture
- Extension system
- Performance characteristics

### project-roadmap.md (377 lines)
**What:** Project phases, timeline, and future plans
**Covers:**
- Current status (v1.9.1)
- 6 planned phases with timelines
- Known issues & limitations
- Success criteria
- Dependencies & breaking changes
- Community contribution areas
- Next steps (immediate, short-term, medium-term)

## Key Statistics

- **Total Documentation:** 2,097 lines (5 files)
- **Largest File:** code-standards.md (487 lines)
- **Codebase Size:** 8,401 LOC (lib only, 96 files)
- **Test Coverage:** ~0.01% (1 test file)
- **Languages Supported:** 8 (English, Portuguese BR, Chinese, German, French, Italian, Arabic, Turkish)

## Important Links

- **Repository:** https://github.com/jonataslaw/get_cli
- **pub.dev:** https://pub.dev/packages/get_cli
- **GetX Framework:** https://github.com/jonataslaw/getx

## Maintenance

Documentation is maintained alongside code changes. When implementing features:

1. Update relevant doc section
2. Verify examples still work
3. Update roadmap status
4. Add migration guides for breaking changes

Last Updated: 2026-03-16

---

**Need help?** Check [Code Standards](./code-standards.md#code-documentation) for code comment guidelines or create an issue in the repository.
