import 'package:recase/recase.dart';

import '../../interface/sample_interface.dart';

/// Template for presentation/providers/{name}_provider.dart — @riverpod
class RiverpodProviderSample extends Sample {
  final String _name;

  RiverpodProviderSample(this._name, {String? path})
      : super(
            path ??
                'lib/features/${_name.snakeCase}/presentation/providers/${_name.snakeCase}_provider.dart',
            overwrite: true);

  @override
  String get content => '''
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/${_name.snakeCase}.dart';

part '${_name.snakeCase}_provider.g.dart';

@riverpod
class ${_name.pascalCase}Notifier extends _\$${_name.pascalCase}Notifier {
  @override
  Future<List<${_name.pascalCase}>> build() async {
    // TODO: Inject use case and fetch data
    return [];
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      // TODO: Call use case
      return [];
    });
  }
}
''';
}
