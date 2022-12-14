import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_blockchain/injection_dependencies/injection_dependencies.dart';
import 'package:real_estate_blockchain/feature/auth/module.dart';
import 'package:real_estate_blockchain/feature/core/module.dart';

class AuthRoute extends BaseRoute {
  AuthRoute(super.root, super.path);
  // Path
  String get login => generatePath('/login');
  String get register => generatePath('/register');
  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: login,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt.call<LoginBloc>(),
              child: const LoginPage(),
            );
          },
        ),
        GoRoute(
          path: register,
          builder: (context, state) {
            return BlocProvider(
              create: (context) => getIt.call<RegisterBloc>(),
              child: const RegisterPage(),
            );
          },
        )
      ];

  @override
  void setupRoutes() {}
}
