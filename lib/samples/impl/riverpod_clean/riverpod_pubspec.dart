import '../../interface/sample_interface.dart';

/// Template for generated project's pubspec.yaml dependencies section
class RiverpodPubspecSample extends Sample {
  final String _projectName;

  RiverpodPubspecSample(this._projectName,
      {String path = 'pubspec.yaml'})
      : super(path, overwrite: false);

  @override
  String get content => '''
name: $_projectName
description: A Flutter project with Riverpod Clean Architecture.
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.11.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.5.0
  riverpod_annotation: ^2.3.0
  dio: ^5.4.0
  go_router: ^14.0.0
  freezed_annotation: ^2.4.0
  json_annotation: ^4.9.0
  fpdart: ^1.1.0
  pretty_dio_logger: ^1.4.0
  envied: ^0.5.0
  flutter_secure_storage: ^9.2.0
  shared_preferences: ^2.3.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.0
  riverpod_generator: ^2.4.0
  freezed: ^2.5.0
  json_serializable: ^6.8.0
  envied_generator: ^0.5.0

flutter:
  uses-material-design: true
''';
}
