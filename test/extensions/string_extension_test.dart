import 'package:flutter_test/flutter_test.dart';
import 'package:workinax/extensions/string_extension.dart';

main() {
  group('orNA', () {
    test('given null string should return N/A', () {
      const String? data = null;

      final result = data.orNA;
      expect(result, 'N/A');
    });

    test('given not null string should return string', () {
      const data = 'test';

      final result = data.orNA;
      expect(result, 'test');
    });
  });
}
