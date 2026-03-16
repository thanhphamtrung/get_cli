# Get CLI - Project Roadmap & Status

## Current Status

**Version:** 1.10.0
**Status:** Active Maintenance & Feature Development
**Repository:** https://github.com/jonataslaw/get_cli

## Project Phases

### Phase 1: Foundation & Core Commands (✓ Complete)

**Status:** COMPLETE
**Version Range:** 1.0.0 - 1.9.1

#### Achievements
- [x] Command pattern architecture
- [x] Project creation (Flutter + GetX Server)
- [x] Page/Screen generation
- [x] Controller/View/Provider creation
- [x] Model generation from JSON
- [x] Localization generation
- [x] Package management (install/remove)
- [x] Import sorting & formatting
- [x] Support for GetX Pattern and CLEAN architecture
- [x] 8-language i18n support
- [x] Self-update mechanism
- [x] Configuration via pubspec.yaml

#### Key Metrics
- 96 Dart files
- 8,401 LOC (lib only)
- Active community support
- Available on pub.dev

---

### Phase 2: Test Coverage & Quality (In Progress ⚠️)

**Status:** IN PROGRESS (LOW PRIORITY)
**Target Version:** 1.10.0+

#### Planned Improvements
- [ ] Increase unit test coverage (current: ~0.01%)
- [ ] Add integration tests for command execution
- [ ] Automated testing in CI/CD pipeline
- [ ] Code coverage reporting (target: >80%)
- [ ] Performance benchmarking

#### Acceptance Criteria
- [ ] All commands have unit tests
- [ ] Happy path + error scenarios covered
- [ ] CI/CD runs tests on each PR
- [ ] Coverage report in README

#### Estimated Effort
- 2-3 weeks (estimated 20-30 test files)
- Focus: Commands, file operations, JSON generation

---

### Phase 3: Enhanced Code Generation (Planned)

**Status:** PLANNED
**Target Version:** 1.11.0+

#### Planned Features

##### Custom Models Support
- [ ] Allow users to define custom model templates
- [ ] Store templates in project (`.get_cli/templates/`)
- [ ] Support template variables and functions
- [ ] CLI command: `get create model:user with template-name`

##### Improved Generated Code
- [ ] Add documentation comments to generated classes
- [ ] Support for equatable equality
- [ ] Add copyWith methods to models
- [ ] Null safety improvements
- [ ] Support for factory constructors

##### Provider Enhancements
- [ ] Auto-generate provider with model
- [ ] Support multiple provider types (GetxController, GetConnect, etc.)
- [ ] Service locator pattern templates
- [ ] Dependency injection helpers

#### Acceptance Criteria
- [ ] Custom templates fully functional
- [ ] Generated code includes documentation
- [ ] All provider variations supported
- [ ] Examples in README

#### Estimated Effort
- 4-6 weeks
- Requires: Template engine, documentation generation, provider refactoring

---

### Phase 4: Backup & Recovery System (Planned)

**Status:** PLANNED
**Target Version:** 1.12.0+

#### Planned Features
- [ ] Auto-backup before file operations
- [ ] Manual backup command: `get backup`
- [ ] Restore command: `get restore [backup-name]`
- [ ] Backup configuration (retention policy, max size)
- [ ] Diff viewer: `get diff [backup-name]`

#### Implementation Details
```
~/.get_cli/backups/
├── 2026-03-16-145200-create-page-home/
│   ├── metadata.json
│   ├── files/
│   │   ├── lib_modules_home_binding.dart
│   │   └── ...
│   └── changes.json
```

#### Acceptance Criteria
- [ ] Automatic backups created before destructive operations
- [ ] Easy recovery of previous versions
- [ ] Backup cleanup respects retention policy
- [ ] Clear diff between versions

#### Estimated Effort
- 2-3 weeks
- Depends on: File operations refactoring

---

### Phase 5: Template Marketplace (Planned)

**Status:** PLANNED
**Target Version:** 1.13.0+

#### Planned Features
- [ ] Template registry/marketplace
- [ ] Community templates for projects, pages, screens
- [ ] Download & install custom templates
- [ ] Share own templates
- [ ] Version management for templates

#### Architecture
```
CLI ↔ Template Registry API
├─ Search: get template search --type=page
├─ Install: get template install user/page-template
├─ Publish: get template publish ./my-template
└─ List: get template list --installed
```

#### Acceptance Criteria
- [ ] Template registry API designed
- [ ] CLI commands implemented
- [ ] Community templates available
- [ ] Authentication/authorization for publishing

#### Estimated Effort
- 6-8 weeks
- Requires: Backend API, authentication, template validation

---

### Phase 6: IDE Plugin Support (Planned)

**Status:** PLANNED
**Target Version:** 2.0.0+

#### Planned Features
- [ ] VS Code extension
- [ ] Android Studio plugin
- [ ] IntelliJ IDEA plugin
- [ ] Right-click context menus
- [ ] Integrated project creation wizard

#### IDE Features
- New page/screen via context menu
- Create controller/view from menu
- Generate model from JSON file
- Format & sort imports
- Project structure visualization

#### Acceptance Criteria
- [ ] VS Code extension published on marketplace
- [ ] Smooth integration with IDE UI
- [ ] Command palette support
- [ ] Keybinding customization

#### Estimated Effort
- 8-12 weeks per IDE
- Requires: IDE SDK knowledge, UI/UX design

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
- **Generated Code Quality:** Could include more documentation
  - Impact: Medium (developer experience)
  - Solution: Implement Phase 3

- **No Backup Before File Operations:** Risk of data loss
  - Impact: Medium (user safety)
  - Solution: Implement Phase 4

### Low Priority Issues
- **No Custom Model Support:** Users stuck with template generation
  - Impact: Low (advanced users)
  - Solution: Implement Phase 3

- **No IDE Integration:** Must use terminal
  - Impact: Low (convenience)
  - Solution: Implement Phase 6

## Metrics & Goals

### Development Velocity
- **Current:** ~2 major features per 6 months
- **Goal:** Maintain current pace with improved test coverage

### Code Quality
- **Current:** ~8,400 LOC, 1 test file
- **Goal Phase 2:** >80% test coverage by v1.10.0

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
1. Fork: https://github.com/jonataslaw/get_cli
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
| 1 | Early 2024 | 2025-03 | Complete | ✓ Complete |
| 2 | 2025-04 | 2025-07 | 3-4 months | ⚠️ In Progress |
| 3 | 2025-08 | 2025-11 | 4-6 weeks | Planned |
| 4 | 2025-12 | 2026-02 | 2-3 weeks | Planned |
| 5 | 2026-03 | 2026-07 | 6-8 weeks | Planned |
| 6 | 2026-08 | 2027-03 | 8-12 weeks | Planned |

**Note:** Dates are estimates and may shift based on resource availability and community feedback.

## Next Steps

### Immediate (This Quarter)
1. Increase test coverage for Phase 2
2. Add integration tests for critical paths
3. Fix any reported bugs
4. Update documentation

### Short-term (Next Quarter)
1. Complete Phase 2 (test coverage)
2. Begin Phase 3 (custom models)
3. Gather community feedback on priorities
4. Release v1.10.0 with tests

### Medium-term (Next 6 Months)
1. Complete Phase 3 & 4
2. Release v1.11.0 (custom models)
3. Release v1.12.0 (backup system)
4. Plan Phase 5 in detail

## Feedback & Discussion

For roadmap feedback or feature requests:
- GitHub Issues: https://github.com/jonataslaw/get_cli/issues
- GitHub Discussions: https://github.com/jonataslaw/get_cli/discussions
- Discord: GetX community server

---

**Last Updated:** 2026-03-16
**Roadmap Version:** 2.0
**Next Review:** 2026-06-16
