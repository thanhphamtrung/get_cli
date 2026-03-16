import 'dart:io';

import '../../../../common/utils/logger/log_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../samples/impl/scaffold/scaffold_samples.dart';
import '../../../interface/command.dart';

/// Scaffolds Material 3 theme with Riverpod dark/light toggle and design tokens.
///
/// Usage: `dex scaffold theme`
///
/// Generates 3 files in lib/core/theme/:
///   app_theme.dart        — ThemeData light+dark with ColorScheme.fromSeed
///   theme_provider.dart   — @riverpod notifier with SharedPreferences persistence
///   theme_constants.dart  — AppSpacing, AppBorderRadius, AppElevation tokens
///
/// Also installs shared_preferences and prints main.dart wiring instructions.
class ScaffoldThemeCommand extends Command {
  @override
  String get commandName => 'theme';

  @override
  Future<void> execute() async {
    // Pre-flight: ensure this is a Riverpod project
    final pubspec = File('pubspec.yaml');
    if (pubspec.existsSync() &&
        !pubspec.readAsStringSync().contains('riverpod_annotation')) {
      LogService.error(
          'riverpod_annotation not found in pubspec.yaml. '
          'Run "dex init" first or add riverpod_annotation manually.');
      return;
    }

    final themePath = 'lib/core/theme';

    // Check if theme already exists
    if (Directory(themePath).existsSync()) {
      LogService.error(
          'Theme already exists at $themePath. '
          'Delete it first if you want to re-scaffold.');
      return;
    }

    LogService.info('Scaffolding Material 3 theme …');

    // Create directory
    Directory(themePath).createSync(recursive: true);

    // Generate 3 theme files
    ScaffoldThemeConstantsSample(path: '$themePath/theme_constants.dart')
        .create(skipFormatter: true);
    ScaffoldThemeAppThemeSample(path: '$themePath/app_theme.dart')
        .create(skipFormatter: true);
    ScaffoldThemeProviderSample(path: '$themePath/theme_provider.dart')
        .create(skipFormatter: true);

    // Install shared_preferences
    await ShellUtils.addPackage('shared_preferences');

    LogService.success('Theme scaffolded with 3 files in $themePath');

    // Print main.dart wiring instructions
    LogService.info('');
    LogService.info('┌─ Next: wire theme into MaterialApp ─────────────────┐');
    LogService.info('│                                                      │');
    LogService.info("│  import 'core/theme/app_theme.dart';                 │");
    LogService.info("│  import 'core/theme/theme_provider.dart';            │");
    LogService.info('│                                                      │');
    LogService.info('│  final themeMode = ref.watch(themeProvider);  │');
    LogService.info('│                                                      │');
    LogService.info('│  MaterialApp.router(                                 │');
    LogService.info('│    theme: AppTheme.light,                            │');
    LogService.info('│    darkTheme: AppTheme.dark,                         │');
    LogService.info('│    themeMode: themeMode,                             │');
    LogService.info('│    …                                                 │');
    LogService.info('│  )                                                   │');
    LogService.info('└──────────────────────────────────────────────────────┘');

    // Run build_runner for @riverpod code generation
    if (!flags.contains('--no-build')) {
      await ShellUtils.buildRunner();
    }
  }

  @override
  List<String> get acceptedFlags => ['--no-build'];

  @override
  String? get hint =>
      'Scaffold Material 3 theme with dark/light mode & design tokens';

  @override
  String get codeSample => 'dex scaffold theme';

  @override
  int get maxParameters => 0;
}
