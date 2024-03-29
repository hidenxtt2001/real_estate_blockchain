import 'package:flutter/material.dart';
import 'package:real_estate_blockchain/config/app_color.dart';

class WLoading extends StatelessWidget {
  const WLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.kPrimary1,
      ),
    );
  }
}
