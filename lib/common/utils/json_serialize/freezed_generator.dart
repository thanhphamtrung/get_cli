import 'dart:collection';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:dart_style/dart_style.dart';
import 'package:recase/recase.dart';

import 'helpers.dart';
import 'json_ast/json_ast.dart' show parse, Settings, Node;
import 'model_generator.dart' show DartCode, Hint;
import 'sintaxe.dart';

/// Generates Freezed model classes from JSON input.
///
/// Reuses the same JSON parsing pipeline as ModelGenerator but outputs
/// @freezed annotated classes with part directives.
class FreezedModelGenerator {
  final String _rootClassName;
  final String _fileName;
  final List<_FreezedClass> _allClasses = [];
  final Map<String, String> _sameClassMapping = HashMap<String, String>();
  late List<Hint> hints;

  FreezedModelGenerator(this._rootClassName, this._fileName,
      [List<Hint>? hints]) {
    this.hints = hints ?? <Hint>[];
  }

  Hint? _hintForPath(String path) {
    return hints.firstWhereOrNull((h) => h.path == path);
  }

  List<Warning> _generateClassDefinition(
      String className, dynamic jsonRawData, String path, Node? astNode) {
    var warnings = <Warning>[];
    if (jsonRawData is List) {
      final node = navigateNode(astNode, '0');
      if (jsonRawData.isNotEmpty) {
        _generateClassDefinition(className, jsonRawData[0], path, node);
      }
    } else if (jsonRawData is Map) {
      final keys = jsonRawData.keys.cast<String>();
      final classDef = _FreezedClass(className);

      for (var key in keys) {
        final hint = _hintForPath('$path/$key');
        final node = navigateNode(astNode, key);
        String typeName;

        if (hint != null) {
          typeName = hint.type;
        } else {
          final value = jsonRawData[key];
          typeName = _inferType(key, value, node);
        }

        classDef.fields.add(_FreezedField(key, typeName));
      }

      // Check for duplicate classes
      final existing =
          _allClasses.firstWhereOrNull((c) => c.hasSameFields(classDef));
      if (existing != null) {
        _sameClassMapping[classDef.className] = existing.className;
      } else {
        _allClasses.add(classDef);
      }

      // Process nested objects
      for (var key in keys) {
        final value = jsonRawData[key];
        if (value is Map) {
          final node = navigateNode(astNode, key);
          final nestedWarnings = _generateClassDefinition(
              ReCase(key).pascalCase, value, '$path/$key', node);
          warnings.addAll(nestedWarnings);
        } else if (value is List && value.isNotEmpty && value[0] is Map) {
          final node = navigateNode(astNode, key);
          final merged =
              mergeObjectList(value, '$path/$key');
          warnings.addAll(merged.warnings);
          final nestedWarnings = _generateClassDefinition(
              ReCase(key).pascalCase, merged.result, '$path/$key', node);
          warnings.addAll(nestedWarnings);
        }
      }
    }
    return warnings;
  }

  String _inferType(String key, dynamic value, Node? node) {
    if (value == null) return 'dynamic';
    if (value is String) return 'String';
    if (value is int) return 'int';
    if (value is double) return 'double';
    if (value is bool) return 'bool';
    if (value is Map) return '${ReCase(key).pascalCase}Model';
    if (value is List) {
      if (value.isEmpty) return 'List<dynamic>';
      final first = value[0];
      if (first is String) return 'List<String>';
      if (first is int) return 'List<int>';
      if (first is double) return 'List<double>';
      if (first is bool) return 'List<bool>';
      if (first is Map) return 'List<${ReCase(key).pascalCase}Model>';
      return 'List<dynamic>';
    }
    return 'dynamic';
  }

  /// Generate Freezed Dart code from raw JSON string.
  DartCode generateFreezedClasses(String rawJson) {
    final jsonRawData = decodeJSON(rawJson);
    final astNode = parse(rawJson, Settings());
    var warnings =
        _generateClassDefinition(_rootClassName, jsonRawData, '', astNode);

    // Apply same-class mappings
    for (var c in _allClasses) {
      for (var f in c.fields) {
        if (_sameClassMapping.containsKey(f.type)) {
          f.type = _sameClassMapping[f.type]!;
        }
      }
    }

    final sb = StringBuffer();
    sb.writeln("import 'package:freezed_annotation/freezed_annotation.dart';");
    sb.writeln();
    sb.writeln("part '$_fileName.freezed.dart';");
    sb.writeln("part '$_fileName.g.dart';");
    sb.writeln();

    for (var classDef in _allClasses.reversed) {
      sb.writeln(classDef.toFreezedString());
    }

    try {
      final formatter = DartFormatter(
          languageVersion: DartFormatter.latestLanguageVersion);
      return DartCode(formatter.format(sb.toString()), warnings);
    } on Exception catch (_) {
      return DartCode(sb.toString(), warnings);
    }
  }
}

class _FreezedClass {
  final String className;
  final List<_FreezedField> fields = [];

  _FreezedClass(this.className);

  bool hasSameFields(_FreezedClass other) {
    if (fields.length != other.fields.length) return false;
    for (var i = 0; i < fields.length; i++) {
      if (fields[i].name != other.fields[i].name ||
          fields[i].type != other.fields[i].type) {
        return false;
      }
    }
    return true;
  }

  String toFreezedString() {
    final sb = StringBuffer();
    sb.writeln('@freezed');
    sb.writeln('class ${className}Model with _\$${className}Model {');
    sb.writeln('  const ${className}Model._();');
    sb.writeln();
    sb.writeln('  const factory ${className}Model({');

    for (var field in fields) {
      final fieldName = ReCase(field.name).camelCase;
      final isNullable = field.type == 'dynamic';
      if (isNullable) {
        sb.writeln('    ${field.type}? $fieldName,');
      } else {
        sb.writeln('    required ${field.type} $fieldName,');
      }
    }

    sb.writeln('  }) = _${className}Model;');
    sb.writeln();
    sb.writeln(
        '  factory ${className}Model.fromJson(Map<String, dynamic> json) =>');
    sb.writeln('      _\$${className}ModelFromJson(json);');
    sb.writeln('}');
    sb.writeln();

    return sb.toString();
  }
}

class _FreezedField {
  final String name;
  String type;

  _FreezedField(this.name, this.type);
}
