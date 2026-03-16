---
name: Flutter/Dart/GetX Compatibility Update Plan
description: Comprehensive plan to update get_cli v1.9.1 for current ecosystem compatibility
type: plan-summary
date: 2026-03-16
---

# Plan Summary: get_cli Flutter/Dart/GetX Compatibility Update

## Plan Location
`/Users/thanhpham/Documents/1-projects/personal/get_cli/plans/260316-1349-flutter-compat-update/`

## Scope
5 phases, ~8h total effort. Updates get_cli from v1.9.1 to v1.10.0 with full Dart 3.11+ / Flutter 3.41+ compatibility.

## Key Findings from Research

1. **dcli waitFor is NOT a blocker** -- dcli 6.1.2 already switched to `native_synchronization_temp`, compiles and runs on Dart 3.11.1
2. **dart_style 3.x** is the most impactful change -- `DartFormatter()` constructor now requires language version param. Simple 1-line fix in 2 files.
3. **dcli 8.x** is a major version jump but get_cli only uses `menu()` and `ask()` -- 2 stable core APIs
4. **Dead code** exists from PR #294 fix -- iOS/Android language menus shown but values unused
5. **GetX 5** needs `Binding` (singular) + `Bind.lazyPut` instead of `Bindings` + `Get.lazyPut`

## Phase Overview

| # | Phase | Files | Effort | Risk |
|---|-------|-------|--------|------|
| 1 | dart_style 2.x -> 3.x | 3 files | 1.5h | Low |
| 2 | dcli 6.x -> 8.x | 2-5 files | 2.5h | Medium |
| 3 | Fix warnings + dead code | 5 files | 1h | Low |
| 4 | GetX 5 template support | 2 files | 2h | Low |
| 5 | Version bump + testing | 2 files | 1h | Low |

## Breaking Changes for Users
- **Minimum Dart SDK bumped from 3.0.0 to 3.9.0** (required by dart_style 3.x)
- Generated code formatting may differ slightly (dart_style 3.x "tall style")

## Dependency Order
```
Phase 1 (dart_style) ──┐
                       ├──> Phase 4 (GetX 5) ──> Phase 5 (release)
Phase 2 (dcli) ────────┘
Phase 3 (warnings) ─── independent, can parallel ──> Phase 5
```
