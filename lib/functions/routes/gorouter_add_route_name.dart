import 'dart:io';

import 'package:recase/recase.dart';

import '../../common/utils/logger/log_utils.dart';
import '../../core/structure.dart';
import '../create/create_single_file.dart';

/// Adds a route name constant to core/router/route_names.dart.
///
/// Inserts `static const {name} = '/{name}';` before the closing `}`.
void addRouteName(String name) {
  final filePath = Structure.replaceAsExpected(
      path: 'lib/core/router/route_names.dart');
  final file = File(filePath);

  if (!file.existsSync()) {
    LogService.info('route_names.dart not found — skipping route name.');
    return;
  }

  final snakeName = name.snakeCase;
  var content = file.readAsStringSync();

  // Check if route already exists
  if (content.contains("static const $snakeName")) {
    return;
  }

  // Find the last `}` which closes the RouteNames class
  final lastBrace = content.lastIndexOf('}');
  if (lastBrace == -1) return;

  final newConstant = "  static const $snakeName = '/$snakeName';\n";
  content = content.substring(0, lastBrace) +
      newConstant +
      content.substring(lastBrace);

  writeFile(filePath, content,
      overwrite: true, skipFormatter: true, logger: false);
  LogService.success('Route name "$snakeName" added to route_names.dart');
}
