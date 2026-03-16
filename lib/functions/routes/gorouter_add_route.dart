import 'dart:io';

import 'package:recase/recase.dart';

import '../../common/utils/logger/log_utils.dart';
import '../../core/structure.dart';
import '../create/create_single_file.dart';

/// Adds a GoRoute entry to core/router/app_router.dart.
///
/// Inserts a GoRoute block before the closing `],` of the routes array,
/// and adds the page import at the top of the file.
void addGoRoute(String featureName, {String? pageName}) {
  final filePath = Structure.replaceAsExpected(
      path: 'lib/core/router/app_router.dart');
  final file = File(filePath);

  if (!file.existsSync()) {
    LogService.info('app_router.dart not found — skipping route registration.');
    return;
  }

  final snakeName = featureName.snakeCase;
  final pascalName = featureName.pascalCase;
  final actualPageName = pageName?.snakeCase ?? snakeName;
  final actualPageClass = pageName?.pascalCase ?? pascalName;

  var content = file.readAsStringSync();

  // Check if route already registered
  if (content.contains('RouteNames.$snakeName')) {
    return;
  }

  // Add import for the page
  final importLine =
      "import '../../features/$snakeName/presentation/pages/${actualPageName}_page.dart';";
  if (!content.contains(importLine)) {
    // Insert after last import line
    final lastImportIdx = content.lastIndexOf(RegExp(r"^import .+;$", multiLine: true));
    if (lastImportIdx != -1) {
      final endOfLine = content.indexOf('\n', lastImportIdx);
      content =
          '${content.substring(0, endOfLine + 1)}$importLine\n${content.substring(endOfLine + 1)}';
    }
  }

  // Find the `routes: [` and then its matching `],`
  final routesStartIdx = content.indexOf('routes: [');
  if (routesStartIdx == -1) {
    LogService.info('Could not find routes array — skipping route insertion.');
    return;
  }

  // Find the closing `],` for the routes array by counting brackets
  var bracketCount = 0;
  var closingIdx = -1;
  for (var i = content.indexOf('[', routesStartIdx); i < content.length; i++) {
    if (content[i] == '[') bracketCount++;
    if (content[i] == ']') {
      bracketCount--;
      if (bracketCount == 0) {
        closingIdx = i;
        break;
      }
    }
  }

  if (closingIdx == -1) {
    LogService.info('Could not find routes closing — skipping route insertion.');
    return;
  }

  final goRouteBlock = '''
      GoRoute(
        path: RouteNames.$snakeName,
        name: RouteNames.$snakeName,
        builder: (context, state) => const ${actualPageClass}Page(),
      ),
''';

  // Insert before the closing `]`
  content = '${content.substring(0, closingIdx)}$goRouteBlock    ${content.substring(closingIdx)}';

  writeFile(filePath, content,
      overwrite: true, skipFormatter: true, logger: false);
  LogService.success('GoRoute for "$snakeName" added to app_router.dart');
}
