---
status: pending
created: 2026-03-16
slug: dex-cli-riverpod-clean-arch
description: Fork get_cli into dex — Flutter Clean Architecture + Riverpod scaffolding CLI
---

# Plan: `dex` CLI — Flutter Clean Architecture + Riverpod Scaffolding

## Overview

Fork get_cli → `dex`. Strip GetX, rebuild with Riverpod + Clean Architecture (Reso Coder feature-first). Internal team tool. Full scaffolding.

## Context Reports
- [Brainstorm](../reports/brainstorm-260316-1524-dex-cli-riverpod-clean-arch.md)
- [Riverpod Research](../reports/researcher-260316-1525-riverpod-clean-arch-research.md)
- [GetX Audit](../reports/Explore-260316-1442-getx-pattern-analysis.md)

## Key Decisions
- CLI binary: `dex` | Package: `dex_cli`
- Riverpod + `@riverpod` code generation (NEVER manual Provider())
- Reso Coder feature-first Clean Architecture
- GoRouter with Riverpod auth guards
- Hardcoded Dart string templates
- Stack: flutter_riverpod, riverpod_annotation, riverpod_generator, dio, go_router, freezed, json_serializable, fpdart, pretty_dio_logger, envied, flutter_secure_storage, shared_preferences

## Phases

| # | Phase | Status | Priority | Effort |
|---|-------|--------|----------|--------|
| 1 | [Rebrand & Strip GetX](phase-01-rebrand-strip-getx.md) | completed | P0 | Medium |
| 2 | [Core Templates](phase-02-core-templates.md) | completed | P0 | High |
| 3 | [Feature Scaffolding](phase-03-feature-scaffolding.md) | completed | P0 | High |
| 4 | [Route Management](phase-04-route-management.md) | completed | P1 | Medium |
| 5 | [Model Generation (Freezed)](phase-05-model-generation-freezed.md) | completed | P1 | Medium |
| 6 | [Build Runner Commands](phase-06-build-runner-commands.md) | completed | P2 | Low |
| 7 | [Polish & Testing](phase-07-polish-testing.md) | pending | P2 | Medium |

## Dependencies
```
Phase 1 (rebrand) → Phase 2 (core templates) → Phase 3 (feature scaffolding)
                                               → Phase 4 (route management)
Phase 2 → Phase 5 (model generation)
Phase 3 + Phase 4 → Phase 6 (build runner)
All → Phase 7 (polish)
```

## Codebase Impact Summary
- **56 files** require changes
- **38 files** kept unchanged (utilities, JSON parser, etc.)
- **11 files** to remove (GetX-specific)
- **~20 new files** to create (Riverpod templates + new commands)
