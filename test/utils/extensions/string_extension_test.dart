import 'package:flutter_test/flutter_test.dart';
import 'package:primarybid_ecommerce_app/utils/extensions/string_extension.dart';

void main() {
  const String testString = 'test';
  const String correctTestString = 'Harry';

  group('String Extension', () {
    test('capitalise extension correctly Capitalises first letter', () {
      expect(testString.capitalise(), 'Test');
    });

    group('isValidInput', () {
      test('Returns correct Validation message when String is empty', () {
        expect(
          ''.isValidInput('Username'),
          'Username cannot be empty',
        );
      });
      test('Returns correct Validation message when String is too short', () {
        expect(
          testString.isValidInput('Username'),
          'Username must contain 5 or more characters',
        );
      });
      test('Returns nothing message when String is correctly formatted', () {
        expect(
          correctTestString.isValidInput('Username'),
          null,
        );
      });
    });
  });
}
