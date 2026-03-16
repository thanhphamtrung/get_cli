import '../../interface/sample_interface.dart';

/// Template for core/router/app_router.dart — GoRouter with @riverpod
class RiverpodAppRouterSample extends Sample {
  RiverpodAppRouterSample({String path = 'lib/core/router/app_router.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'route_names.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RouteNames.home,
    routes: [
      GoRoute(
        path: RouteNames.home,
        name: RouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: \${state.uri}'),
      ),
    ),
  );
}
''';
}
