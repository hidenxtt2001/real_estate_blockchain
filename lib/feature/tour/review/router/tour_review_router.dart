import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/src/route.dart';
import 'package:real_estate_blockchain/feature/core/module.dart';
import 'package:real_estate_blockchain/feature/tour/review/model/tour_review_params.dart';
import 'package:real_estate_blockchain/feature/tour/review/presentation/tour_review_page.dart';
import 'package:real_estate_blockchain/injection_dependencies/injection_dependencies.dart';

import '../application/tour_review_bloc.dart';

class TourReviewRoute extends BaseRoute {
  TourReviewRoute(super.root, super.path);

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: url,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) => getIt.call<TourReviewBloc>(
                param1: state.extra as TourReviewParams,
              ),
              child: const TourReviewPage(),
            ));
          },
        ),
      ];

  @override
  void setupRoutes() {}
}