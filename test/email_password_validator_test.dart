import 'package:shopping_list/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty email returns error string', () {
    final result = EmailFieldValidator.validate('');
    expect(result, 'Please Enter Your Email');
  });

  test('non-empty email returns null', () {
    final result = EmailFieldValidator.validate('email');
    expect(result, null);
  });

  test('empty password returns error string', () {
    final result = PasswordFieldValidator.validate('');
    expect(result, 'Enter Valid Password');
  });

  test('non-empty password returns null', () {
    final result = PasswordFieldValidator.validate('password');
    expect(result, null);
  });

  test('invalid-email', () {
    final result = EmailFieldValidator.validate('email');
    expect(result, null);
  });
}
