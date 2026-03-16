---
name: get_cli GitHub Issues & Community Research
description: Analysis of open issues, common errors, forks, community feedback, and compatibility challenges
type: research
date: 2026-03-16
---

# GetX CLI: GitHub Issues & Community Feedback Research

## Executive Summary

get_cli (v1.9.1) is **actively maintained** but faces significant compatibility challenges with recent Flutter/Dart versions. The package has ~110 open issues, with the most critical blockers being:
1. **Flutter 3.35+ incompatibility** (unsupported CLI flags)
2. **Dart 3.4+ breakage** (dcli's deprecated `waitFor`)
3. **Dart 3.5+ type errors** (`UnmodifiableUint8ListView` deprecation)
4. **Model generation failures** (null safety edge cases)

**Last meaningful activity:** January 2026 (PR #294 merged to fix flutter create flags). No updates since.

---

## 1. Most Common Compatibility Complaints

### Issue #293: Flutter 3.35+ Project Creation Failure [CRITICAL]
**Status:** OPEN (Oct 2025 - ongoing)
**Frequency:** Multiple duplicate reports (3+ users) through Jan 2026
**Error:**
```
The "ios-language" option is only supported for "--template=plugin"
✖  + error_unexpected ShellException(flutter create --no-pub -i swift -a kotlin ...)
```
**Root Cause:** get_cli passes `-i swift -a kotlin` flags to `flutter create`, but these flags only work with `--template=plugin`. Regular projects don't support these flags.

**Status:** FIXED in PR #294 (merged Jan 2026) - removes unsupported flags for regular projects.

### Issue #248: Dart 3.4+ Breaking Change [CRITICAL]
**Status:** OPEN (reported Mar 2024, still affecting users)
**Error:**
```
Synchronous waiting using dart:cli waitFor and C API Dart_WaitForEvent
is deprecated and disabled by default. This feature will be fully
removed in Dart 3.4 release.
```
**Root Cause:** dcli package (v6.0.5+) uses deprecated `waitFor` from dart:cli. Dart 3.4 removed this feature.
**Affected Command:** `get init` (hangs on interactive menus)
**Workaround:** Downgrade Flutter/Dart to versions before 3.4 or use community fork.

### Issue #263: Dart 3.5.0 Type Error [CRITICAL]
**Status:** CLOSED (but root cause persists)
**Error:**
```
Type 'UnmodifiableUint8ListView' not found
(from win32 package dependency)
```
**Root Cause:** Dart 3.5.0 deprecated `UnmodifiableUint8ListView`, recommending `Uint8List.unmodifiableView()` instead. Affects win32 package (used by get_cli).
**Impact:** Build failures on Dart 3.5+

### Issue #243: Flutter 3.13+ Errors [HIGH]
**Status:** OPEN (reported Jan 2024)
**Root Cause:** Combination of dcli + Flutter version incompatibilities
**Community Workaround:** Use fork from `knottx` (https://github.com/knottx/get_cli.git) - 2+ users confirmed working.

---

## 2. Specific Error Patterns Reported

### A. Project Creation Errors (25+ issues)
- **Most Common:** `flutter create` flag incompatibilities
- **Secondary:** Shell execution failures on Windows (path issues)
- **Tertiary:** Git not found errors (platform-specific)

### B. Model Generation Failures (8+ issues)
**Issue #281:** Null check operator error
```
Null check operator used on a null value at
PubspecUtils.nullSafeSupport (pubspec_utils.dart:146)
```
**Trigger:** `get generate model` with certain JSON structures
**Impact:** Blocks model generation workflow

**Issue #291:** Newline handling in locale files
```
Error generating locales with newline in messages
"Unterminated string literal" when using \n in JSON
```
**Trigger:** Multi-line messages in locale JSON files

### C. Route/Code Generation Issues (5+ issues)
**Issue #285:** Incomplete route generation after second execution
```
Routes.dart becomes invalid with parse errors after subsequent
"get create screen" commands
```
**Impact:** Broken routing structure requiring manual fixes

**Issue #274:** Model creation from JSON URL fails intermittently

---

## 3. Forks & Community Patches

### Active Community Fork: knottx
**URL:** https://github.com/knottx/get_cli.git (branch: `knottx`)
**Status:** Actively maintained as of Mar 2024
**Fixes Include:**
- dcli 6.1.x compatibility
- Model generation fixes (int/double type parsing)
- Analysis options + code formatting

**Installation:**
```bash
dart pub global deactivate get_cli
dart pub global activate -s git https://github.com/knottx/get_cli.git --git-ref knottx
```
**User Feedback:** "Works perfectly - only dependencies required updating" (confirmed Jan 2024)

### getx_cli (Third-Party Alternative)
**Type:** Community-maintained alternative CLI
**Status:** Less mature than official get_cli
**Availability:** pub.dev/packages/getx_cli
**Adoption:** Lower community adoption compared to official tool

---

## 4. Open PRs Addressing Compatibility

| PR # | Title | Status | Impact |
|------|-------|--------|--------|
| 294 | fix: remove unsupported iOS/Android language flags | MERGED (Jan 2026) | **CRITICAL FIX** - Fixes flutter create |
| 288 | feat(i18n): add translations for 8 major languages | OPEN | Localization improvements |
| 284 | Add Analysis Options and Format All Files | OPEN | Code quality |
| 283 | Fix Model Generation Error (int/double→num) | MERGED (Oct 2024) | Fixes #281-like issues |
| 275 | Support GetX5 🚀 | OPEN | Feature request (not compatibility) |
| 278, 277 | Template updates | OPEN | Minor template fixes |

**Critical Gap:** No merged PR addressing dcli's waitFor deprecation (Issue #248). This remains the largest blocker for Dart 3.4+.

---

## 5. Error Pattern Analysis Summary

### Most Critical Compatibility Issues
1. **Flutter version flags** (PR #294 merged - RESOLVED)
2. **dcli waitFor deprecation** (UNRESOLVED - blocks `get init`)
3. **dart_style/type system conflicts** (PARTIALLY RESOLVED)
4. **Null safety edge cases in model generation** (PR #283 merged)

### Dependency Graph Issues
**Current deps:**
- `dcli: >=6.0.5 <7.0.0` ← **PROBLEM:** dcli 6.x uses deprecated waitFor
- `dart_style: >=2.3.6 <3.0.0` ← Stable, no known issues
- `win32, archive, etc.` ← May have UnmodifiableUint8ListView refs

---

## 6. GetX Framework Community Sentiment

### From GetX Repository Issues
Searched jonataslaw/getx for "get_cli" mentions:
- **Issue #3366:** Android Pixel 5 errors from get_cli-generated code (Jun 2025)
- **Issue #2527:** get_cli project creation hangs (Aug 2022, unresolved)
- No significant recent discussion about get_cli in main GetX repo

### General GetX Sentiment
- **Official Statement:** "GetX has huge ecosystem, large community, large number of collaborators, will be maintained as long as Flutter exists"
- **Reality Check:** Last major GetX update required explicit statement about maintenance (suggests periods of lower activity)
- **get_cli in community:** Appreciated tool but dependency issues frequently reported

---

## 7. Alternative GetX CLI Tools

### Official Alternatives (None Active)
GetX team maintains only get_cli. No official alternative.

### Community Alternatives
1. **getx_cli** (pub.dev/packages/getx_cli)
   - Third-party tool
   - Lower adoption than official get_cli
   - Status: Maintained but not widely used

2. **Manual scaffolding** (Common Workaround)
   - Users skip `get init` and manually create projects
   - Use `get create page:home` to generate individual files
   - Bypass known waitFor issue entirely
   - Several users documented this pattern in issue comments

---

## 8. Maintenance Status Assessment

### Positive Indicators
- **PR #294 merged Jan 2026** - Shows active maintenance
- **Dependency updates** - pubspec tracks modern versions
- **Contributors:** Multiple PRs from community (knottx, noblebuildsai, etc.)
- **Version:** 1.9.1 released with Dart 3.0 constraint

### Negative Indicators
- **19-month gap** between last major activity (Jan 2026) and current date (Mar 2026)
- **Critical issue #248 unresolved** since Mar 2024 (12+ months)
- **No dcli migration** despite deprecation warnings since Dart 3.3
- **No PR for GetX5 support** despite #275 being open since Sep 2024
- **100+ unresolved issues** - backlog management appears limited

### Effective Maintenance Status
**Semi-Active:** Fixes critical blockers when reported (PR #294) but no proactive deprecation management or feature development. Reactive-only maintenance model.

---

## Key Dependency Issues

### Issue: dcli waitFor Deprecation
**Severity:** CRITICAL - affects `get init` command
**Timeline:**
- Dart 3.3: Deprecated (warnings)
- Dart 3.4: Disabled by default
- Dart 3.5+: Removed entirely (feature flag no longer works)

**dcli Status:**
- Version 6.0.5+ still uses waitFor
- dcli_core (async version) available but not used by get_cli
- dcli maintainers migrated withTempDir → withTempDirAsync but hasn't removed waitFor entirely

**Fix Required in get_cli:**
- Update dcli dependency to version that removes waitFor dependency
- Rewrite Menu/ask functionality to use async patterns
- Test with Dart 3.5+

### Issue: dart_style Stability
**Status:** GOOD - No version conflicts reported
**Current:** 2.3.6+ stable
**Note:** Earlier versions had conflicts with intl_translation, but constraint is correct

### Issue: win32 + UnmodifiableUint8ListView
**Status:** Partially resolved (win32 packages updated)
**Impact:** Reduced with recent package updates
**Workaround:** Ensure up-to-date pub dependencies

---

## Issue Severity Breakdown

### Critical (Blocks Main Workflows)
- **#293:** Project creation (FIXED Jan 2026)
- **#248:** `get init` command (UNRESOLVED)
- **#281:** Model generation null safety (FIXED Oct 2024)

### High (Breaks Secondary Features)
- **#291:** Locale generation with newlines (UNRESOLVED)
- **#285:** Incremental route generation (UNRESOLVED)
- **#263:** Dart 3.5 build errors (UNRESOLVED - package dep issue)

### Medium (Workarounds Exist)
- **#289:** lazyPut vs put in bindings (Feature request)
- **#256:** Path collision handling (Edge case)

### Low (Documentation/Nice-to-Have)
- **#273, #286:** Feature requests (rename page, delete command)
- **#238:** GetX 2.0.0 discussion (pre-release)

---

## Unresolved Questions

1. **Will dcli be updated to remove waitFor?** - No timeline given; blocks Dart 3.4+ support indefinitely
2. **Is get_cli active maintenance or dormant?** - Evidence suggests dormant with reactive fixes only
3. **Will PR #275 (GetX5 support) ever merge?** - Open 6+ months, no response
4. **Community fork (knottx) - is it maintained?** - Last activity Jan 2024, uncertain if still works with latest deps
5. **Why no proactive Flutter version testing?** - Suggests no CI/CD testing against newest Flutter versions
6. **Is migration to async-only code planned?** - No roadmap found

---

## Sources Consulted

- [get_cli GitHub Issues List](https://github.com/jonataslaw/get_cli/issues)
- [get_cli GitHub Pull Requests](https://github.com/jonataslaw/get_cli/pulls)
- [Issue #293: error when create project](https://github.com/jonataslaw/get_cli/issues/293)
- [Issue #248: dart:cli waitFor deprecation](https://github.com/jonataslaw/get_cli/issues/248)
- [Issue #243: Get_cli errors on latest flutter](https://github.com/jonataslaw/get_cli/issues/243)
- [Issue #263: UnmodifiableUint8ListView error](https://github.com/jonataslaw/get_cli/issues/263)
- [Issue #281: Null check operator error](https://github.com/jonataslaw/get_cli/issues/281)
- [Issue #291: Locale generation newline error](https://github.com/jonataslaw/get_cli/issues/291)
- [PR #294: fix iOS/Android flags](https://github.com/jonataslaw/get_cli/pull/294)
- [Community Fork: knottx](https://github.com/knottx/get_cli)
- [GetX Framework Maintenance Status](https://github.com/jonataslaw/getx/issues/3295)
- [dcli waitFor Deprecation (dcli issue #229)](https://github.com/onepub-dev/dcli/issues/229)
- [Medium: GetX CLI Tool Articles](https://kheronn-machado.medium.com/getx-cli-creating-artifacts-with-the-command-line-tool-dfc3e3c036bc)
- [C# Corner: GetX CLI Guide](https://www.c-sharpcorner.com/article/get-cli-the-ultimate-command-line-tool-for-getx-architecture-in-flutter/)

---

## Recommendations for Project Planning

**If maintaining get_cli:**
1. **Urgent:** Migrate dcli away from waitFor (use async versions or replace library)
2. **High:** Add CI/CD testing against Flutter 3.35+, Dart 3.4-3.5+
3. **High:** Merge/implement GetX5 support (PR #275)
4. **Medium:** Fix model generation edge cases (#281-like issues)
5. **Medium:** Review and close old issues (triage 100+ backlog)

**If adopting for new projects:**
- Use community fork (knottx) if on Dart 3.4+
- Or skip `get init`, manually scaffold + use `get create` for individual files
- Or use custom project template to avoid CLI entirely
