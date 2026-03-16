import 'dart:io';

import 'package:path/path.dart';
import 'package:yaml/yaml.dart';

/// Keep in sync with pubspec.yaml version.
const String dexCliVersion = '0.0.3';

class PubspecLock {
  /// Returns the installed CLI version.
  /// Tries pubspec.lock first (for pub global activate installs),
  /// then falls back to the compiled-in constant.
  static Future<String?> getVersionCli({bool disableLog = false}) async {
    try {
      var scriptFile = Platform.script.toFilePath();
      var pathToPubLock = join(dirname(scriptFile), '../pubspec.lock');
      final file = File(pathToPubLock);
      if (await file.exists()) {
        var text = loadYaml(await file.readAsString());
        if (text['packages']?['dex_cli'] != null) {
          return text['packages']['dex_cli']['version'].toString();
        }
      }
    } on Exception catch (_) {
      // Fall through to constant
    }
    // Fallback: return compiled-in version
    return dexCliVersion;
  }
}
