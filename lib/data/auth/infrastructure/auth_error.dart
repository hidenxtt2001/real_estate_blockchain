import 'package:real_estate_blockchain/data/auth/data.dart';

class AuthError {
  const AuthError._();
  static const phoneNumberInvalid = 'InvalidPhone';
  static const passwordInvalid = 'InvalidPassword';
  static const fullNameInvalid = 'InvalidFullName';
  static const errUnauthorized = 'ErrUnauthorized';
  static const errLoginFailed = 'ErrLoginFailed';
}
