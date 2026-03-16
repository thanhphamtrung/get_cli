import 'dart:io';

import 'package:test/test.dart';

void main() {
  group('No GetX references in codebase', () {
    test('no package:get_cli/ imports in lib/', () {
      final results = _grepInDir('lib/', 'package:get_cli/');
      expect(results, isEmpty,
          reason: 'Found package:get_cli/ references:\n${results.join('\n')}');
    });

    test('no GetCli class references in lib/', () {
      final results = _grepInDir('lib/', 'GetCli');
      // Filter out comments
      final nonComments =
          results.where((r) => !r.contains('//')).toList();
      expect(nonComments, isEmpty,
          reason: 'Found GetCli references:\n${nonComments.join('\n')}');
    });

    test('no package:get/ imports in lib/ (except template strings)', () {
      final results = _grepInDir('lib/', "package:get/");
      expect(results, isEmpty,
          reason: 'Found package:get/ references:\n${results.join('\n')}');
    });
  });
}

/// Recursively grep for a pattern in all .dart files under a directory.
List<String> _grepInDir(String dirPath, String pattern) {
  final dir = Directory(dirPath);
  final results = <String>[];

  for (var entity in dir.listSync(recursive: true)) {
    if (entity is File && entity.path.endsWith('.dart')) {
      final lines = entity.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        if (lines[i].contains(pattern)) {
          results.add('${entity.path}:${i + 1}: ${lines[i].trim()}');
        }
      }
    }
  }

  return results;
}
