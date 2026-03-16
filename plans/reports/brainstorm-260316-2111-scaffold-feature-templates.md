# Brainstorm: Feature Templates for Dex CLI

**Date:** 2026-03-16
**Status:** Decided — Theme/Settings first

## Problem
Every Flutter+Riverpod project needs auth, notifications, theming. First 2-3 hours spent wiring same boilerplate. Dex CLI currently only generates structural templates (entity, model, usecase) — no pre-built feature logic.

## User Decisions
- **Template type:** Feature templates (pre-built business logic across all Clean Architecture layers)
- **Audience:** Solo/small team devs — opinionated is fine
- **Interested features:** Auth, FCM, Theme/Settings, Onboarding
- **Maintenance:** User committed to maintaining templates as packages evolve
- **UX:** Interactive wizard (`dex scaffold`)
- **Priority:** Theme/Settings only for now

## Evaluated Approaches

### Option A: All 4 templates at once ❌
- High risk, massive scope, maintenance nightmare
- Would delay release significantly

### Option B: Auth first ❌
- Highest value but highest complexity
- Firebase dependency = maintenance burden from day 1
- Platform-specific concerns

### Option C: Theme/Settings first ✅ (Chosen)
- Zero external deps beyond SharedPreferences
- Establishes `dex scaffold` command pattern
- Low maintenance, quick win
- Proves the feature template architecture before tackling complex features

## Recommended Solution

### Command: `dex scaffold`
New top-level command, separate from `create feature`. Interactive wizard prompts user.

### Theme/Settings Template Generates:
- `lib/features/theme/` — full Clean Architecture feature
  - data/: ThemeRepository impl, SharedPreferences datasource
  - domain/: ThemeEntity, ThemeRepository interface, usecases
  - presentation/: ThemeProvider (@riverpod), SettingsPage
- Dark/light mode toggle
- Theme persistence via SharedPreferences
- Riverpod provider for app-wide theme state

### Key Design Decisions
| Decision | Choice | Reason |
|----------|--------|--------|
| Command name | `dex scaffold` | Separates structure from feature generation |
| Package install | Auto-add to pubspec | Zero friction for solo devs |
| Opinionated? | Yes — SharedPreferences, Material 3 | Target audience wants working code |
| Platform files | Don't touch | Print instructions if needed |

## Future Templates (Backlog)
1. Auth (Firebase) — after scaffold pattern proven
2. Onboarding/Splash — low complexity
3. FCM — highest complexity, last

## Risks
- Feature templates have higher maintenance than structural templates
- Generated business logic may not fit all projects
- Scope creep: users will request more features per template

## Next Steps
- Create implementation plan for Theme/Settings scaffold template
- Implement `dex scaffold` command with interactive wizard
- Ship as part of next minor release
