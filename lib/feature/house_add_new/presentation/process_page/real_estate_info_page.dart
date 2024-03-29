import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate_blockchain/config/app_color.dart';
import 'package:real_estate_blockchain/config/app_size.dart';
import 'package:real_estate_blockchain/data/real_estate/domain/entities/real_estate_type.dart';
import 'package:real_estate_blockchain/feature/app/module.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/enums.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/house_process_real_info_bloc.dart';
import 'package:real_estate_blockchain/feature/house_add_new/module.dart';
import 'package:real_estate_blockchain/feature/real_estate/config/real_estate_config_bloc.dart';
import 'package:real_estate_blockchain/languages/languages.dart';
import 'package:real_estate_blockchain/utils/enums.dart';
import 'package:real_estate_blockchain/utils/extension/context_extensions.dart';

class RealEstateInfoPage extends StatefulWidget {
  const RealEstateInfoPage({super.key});

  @override
  State<RealEstateInfoPage> createState() => _RealEstateInfoPageState();
}

class _RealEstateInfoPageState extends State<RealEstateInfoPage> {
  late final HouseProcessRealInfoBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<HouseProcessRealInfoBloc>();
    bloc.started();
  }

  @override
  void dispose() {
    bloc.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OptionTypeRealEstate<RealEstateSell>(
          data: const [RealEstateSell.sell, RealEstateSell.rent],
          onChanged: (value) {
            bloc.onChangedTypeSell(value);
          },
          labelBuild: (value) {
            switch (value) {
              case RealEstateSell.sell:
                return s.sell;
              case RealEstateSell.rent:
                return s.rent;
            }
          },
        ),
        AppSize.largeHeightDimens.verticalSpace,
        ...[
          Text(
            s.realEstateName,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textTheme.displayLarge?.color,
            ),
          ),
          AppSize.mediumHeightDimens.verticalSpace,
          InputPrimaryForm(
            keyboardType: TextInputType.text,
            onChanged: (value) {
              bloc.onRealEstateNameChanged(value);
            },
          )
        ],
        AppSize.largeHeightDimens.verticalSpace,
        ...[
          Text(
            s.realEstateType,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textTheme.displayLarge?.color,
            ),
          ),
          AppSize.mediumHeightDimens.verticalSpace,
          BlocBuilder<HouseProcessRealInfoBloc, HouseProcessRealInfoState>(
            builder: (context, state) {
              final bloc = context.read<RealEstateConfigBloc>();
              final list = bloc.state.config?.realEstateTypes?.toList() ?? [];
              return DropdownApp<RealEstateType>(
                items: list
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Text(
                            e.title(context) ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                hint: Text(
                  s.realEstateDescription,
                  style: context.theme.inputDecorationTheme.hintStyle,
                ),
                onChanged: (value) {
                  if (value != null) this.bloc.onChangedRealEstateType(value);
                },
                selectedItemBuilder: (context) {
                  return list
                      .map((e) => Text(
                            e.title(context) ?? '',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: context.textTheme.displayLarge?.color,
                            ),
                          ))
                      .toList();
                },
              );
            },
          )
        ],
        AppSize.mediumHeightDimens.verticalSpace,
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.area,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textTheme.displayLarge?.color,
                    ),
                  ),
                  AppSize.mediumHeightDimens.verticalSpace,
                  InputPrimaryForm(
                    hint: '1230000',
                    keyboardType: TextInputType.number,
                    suffixIcon: IntrinsicWidth(
                      child: Center(
                        child: Text(
                          'm2',
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.textTheme.displayLarge?.color,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      bloc.onAreaChanged(double.tryParse(value) ?? 0);
                    },
                  )
                ],
              ),
            ),
            AppSize.largeWidthDimens.horizontalSpace,
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.price,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textTheme.displayLarge?.color,
                    ),
                  ),
                  AppSize.mediumHeightDimens.verticalSpace,
                  InputPrimaryForm(
                    hint: '1200000',
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      bloc.onPriceChanged(double.tryParse(value) ?? 0);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        AppSize.mediumHeightDimens.verticalSpace,
        ...[
          Text(
            s.builtAt,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textTheme.displayLarge?.color,
            ),
          ),
          AppSize.mediumHeightDimens.verticalSpace,
          InputPrimaryForm(
            hint: '2000',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              bloc.onBuiltAtChanged(int.tryParse(value) ?? 0);
            },
          )
        ],
        AppSize.mediumHeightDimens.verticalSpace,
        Text(
          s.legalDocuments,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.textTheme.displayLarge?.color,
          ),
        ),
        AppSize.mediumHeightDimens.verticalSpace,
        BlocSelector<HouseProcessRealInfoBloc, HouseProcessRealInfoState,
            List<String>>(
          selector: (state) {
            return state.documents;
          },
          builder: (context, list) {
            return Wrap(
              spacing: AppSize.mediumWidthDimens,
              runSpacing: AppSize.mediumHeightDimens,
              children: [
                ...list
                    .map(
                      (e) => InputChip(
                        padding: EdgeInsets.all(
                          8.w,
                        ),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: AppColor.kNeutrals_.shade500,
                        label: Text(
                          e,
                          style: context.textTheme.bodyMedium?.copyWith(),
                        ),
                        onDeleted: () {
                          bloc.deleteDocument(e);
                        },
                      ),
                    )
                    .toList(),
                ActionChip(
                  padding: EdgeInsets.all(
                    8.w,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  backgroundColor: AppColor.kNeutrals_.shade500,
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s.addDocument,
                        style: context.textTheme.bodyMedium?.copyWith(),
                      ),
                      AppSize.smallWidthDimens.horizontalSpace,
                      Icon(
                        Icons.add,
                        size: AppSize.smallIcon,
                      ),
                    ],
                  ),
                  onPressed: () {
                    showAddDocument(context);
                  },
                )
              ],
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.largeHeightDimens,
          ),
          child: const Divider(height: 0),
        ),
        BlocBuilder<HouseProcessRealInfoBloc, HouseProcessRealInfoState>(
          builder: (context, state) {
            const values = RealEstateDetail.values;
            return ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return _SelectNumberOption(
                  lable: labelByName(values[index]),
                  value: numberByName(values[index], state),
                  onDecrease: () {
                    switch (values[index]) {
                      case RealEstateDetail.room:
                        bloc.onNumberOfBedRoomChanged(false);
                        break;
                      case RealEstateDetail.wc:
                        bloc.onNumberOfWcChanged(false);
                        break;
                      case RealEstateDetail.floor:
                        bloc.onNumberOfFloorChanged(false);
                        break;
                    }
                  },
                  onIncrease: () {
                    switch (values[index]) {
                      case RealEstateDetail.room:
                        bloc.onNumberOfBedRoomChanged(true);
                        break;
                      case RealEstateDetail.wc:
                        bloc.onNumberOfWcChanged(true);
                        break;
                      case RealEstateDetail.floor:
                        bloc.onNumberOfFloorChanged(true);
                        break;
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return AppSize.mediumHeightDimens.verticalSpace;
              },
              itemCount: values.length,
            );
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.largeHeightDimens,
          ),
          child: Row(
            children: [
              Text(
                s.additionalDescription,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColor.kNeutrals_.shade600,
                ),
              ),
              AppSize.mediumWidthDimens.horizontalSpace,
              const Expanded(child: Divider(height: 0)),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.houseFacing,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textTheme.displayLarge?.color,
                    ),
                  ),
                  AppSize.mediumHeightDimens.verticalSpace,
                  (() {
                    final list = RealEstateDirection.values.toList();
                    return DropdownApp<RealEstateDirection>(
                      isExpanded: true,
                      items: list
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  e.title(context),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          bloc.onHouseFacingChanged(
                            RealEstateDirection.values.firstWhere(
                              (element) => element == value,
                            ),
                          );
                        }
                      },
                      selectedItemBuilder: (context) {
                        return list
                            .map((e) => Text(
                                  e.title(context),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        context.textTheme.displayLarge?.color,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                            .toList();
                      },
                    );
                  })()
                ],
              ),
            ),
            AppSize.mediumWidthDimens.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.balconyFacing,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.textTheme.displayLarge?.color,
                    ),
                  ),
                  AppSize.mediumHeightDimens.verticalSpace,
                  (() {
                    final list = RealEstateDirection.values.map((e) => e);
                    return DropdownApp<RealEstateDirection>(
                      isExpanded: true,
                      items: list
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                ),
                                child: Text(
                                  e.title(context),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          bloc.onBalconyFacingChanged(RealEstateDirection.values
                              .firstWhere((element) => element == value));
                        }
                      },
                      selectedItemBuilder: (context) {
                        return list
                            .map((e) => Text(
                                  e.title(context),
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color:
                                        context.textTheme.displayLarge?.color,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                            .toList();
                      },
                    );
                  })()
                ],
              ),
            ),
          ],
        ),
        AppSize.mediumHeightDimens.verticalSpace,
        ...[
          Text(
            s.furniture,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: context.textTheme.displayLarge?.color,
            ),
          ),
          AppSize.mediumHeightDimens.verticalSpace,
          InputPrimaryForm(
            onChanged: (value) {
              bloc.onFurnitureChanged(value);
            },
          )
        ],
        AppSize.mediumHeightDimens.verticalSpace,
      ],
    );
  }

  String labelByName(RealEstateDetail type) {
    final s = S.of(context);
    switch (type) {
      case RealEstateDetail.room:
        return s.noBedRoom;
      case RealEstateDetail.wc:
        return s.noBathRoom;
      case RealEstateDetail.floor:
        return s.noFloor;
    }
  }

  int numberByName(RealEstateDetail type, HouseProcessRealInfoState state) {
    switch (type) {
      case RealEstateDetail.room:
        return state.noBedroom;
      case RealEstateDetail.wc:
        return state.noWc;
      case RealEstateDetail.floor:
        return state.floors;
    }
  }

  void showAddDocument(BuildContext buildContext) async {
    final s = S.of(buildContext);
    final TextEditingController textEditingController = TextEditingController();
    showModalBottomSheet(
      context: buildContext,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(
            AppSize.extraWidthDimens,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputPrimaryForm(
                controller: textEditingController,
                hint: s.legalDocuments,
              ),
              AppSize.extraHeightDimens.verticalSpace,
              ButtonApp(
                label: s.addDocument,
                onPressed: () {
                  final text = textEditingController.text;
                  bloc.addDocument(text);
                  Navigator.of(context).pop();
                },
                type: ButtonType.primary,
              ),
            ],
          ),
        );
      },
    ).then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      textEditingController.dispose();
    });
  }
}

class _OptionTypeRealEstate<T> extends StatefulWidget {
  final List<T> data;
  final T? value;
  final String Function(T value) labelBuild;
  final void Function(T value) onChanged;
  const _OptionTypeRealEstate({
    super.key,
    required this.data,
    required this.onChanged,
    this.value,
    required this.labelBuild,
  });

  @override
  State<_OptionTypeRealEstate> createState() => _OptionTypeRealEstateState<T>();
}

class _OptionTypeRealEstateState<T> extends State<_OptionTypeRealEstate<T>>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.data.length, vsync: this);
    tabController.addListener(() {
      widget.onChanged.call(widget.data[tabController.index]);
    });
    if (widget.value != null) {
      tabController.animateTo(widget.data.indexOf(widget.value!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSize.largeRadius),
        color: AppColor.kNeutrals_.shade500,
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        padding: EdgeInsets.all(AppSize.smallWidthDimens),
        indicator: BoxDecoration(
          color: AppColor.kNeutrals_.shade50,
          borderRadius: BorderRadius.circular(AppSize.largeRadius),
        ),
        labelStyle: context.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        labelColor: context.textTheme.displayLarge?.color,
        // isScrollable: true,
        controller: tabController,
        tabs: widget.data
            .map(
              (e) => Tab(
                text: widget.labelBuild.call(e),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SelectNumberOption extends StatelessWidget {
  final String lable;
  final int value;
  final void Function() onIncrease;
  final void Function() onDecrease;
  const _SelectNumberOption(
      {super.key,
      required this.lable,
      required this.value,
      required this.onIncrease,
      required this.onDecrease});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          lable,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.textTheme.displayLarge?.color,
          ),
        ),
        const Spacer(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 28.w,
              width: 28.w,
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(AppSize.smallRadius),
                color: value <= 0
                    ? AppColor.kNeutrals_.shade600
                    : AppColor.kNeutrals_.shade800,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: AppSize.smallIcon,
                  onPressed: onDecrease,
                  icon: Icon(
                    Icons.remove,
                    color: AppColor.kNeutrals_.shade50,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: AppSize.largeWidthDimens * 3,
              child: Center(child: Text(value.toString())),
            ),
            SizedBox(
              height: 28.w,
              width: 28.w,
              child: Material(
                elevation: 0,
                borderRadius: BorderRadius.circular(AppSize.smallRadius),
                color: AppColor.kNeutrals_.shade800,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: AppSize.smallIcon,
                  onPressed: onIncrease,
                  icon: Icon(
                    Icons.add,
                    color: AppColor.kNeutrals_.shade50,
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
