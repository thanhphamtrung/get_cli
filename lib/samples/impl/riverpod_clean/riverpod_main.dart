import '../../interface/sample_interface.dart';

/// Template for main.dart with ProviderScope + GoRouter
class RiverpodMainSample extends Sample {
  final String _projectName;

  RiverpodMainSample(this._projectName, {String path = 'lib/main.dart'})
      : super(path, overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: '${_projectName.replaceAll('_', ' ')}',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
''';
}
