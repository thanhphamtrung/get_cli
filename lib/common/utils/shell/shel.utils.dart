import 'dart:io';

import 'package:process_run/shell_run.dart';

import '../../../core/generator.dart';
import '../../../core/internationalization.dart';
import '../../../core/locales.g.dart';
import '../logger/log_utils.dart';
import '../pub_dev/pub_dev_api.dart';
import '../pubspec/pubspec_lock.dart';

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
    if (!isGit && !forceUpdate) {
      var versionInPubDev =
          await PubDevApi.getLatestVersionFromPackage('dex_cli');

      var versionInstalled = await PubspecLock.getVersionCli(disableLog: true);

      if (versionInstalled == versionInPubDev) {
        return LogService.info(
            Translation(LocaleKeys.info_cli_last_version_already_installed.tr)
                .toString());
      }
    }

    LogService.info('Upgrading dex_cli …');

    try {
      if (Platform.script.path.contains('flutter')) {
        if (isGit) {
          await run(
              'flutter pub global activate -sgit https://github.com/jonataslaw/get_cli/',
              verbose: true);
        } else {
          await run('flutter pub global activate dex_cli', verbose: true);
        }
      } else {
        if (isGit) {
          await run(
              'flutter pub global activate -sgit https://github.com/jonataslaw/get_cli/',
              verbose: true);
        } else {
          await run('flutter pub global activate dex_cli', verbose: true);
        }
      }
      return LogService.success(LocaleKeys.sucess_update_cli.tr);
    } on Exception catch (err) {
      LogService.info(err.toString());
      return LogService.error(LocaleKeys.error_update_cli.tr);
    }
  }
}
