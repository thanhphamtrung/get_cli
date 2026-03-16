import 'package:process_run/shell_run.dart';

import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/log_utils.dart';

class ShellUtils {
  static Future<void> pubGet() async {
    LogService.info('Running `flutter pub get` …');
    await run('dart pub get', verbose: true);
  }

  static Future<void> addPackage(String package) async {
    LogService.info('Adding package $package …');
    await run('dart pub add $package', verbose: true);
  }

  static Future<void> removePackage(String package) async {
    LogService.info('Removing package $package …');
    await run('dart pub remove $package', verbose: true);
  }

  static Future<void> flutterCreate(
    String path,
    String? org,
  ) async {
    LogService.info('Running `flutter create $path` …');

 // Note: -i and -a flags are only supported for --template=plugin
 // For regular Flutter projects, Flutter uses Swift/Kotlin by default 
   await run( 
       'flutter create --no-pub --org $org "$path"', 
        verbose: true);
  }

  static Future<void> update(
      [bool isGit = false, bool forceUpdate = false]) async {
    isGit = DexCli.arguments.contains('--git');
    forceUpdate = DexCli.arguments.contains('-f');

    // Version check is skipped — dex_cli is not published to pub.dev.
    // When published, re-enable the pub.dev version comparison here.

    LogService.info('Upgrading dex_cli …');

    try {
      if (isGit) {
        await run(
            'dart pub global activate -sgit https://github.com/nickeflame/dex_cli',
            verbose: true);
      } else {
        await run('dart pub global activate dex_cli', verbose: true);
      }
      return LogService.success(LocaleKeys.sucess_update_cli.tr);
    } on Exception catch (err) {
      LogService.info(err.toString());
      return LogService.error(LocaleKeys.error_update_cli.tr);
    }
  }
}
