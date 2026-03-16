import '../../interface/sample_interface.dart';

/// Template for core/router/route_names.dart
class RiverpodRouteNamesSample extends Sample {
  RiverpodRouteNamesSample({String path = 'lib/core/router/route_names.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
abstract class RouteNames {
  RouteNames._();

  static const home = '/';
}
''';
}
