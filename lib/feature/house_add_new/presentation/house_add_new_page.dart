import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_blockchain/config/app_color.dart';
import 'package:real_estate_blockchain/config/app_dialog.dart';
import 'package:real_estate_blockchain/config/app_size.dart';
import 'package:real_estate_blockchain/data/real_estate/domain/real_estate_failure.dart';
import 'package:real_estate_blockchain/feature/app/module.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/house_process_media_bloc.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/house_process_real_info_bloc.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/validate_subcriber.dart';
import 'package:real_estate_blockchain/feature/house_add_new/module.dart';
import 'package:real_estate_blockchain/feature/house_add_new/presentation/process_page/map_position_page.dart';
import 'package:real_estate_blockchain/feature/my_home/module.dart';
import 'package:real_estate_blockchain/injection_dependencies/injection_dependencies.dart';
import 'package:real_estate_blockchain/languages/languages.dart';
import 'package:real_estate_blockchain/utils/extension/context_extensions.dart';

import '../application/enums.dart';
import 'process_page/process_page.dart';

class HouseAddNewPage extends StatefulWidget {
  const HouseAddNewPage({super.key});

  @override
  State<HouseAddNewPage> createState() => _HouseAddNewPageState();
}

class _HouseAddNewPageState extends State<HouseAddNewPage> {
  late final HouseAddNewBloc bloc;
  late final PageController controller;
  final ValidateSubcriber validateSubcriber = ValidateSubcriber();

  @override
  void initState() {
    super.initState();
    bloc = context.read<HouseAddNewBloc>();
    controller = PageController(initialPage: 0, keepPage: true);
    bloc.setup(validateSubcriber);
  }

  Widget generatePage(ProcessState state) {
    switch (state) {
      case ProcessState.address:
        return BlocProvider<HouseProcessAddressBloc>(
          create: (context) =>
              getIt.call<HouseProcessAddressBloc>(param1: validateSubcriber),
          child: const ChooseAdressPage(),
        );
      case ProcessState.realeStateInfo:
        return BlocProvider(
          create: (context) =>
              getIt.call<HouseProcessRealInfoBloc>(param1: validateSubcriber),
          child: const RealEstateInfoPage(),
        );
      case ProcessState.amenities:
        return BlocProvider(
          create: (context) =>
              getIt.call<HouseProcessAmentityBloc>(param1: validateSubcriber),
          child: const AmenityPage(),
        );
      case ProcessState.media:
        return BlocProvider(
          create: (context) =>
              getIt.call<HouseProcessMediaBloc>(param1: validateSubcriber),
          child: const VideoPhotoPage(),
        );
      case ProcessState.map:
        return BlocProvider(
          create: (context) => getIt.call<HouseProcessMapPositionBloc>(
              param1: validateSubcriber),
          child: const MapPositionPage(),
        );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: CustomAppbar(
        context,
        leading: const BackButtonApp(),
        title: Text(s.myHomeEmptyBtnAdd2),
        centerTitle: true,
      ),
      body: BlocListener<HouseAddNewBloc, HouseAddNewState>(
        listener: (context, state) {
          state.status.mapOrNull(
            loading: (value) {
              context.appDialog.showLoading();
            },
            idle: (value) {
              context.appDialog.dismissDialog();
            },
            failure: (value) {
              if (value is RealEstateFailure) {
                (value as RealEstateFailure).whenOrNull(
                  loadConfigFail: () {
                    context.appDialog.showAppDialog(
                      type: AppDialogType.error,
                      message: s.anErrorOccurred,
                      onPositive: () {
                        context.pop();
                      },
                    );
                  },
                );
              }
            },
            success: (value) {
              context.pop();
              context.appDialog.showAppDialog(
                type: AppDialogType.info,
                message: s.createRealEstateSuccess,
              );
            },
          );
          controller.jumpToPage(state.state.index);
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(
                AppSize.extraWidthDimens,
              ),
              child: BlocBuilder<HouseAddNewBloc, HouseAddNewState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      BlocBuilder<HouseAddNewBloc, HouseAddNewState>(
                        builder: (context, state) {
                          String title = '';
                          switch (state.state) {
                            case ProcessState.address:
                              title = s.addNewPropertyAddress;
                              break;
                            case ProcessState.realeStateInfo:
                              title = s.addNewPropertyRealEstateInfo;
                              break;
                            case ProcessState.media:
                              title = s.addNewPropertyMedia;
                              break;
                            case ProcessState.map:
                              title = s.addNewPropertyMap;
                              break;
                            case ProcessState.amenities:
                              title = s.addNewPropertyAmenities;
                              break;
                          }
                          return Row(
                            children: [
                              Text(
                                title,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: context.textTheme.displayLarge?.color,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: AppSize.smallHeightDimens,
                                  horizontal: AppSize.largeWidthDimens,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.kNeutrals.shade800,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: Text(
                                  "${(state.state.index + 1)}/${ProcessState.values.length}",
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    color: AppColor.kNeutrals.shade50,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                      AppSize.largeHeightDimens.verticalSpace,
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          AppSize.extraLargeRadius,
                        ),
                        child: TweenAnimationBuilder<double>(
                          duration: const Duration(seconds: 1),
                          tween: Tween<double>(
                            begin: 0,
                            end: (state.state.index + 1) /
                                ProcessState.values.length,
                          ),
                          builder: (context, value, child) {
                            return LinearProgressIndicator(
                              value: value,
                              backgroundColor: AppColor.kNeutrals.shade500,
                              minHeight: AppSize.mediumHeightDimens,
                              color: AppColor.kPrimary1,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.extraWidthDimens,
                ),
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemBuilder: (context, index) {
                    final state = ProcessState.values[index];
                    return SingleChildScrollView(
                      child: generatePage(state),
                    );
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSize.extraLargeWidthDimens,
                vertical: AppSize.largeHeightDimens,
              ),
              decoration: BoxDecoration(
                color: context.theme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: AppSize.extraRadius,
                    offset: const Offset(0, -8),
                    color: AppColor.kNeutrals.shade700.withOpacity(0.1),
                  )
                ],
              ),
              child: ButtonApp(
                label: context.watch<HouseAddNewBloc>().state.state ==
                        ProcessState.values.last
                    ? s.done
                    : s.next,
                onPressed: () {
                  bloc.processNextPage();
                },
                type: ButtonType.primary,
              ),
            )
          ],
        ),
      ),
    );
  }
}
