import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:recase/recase.dart';

import '../exception_handler/exceptions/cli_exception.dart';
import '../models/file_model.dart';
import 'internationalization.dart';
import 'locales.g.dart';

class Structure {
  static final Map<String, String> _paths = {
    // Feature-first Clean Architecture paths
    'page': replaceAsExpected(path: 'lib/features'),
    'widget': replaceAsExpected(path: 'lib/shared/widgets'),
    'model': replaceAsExpected(path: 'lib/features'),
    'init': replaceAsExpected(path: 'lib/'),
    'route': replaceAsExpected(path: 'lib/core/router'),
    'repository': replaceAsExpected(path: 'lib/features'),
    'provider': replaceAsExpected(path: 'lib/features'),
    'controller': replaceAsExpected(path: 'lib/features'),
    'view': replaceAsExpected(path: 'lib/features'),
    'screen': replaceAsExpected(path: 'lib/features'),
    'entity': replaceAsExpected(path: 'lib/features'),
    'usecase': replaceAsExpected(path: 'lib/features'),
    'datasource': replaceAsExpected(path: 'lib/features'),
    'feature': replaceAsExpected(path: 'lib/features'),
    // Generator files
    'generate_locales': replaceAsExpected(path: 'lib/generated'),
  };

  // Feature-first path helpers
  static String featurePath(String name) =>
      replaceAsExpected(path: 'lib/features/$name');
  static String dataPath(String name) =>
      replaceAsExpected(path: 'lib/features/$name/data');
  static String domainPath(String name) =>
      replaceAsExpected(path: 'lib/features/$name/domain');
  static String presentationPath(String name) =>
      replaceAsExpected(path: 'lib/features/$name/presentation');
  static String get corePath => replaceAsExpected(path: 'lib/core');
  static String get sharedPath => replaceAsExpected(path: 'lib/shared');

  static FileModel model(String? name, String command, bool wrapperFolder,
      {String? on, String? folderName}) {
    if (on != null && on != '') {
      on = replaceAsExpected(path: on).replaceAll('\\\\', '\\');
      var current = Directory('lib');
      final list = current.listSync(recursive: true, followLinks: false);
      final contains = list.firstWhere((element) {
        if (element is File) {
          return false;
        }

        return '${element.path}${p.separator}'.contains('$on${p.separator}');
      }, orElse: () {
        return list.firstWhere((element) {
          //Fix erro ao encontrar arquivo com nome
          if (element is File) {
            return false;
          }
          return element.path.contains(on!);
        }, orElse: () {
          throw CliException(LocaleKeys.error_folder_not_found.trArgs([on]));
        });
      });

      return FileModel(
        name: name,
        path: Structure.getPathWithName(
          contains.path,
          ReCase(name!).snakeCase,
          createWithWrappedFolder: wrapperFolder,
          folderName: folderName,
        ),
        commandName: command,
      );
    }
    return FileModel(
      name: name,
      path: Structure.getPathWithName(
        _paths[command],
        ReCase(name!).snakeCase,
        createWithWrappedFolder: wrapperFolder,
        folderName: folderName,
      ),
      commandName: command,
    );
  }

  static String replaceAsExpected({required String path}) {
    if (path.contains('\\')) {
      if (Platform.isLinux || Platform.isMacOS) {
        return path.replaceAll('\\', '/');
      } else {
        return path;
      }
    } else if (path.contains('/')) {
      if (Platform.isWindows) {
        return path.replaceAll('/', '\\\\');
      } else {
        return path;
      }
    } else {
      return path;
    }
  }

  static String? getPathWithName(String? firstPath, String secondPath,
      {bool createWithWrappedFolder = false, required String? folderName}) {
    late String betweenPaths;
    if (Platform.isWindows) {
      betweenPaths = '\\\\';
    } else if (Platform.isMacOS || Platform.isLinux) {
      betweenPaths = '/';
    }
    if (betweenPaths.isNotEmpty) {
      if (createWithWrappedFolder) {
        return firstPath! +
            betweenPaths +
            folderName! +
            betweenPaths +
            secondPath;
      } else {
        return firstPath! + betweenPaths + secondPath;
      }
    }
    return null;
  }

  static List<String> safeSplitPath(String path) {
    return path.replaceAll('\\', '/').split('/')
      ..removeWhere((element) => element.isEmpty);
  }

  static String pathToDirImport(String path) {
    var pathSplit = safeSplitPath(path)
      ..removeWhere((element) => element == '.' || element == 'lib');
    return pathSplit.join('/');
  }
}
