# Dex CLI - Project Roadmap & Status

## Current Status

**Version:** 0.0.2
**Status:** Active Development & Foundation Complete
**Repository:** https://github.com/thanhphamtrung/dex_cli
**Fork Origin:** jonataslaw/get_cli

## Project Phases

### Phase 1: Riverpod + Clean Architecture Foundation (✓ Complete)

**Status:** COMPLETE
**Version Range:** 0.0.1 - 0.0.2

**Description:** Fork from get_cli and rewrite for Riverpod + Clean Architecture ecosystem.

#### Achievements
- [x] Command pattern architecture (inherited from get_cli)
- [x] Project creation with Riverpod Clean Architecture
- [x] Feature module generation (all 3 layers: data, domain, presentation)
- [x] Entity generation (Freezed domain entities)
- [x] Model generation (Freezed DTO models with JSON serialization)
- [x] Use case generation
- [x] Riverpod provider generation (with @riverpod annotation)
- [x] Datasource generation
- [x] Repository generation (interface + implementation)
- [x] Page generation (ConsumerWidget)
- [x] Model generation from JSON (Freezed support)
- [x] Localization generation
- [x] Package management (install/remove)
- [x] Import sorting & formatting
- [x] Build runner integration (`dex build`, `dex watch`)
- [x] 8-language i18n support
- [x] Self-update mechanism
- [x] Configuration via pubspec.yaml (dex_cli section)

#### Key Metrics
- 96 Dart files
- 8,401 LOC (lib only)
- Riverpod-first code generation
- Clean Architecture layer separation enforced

---

### Phase 2: Test Coverage & Quality (Planned)

**Status:** PLANNED
**Target Version:** 0.1.0+

#### Planned Improvements
- [ ] Increase unit test coverage (current: ~0.01%)
- [ ] Add integration tests for command execution
- [ ] Automated testing in CI/CD pipeline
- [ ] Code coverage reporting (target: >80%)
- [ ] Performance benchmarking
- [ ] Test all Riverpod provider generation scenarios
- [ ] Test Freezed entity/model generation

#### Acceptance Criteria
- [ ] All commands have unit tests (focus: create feature, create entity, create model)
- [ ] Happy path + error scenarios covered
- [ ] CI/CD runs tests on each PR
- [ ] Coverage report in README
- [ ] Code generation tests verify @riverpod and Freezed annotations

#### Estimated Effort
- 2-3 weeks (estimated 20-30 test files)
- Focus: Commands, file operations, JSON generation, Freezed + Riverpod code generation

---

### Phase 3: Enhanced Code Generation & Developer Experience (Planned)

**Status:** PLANNED
**Target Version:** 0.1.0 - 0.2.0

#### Planned Features

##### Enhanced Riverpod Provider Generation
- [ ] Auto-generate multiple provider types (StateNotifier, AsyncNotifier, etc.)
- [ ] Support for provider dependencies and watchers
- [ ] Generate provider tests automatically
- [ ] Support for scoped providers

##### Improved Code Quality
- [ ] Add comprehensive documentation comments to generated classes
- [ ] Support for copyWith methods on Freezed models
- [ ] Null safety validation and enforcement
- [ ] Auto-import organization

##### Freezed Model Enhancements
- [ ] Support for union types in models
- [ ] Support for custom decorators on Freezed classes
- [ ] Better JSON serialization control
- [ ] Support for sealed classes

##### Custom Templates Support
- [ ] Allow users to define custom entity/model templates
- [ ] Store templates in project (`.dex_cli/templates/`)
- [ ] Support template variables and Dart code generation
- [ ] CLI command: `dex create entity:user with template-name on feature`

#### Acceptance Criteria
- [ ] Enhanced providers fully functional
- [ ] Generated code includes comprehensive documentation
- [ ] All provider variations supported
- [ ] Custom templates work as expected
- [ ] Examples in README

#### Estimated Effort
- 4-6 weeks
- Requires: Template engine, documentation generation, Riverpod provider analysis

---

### Phase 4: Backup & Recovery System (Planned)

**Status:** PLANNED
**Target Version:** 0.2.0 - 0.3.0

#### Planned Features
- [ ] Auto-backup before file operations (create feature, create entity, etc.)
- [ ] Manual backup command: `dex backup`
- [ ] Restore command: `dex restore [backup-name]`
- [ ] Backup configuration (retention policy, max size)
- [ ] Diff viewer: `dex diff [backup-name]`
- [ ] Rollback support for failed code generation

#### Implementation Details
```
~/.dex_cli/backups/
├── 2026-03-16-145200-create-feature-auth/
│   ├── metadata.json
│   ├── files/
│   │   ├── lib_features_auth_domain_entities.dart
│   │   └── ...
│   └── changes.json
```

#### Acceptance Criteria
- [ ] Automatic backups created before destructive operations
- [ ] Easy recovery of previous versions
- [ ] Backup cleanup respects retention policy
- [ ] Clear diff between versions
- [ ] Rollback available for failed operations

#### Estimated Effort
- 2-3 weeks
- Depends on: File operations refactoring

---

### Phase 5: Template Marketplace (Planned)

**Status:** PLANNED
**Target Version:** 0.3.0 - 0.4.0

#### Planned Features
- [ ] Template registry/marketplace for Riverpod + Clean Architecture
- [ ] Community templates for features, entities, providers
- [ ] Download & install custom templates
- [ ] Share own templates
- [ ] Version management for templates
- [ ] Template validation and testing

#### Architecture
```
CLI ↔ Template Registry API
├─ Search: dex template search --type=feature
├─ Install: dex template install user/auth-feature-template
├─ Publish: dex template publish ./my-template
└─ List: dex template list --installed
```

#### Acceptance Criteria
- [ ] Template registry API designed for Riverpod architectures
- [ ] CLI commands implemented
- [ ] Community templates available
- [ ] Authentication/authorization for publishing
- [ ] Template validation ensures Riverpod + Clean Architecture compliance

#### Estimated Effort
- 6-8 weeks
- Requires: Backend API, authentication, template validation

---

### Phase 6: IDE Plugin Support (Planned)

**Status:** PLANNED
**Target Version:** 0.5.0+

#### Planned Features
- [ ] VS Code extension
- [ ] Android Studio plugin
- [ ] IntelliJ IDEA plugin
- [ ] Right-click context menus for Riverpod + Clean Architecture
- [ ] Integrated feature creation wizard

#### IDE Features
- New feature via context menu
- Create entity/model/usecase/provider from menu
- Generate Freezed model from JSON file
- Format & sort imports
- Project structure visualization (Riverpod layers)
- Code generation status monitoring (`dex build/watch`)

#### Acceptance Criteria
- [ ] VS Code extension published on marketplace
- [ ] Smooth integration with IDE UI
- [ ] Command palette support for Dex CLI commands
- [ ] Keybinding customization
- [ ] Riverpod + Clean Architecture-aware code generation

#### Estimated Effort
- 8-12 weeks per IDE
- Requires: IDE SDK knowledge, UI/UX design, Riverpod awareness

---

## Priority Matrix

| Feature | Priority | Impact | Effort | Status |
|---------|----------|--------|--------|--------|
| Test Coverage | HIGH | Quality | Medium | In Progress |
| Custom Models | MEDIUM | Flexibility | High | Planned |
| Backup System | MEDIUM | Safety | Medium | Planned |
| IDE Plugins | LOW | Accessibility | High | Planned |
| Template Marketplace | LOW | Community | High | Planned |

## Known Issues & Limitations

### Critical Issues
- **Limited Test Coverage:** Only 1 test file, ~0.01% coverage
  - Impact: High (quality assurance)
  - Solution: Implement Phase 2

### Medium Priority Issues
- **Generated Code Quality:** Could include more documentation and Riverpod best practices
  - Impact: Medium (developer experience)
  - Solution: Implement Phase 3

- **No Backup Before File Operations:** Risk of data loss during code generation
  - Impact: Medium (user safety)
  - Solution: Implement Phase 4

- **Build Runner Integration Manual:** Code generation requires manual `dex build` command
  - Impact: Medium (developer friction)
  - Workaround: Instructions in generated README
  - Solution: Auto-detect missing build and suggest command

### Low Priority Issues
- **No Custom Template Support:** Users limited to default Riverpod + Clean Architecture templates
  - Impact: Low (advanced users)
  - Solution: Implement Phase 3

- **No IDE Integration:** Must use terminal for code generation
  - Impact: Low (convenience)
  - Solution: Implement Phase 6

## Metrics & Goals

### Development Velocity
- **Current:** ~2 major features per 6 months
- **Goal:** Maintain current pace with improved test coverage

### Code Quality
- **Current:** ~8,400 LOC, 1 test file
- **Goal Phase 2:** >80% test coverage by v0.1.0

### Community Activity
- **GitHub Stars:** Active community (check current count)
- **pub.dev Downloads:** Track monthly downloads
- **Issue Resolution:** Target <1 week response time

### User Adoption
- **Installation Method:** pub.dev primary distribution
- **Supported Platforms:** Windows, macOS, Linux
- **Target Users:** Flutter + GetX developers (~50k+ community)

## Dependencies to Monitor

| Dependency | Current | Risk | Notes |
|-----------|---------|------|-------|
| Dart SDK | >=3.0.0 | Low | Well-maintained |
| dcli | Latest | Low | Active project |
| dart_style | Latest | Low | Official package |
| http | Latest | Low | Official package |
| yaml | Latest | Low | Official package |

## Breaking Changes Policy

**Policy:** Maintain backward compatibility within major version.

### Version Scheme
- **MAJOR:** Breaking changes (rare, requires migration guide)
- **MINOR:** New features (backward compatible)
- **PATCH:** Bug fixes

### Migration Guides Required For
- Command syntax changes
- pubspec.yaml configuration changes
- Generated file structure changes
- Architecture pattern updates

## Community Contributions

### Contribution Areas
- [ ] Test implementations (high priority)
- [ ] Documentation improvements
- [ ] New architecture pattern templates
- [ ] Bug fixes
- [ ] Translation improvements (8 languages)
- [ ] Performance optimizations

### How to Contribute
1. Fork: https://github.com/thanhphamtrung/dex_cli
2. Create feature branch: `git checkout -b feature/my-feature`
3. Implement & test
4. Submit PR with description

### Review Process
- Code review by maintainers
- Test coverage verification
- Documentation updates
- Merge to master

## Success Criteria by Phase

### Phase 2 Success
- Test coverage >80%
- All commands tested
- CI/CD integration complete
- No regression in functionality

### Phase 3 Success
- Custom models fully working
- Generated code quality improved
- Documentation in generated code
- Community feedback positive

### Phase 4 Success
- Zero data loss incidents
- Users report improved confidence
- Recovery feature utilized
- Backup system performant

### Phase 5 Success
- 50+ community templates available
- Registry traffic metrics positive
- Template downloads growing
- Community engagement high

### Phase 6 Success
- IDE plugins published
- 10k+ IDE plugin installations
- Positive IDE marketplace reviews
- Developer feedback excellent

## Timeline Estimates

| Phase | Start | End | Duration | Status |
|-------|-------|-----|----------|--------|
| 1 | 2024-01 | 2026-03 | Complete | ✓ Complete (Dex CLI v0.0.2) |
| 2 | 2026-04 | 2026-06 | 2-3 months | Planned |
| 3 | 2026-07 | 2026-09 | 4-6 weeks | Planned |
| 4 | 2026-10 | 2026-12 | 2-3 weeks | Planned |
| 5 | 2027-01 | 2027-03 | 6-8 weeks | Planned |
| 6 | 2027-04 | 2027-09 | 8-12 weeks | Planned |

**Note:** Dates are estimates and may shift based on resource availability and community feedback.
**Phase 1 Notes:** Dex CLI forked from get_cli (commit 4996b7c). Foundation complete as of v0.0.2.

## Next Steps

### Immediate (Q1-Q2 2026)
1. Increase test coverage for Phase 2 (target: >80%)
2. Add integration tests for feature creation workflow
3. Test Riverpod provider generation (@riverpod code)
4. Test Freezed entity/model generation
5. Fix any reported bugs in Dex CLI
6. Improve documentation for Riverpod newcomers

### Short-term (Q2-Q3 2026)
1. Complete Phase 2 (test coverage)
2. Begin Phase 3 (enhanced code generation, custom templates)
3. Gather community feedback on Riverpod developer experience
4. Release v0.1.0 with comprehensive tests

### Medium-term (Next 6 Months)
1. Complete Phase 3 & 4
2. Release v0.2.0 (enhanced code generation)
3. Release v0.3.0 (backup system)
4. Plan Phase 5 in detail (template marketplace)

## Success Metrics by Version

### v0.0.2 (Current)
- ✓ Dex CLI released with Riverpod + Clean Architecture
- ✓ Feature module generation working
- ✓ Freezed entity/model generation working
- ✓ Riverpod provider generation working
- ✓ Build runner integration (dex build/watch)

### v0.1.0 (Target)
- Test coverage >80%
- All commands tested (feature, entity, model, provider, etc.)
- CI/CD integration complete
- No regressions in Riverpod code generation

### v0.2.0 (Target)
- Enhanced provider generation (multiple types)
- Custom template support
- Improved code documentation
- Better Freezed integration

## Feedback & Discussion

For roadmap feedback or feature requests:
- GitHub Issues: https://github.com/thanhphamtrung/dex_cli/issues
- GitHub Discussions: https://github.com/thanhphamtrung/dex_cli/discussions
- Riverpod Community Resources

---

**Last Updated:** 2026-03-16
**Roadmap Version:** 3.0 (Dex CLI - Riverpod + Clean Architecture Fork)
**Next Review:** 2026-06-16
**Current Phase:** Phase 1 Complete (v0.0.2), Phase 2 Planned
