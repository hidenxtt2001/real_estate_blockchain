import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router/src/route.dart';
import 'package:real_estate_blockchain/feature/core/module.dart';
import 'package:real_estate_blockchain/feature/search/application/application.dart';
import 'package:real_estate_blockchain/feature/search/presentation/models/search_page_params.dart';
import 'package:real_estate_blockchain/feature/search/presentation/search_page.dart';
import 'package:real_estate_blockchain/injection_dependencies/injection_dependencies.dart';

class SearchRoute extends BaseRoute {
  SearchRoute(super.root, super.path);

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: url,
          builder: (context, state) {
            assert(state.extra != null && state.extra is SearchPageParams);
            return BlocProvider(
              create: (context) => getIt.call<SearchBloc>(),
              child: SearchPage(
                params: state.extra as SearchPageParams,
              ),
            );
          },
        ),
      ];

  @override
  void setupRoutes() {}
}
