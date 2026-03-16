import '../../interface/sample_interface.dart';

/// Template for generated project's analysis_options.yaml
class RiverpodAnalysisOptionsSample extends Sample {
  RiverpodAnalysisOptionsSample(
      {String path = 'analysis_options.yaml'})
      : super(path, overwrite: true);

  @override
  String get content => '''
include: package:flutter_lints/flutter.yaml

analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
  errors:
    invalid_annotation_target: ignore

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
    avoid_print: true
''';
}
