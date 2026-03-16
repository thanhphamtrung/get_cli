import '../../interface/sample_interface.dart';

/// Template for core/config/env.dart — Envied environment config
class RiverpodEnvSample extends Sample {
  RiverpodEnvSample({String path = 'lib/core/config/env.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'BASE_URL', defaultValue: 'https://api.example.com')
  static const String baseUrl = _Env.baseUrl;
}
''';
}
