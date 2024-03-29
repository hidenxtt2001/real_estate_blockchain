// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:real_estate_blockchain/config/app_size.dart';
import 'package:real_estate_blockchain/data/province/data.dart';
import 'package:real_estate_blockchain/feature/app/module.dart';
import 'package:real_estate_blockchain/feature/house_add_new/application/validate_subcriber.dart';
import 'package:real_estate_blockchain/feature/house_add_new/module.dart';
import 'package:real_estate_blockchain/feature/my_home/module.dart';
import 'package:real_estate_blockchain/languages/languages.dart';
import 'package:real_estate_blockchain/utils/extension/context_extensions.dart';

class ChooseAdressPage extends StatefulWidget {
  const ChooseAdressPage({super.key});

  @override
  State<ChooseAdressPage> createState() => _ChooseAdressPageState();
}

class _ChooseAdressPageState extends State<ChooseAdressPage> {
  late TextEditingController addressController;
  late final HouseProcessAddressBloc bloc;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    bloc = context.read<HouseProcessAddressBloc>();
    bloc.start();
  }

  @override
  void dispose() {
    addressController.dispose();
    bloc.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          s.propertyAddress,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: context.textTheme.displayLarge?.color,
          ),
        ),
        AppSize.largeHeightDimens.verticalSpace,
        _DropDownAddress<Province>(
          selector: (state) {
            return dartz.Tuple2(
              state.provinces,
              state.addressChoosen.province,
            );
          },
          hint: s.province,
          onLabel: (value) {
            return context.read<AppBloc>().state.locale == const Locale('en')
                ? value.fullNameEn ?? ''
                : value.fullName ?? '';
          },
          onChanged: (value) {
            context.read<HouseProcessAddressBloc>().onProviceChanged(value);
          },
        ),
        AppSize.largeHeightDimens.verticalSpace,
        _DropDownAddress<District>(
          selector: (state) {
            return dartz.Tuple2(state.districts, state.addressChoosen.district);
          },
          hint: s.district,
          onLabel: (value) {
            return context.read<AppBloc>().state.locale == const Locale('en')
                ? value.fullNameEn ?? ''
                : value.fullName ?? '';
          },
          onChanged: (value) {
            context.read<HouseProcessAddressBloc>().onDistrictChanged(value);
          },
        ),
        AppSize.largeHeightDimens.verticalSpace,
        _DropDownAddress<Ward>(
          selector: (state) {
            return dartz.Tuple2(state.wards, state.addressChoosen.ward);
          },
          hint: s.wards,
          onLabel: (value) {
            return context.read<AppBloc>().state.locale == const Locale('en')
                ? value.fullNameEn ?? ''
                : value.fullName ?? '';
          },
          onChanged: (value) {
            context.read<HouseProcessAddressBloc>().onWardChanged(value);
          },
        ),
        AppSize.largeHeightDimens.verticalSpace,
        InputPrimaryForm(
          hint: s.streetAddress,
          controller: addressController,
          onChanged: (value) {
            context
                .read<HouseProcessAddressBloc>()
                .onStreetAddressChanged(value);
          },
        ),
      ],
    );
  }
}

class _DropDownAddress<T> extends StatelessWidget {
  final dartz.Tuple2<List<T>, T?> Function(HouseProcessAddressState state)
      selector;
  final String hint;
  final String Function(T value) onLabel;
  final void Function(T? value)? onChanged;
  const _DropDownAddress({
    Key? key,
    required this.selector,
    required this.hint,
    required this.onLabel,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HouseProcessAddressBloc, HouseProcessAddressState,
        dartz.Tuple2<List<T>, T?>>(
      selector: (state) {
        return selector.call(state);
      },
      builder: (context, tuple) {
        return DropdownApp<T>(
          value: tuple.value2,
          hint: Text(
            hint,
            style: context.theme.inputDecorationTheme.hintStyle,
          ),
          items: tuple.value1
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      onLabel.call(e),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          selectedItemBuilder: (context) {
            return tuple.value1
                .map(
                  (e) => Text(
                    onLabel.call(e),
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.textTheme.displayLarge?.color,
                    ),
                  ),
                )
                .toList();
          },
        );
      },
    );
  }
}
