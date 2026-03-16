import 'dart:io';

import 'package:dcli/dcli.dart';
import 'package:recase/recase.dart';

import '../../../core/structure.dart';
import '../../menu/menu.dart';

/// Prompt user for a component name if not provided via CLI args.
/// Returns the name in snake_case, or empty string if user skips.
String promptName(String currentName, String componentType) {
  if (currentName.isNotEmpty) return currentName;
  final input = ask('Enter $componentType name:');
  return input.snakeCase;
}

/// Prompt user to select a target feature if not provided via `on` flag.
/// Lists existing feature directories from lib/features/ and shows a menu.
/// Returns feature name in snake_case, or empty string if user skips.
String promptFeature(String currentFeature) {
  if (currentFeature.isNotEmpty) return currentFeature;

  // Scan lib/features/ for existing feature directories
  final featuresBase = Structure.featurePath('');
  final featuresDir =
      Directory(featuresBase.endsWith(Platform.pathSeparator)
          ? featuresBase.substring(0, featuresBase.length - 1)
          : featuresBase);

  List<String> existing = [];
  if (featuresDir.existsSync()) {
    existing = featuresDir
        .listSync()
        .whereType<Directory>()
        .map((d) => d.path.split(Platform.pathSeparator).last)
        .where((name) => !name.startsWith('.'))
        .toList()
      ..sort();
  }

  if (existing.isEmpty) {
    final input = ask('Enter target feature name:');
    return input.snakeCase;
  }

  final menuChoices = [...existing, '+ Enter manually'];
  final answer = Menu(menuChoices, title: 'Select target feature:').choose();

  if (answer.index == menuChoices.length - 1) {
    final input = ask('Enter target feature name:');
    return input.snakeCase;
  }
  return answer.result;
}
