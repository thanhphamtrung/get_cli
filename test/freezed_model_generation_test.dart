import 'package:dex_cli/common/utils/json_serialize/freezed_generator.dart';
import 'package:test/test.dart';

void main() {
  group('FreezedModelGenerator', () {
    test('generates basic Freezed model from simple JSON', () {
      const json = '{"name": "John", "age": 30, "active": true}';
      final generator = FreezedModelGenerator('User', 'user_model');
      final result = generator.generateFreezedClasses(json);

      expect(result.code, contains('@freezed'));
      expect(result.code, contains('class UserModel with _\$UserModel'));
      expect(result.code, contains('required String name'));
      expect(result.code, contains('required int age'));
      expect(result.code, contains('required bool active'));
      expect(result.code, contains("part 'user_model.freezed.dart'"));
      expect(result.code, contains("part 'user_model.g.dart'"));
      expect(result.code, contains('_\$UserModelFromJson'));
    });

    test('generates nested Freezed classes for nested JSON objects', () {
      const json = '{"id": 1, "address": {"street": "Main", "city": "NYC"}}';
      final generator = FreezedModelGenerator('User', 'user_model');
      final result = generator.generateFreezedClasses(json);

      expect(result.code, contains('class UserModel'));
      expect(result.code, contains('class AddressModel'));
      expect(result.code, contains('required AddressModel address'));
    });

    test('infers list types correctly', () {
      const json = '{"tags": ["a", "b"], "scores": [1, 2]}';
      final generator = FreezedModelGenerator('Item', 'item_model');
      final result = generator.generateFreezedClasses(json);

      expect(result.code, contains('required List<String> tags'));
      expect(result.code, contains('required List<int> scores'));
    });

    test('handles numeric types (int vs double)', () {
      const json = '{"count": 5, "ratio": 3.14}';
      final generator = FreezedModelGenerator('Stats', 'stats_model');
      final result = generator.generateFreezedClasses(json);

      expect(result.code, contains('required int count'));
      expect(result.code, contains('required double ratio'));
    });

    test('includes const factory and private constructor', () {
      const json = '{"name": "test"}';
      final generator = FreezedModelGenerator('Simple', 'simple_model');
      final result = generator.generateFreezedClasses(json);

      expect(result.code, contains('const SimpleModel._()'));
      expect(result.code, contains('const factory SimpleModel'));
      expect(result.code, contains(') = _SimpleModel'));
    });
  });
}
