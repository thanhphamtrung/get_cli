import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for presentation/pages/{name}_page.dart — ConsumerWidget
class RiverpodPageSample extends Sample {
  final String _name;

  RiverpodPageSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/presentation/pages/${_name.snakeCase}_page.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/${_name.snakeCase}_provider.dart';

class ${_name.pascalCase}Page extends ConsumerWidget {
  const ${_name.pascalCase}Page({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(${_name.camelCase}NotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('${_name.pascalCase}'),
      ),
      body: state.when(
        data: (items) => Center(
          child: Text('${_name.pascalCase} loaded: \${items.length} items'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: \$error'),
        ),
      ),
    );
  }
}
''';
}
