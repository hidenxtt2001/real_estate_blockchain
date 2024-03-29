class AuthConstants {
  const AuthConstants._();
  static const $AuthRemote remote = $AuthRemote._();
  static const $AuthLocal local = $AuthLocal._();
}

class $AuthRemote {
  const $AuthRemote._();
  final String login = '/users/login';
  final String register = '/users';
  final String userInfo = '/users/user_info';
  final String refreshToken = '/users/refresh_token';
}

class $AuthLocal {
  const $AuthLocal._();
  final String key = 'AUTH';
  final String tokenAuth = 'TOKEN_AUTH';
}
