import 'package:dartz/dartz.dart';
import 'package:real_estate_blockchain/data/auth/data.dart';
import 'auth_failures.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailures, AuthToken>> login(
      PhoneNumberAuth phoneNumber, PasswordAuth password);
  Future<Either<AuthFailures, Unit>> register(FullNameAuth fullName,
      PhoneNumberAuth phoneNumber, PasswordAuth password);
}
