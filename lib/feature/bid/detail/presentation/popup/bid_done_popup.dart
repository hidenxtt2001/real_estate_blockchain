import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:real_estate_blockchain/assets/assets.gen.dart';
import 'package:real_estate_blockchain/config/app_color.dart';
import 'package:real_estate_blockchain/config/app_size.dart';
import 'package:real_estate_blockchain/data/bid/domain/model/bidder.dart';
import 'package:real_estate_blockchain/languages/languages.dart';
import 'package:real_estate_blockchain/utils/extension/context_extensions.dart';

import '../widgets/w_bidding_history_item.dart';

class BidDonePopup extends StatefulWidget {
  const BidDonePopup({
    super.key,
    required this.bidder,
  });
  final Bidder bidder;
  static Future<void> show(
    BuildContext context, {
    required Bidder bidder,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: BidDonePopup(bidder: bidder),
        );
      },
    );
  }

  @override
  State<BidDonePopup> createState() => _BidDonePopupState();
}

class _BidDonePopupState extends State<BidDonePopup> {
  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 24.h,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.background,
            borderRadius: BorderRadius.circular(
              AppSize.extraLargeRadius,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              40.r.verticalSpace,
              Text(
                s.auctionEnds,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: AppColor.kNeutrals4,
                ),
              ),
              16.h.verticalSpace,
              WBiddingHistoryItem(
                bidder: widget.bidder,
              )
            ],
          ),
        ),
        Positioned(
          top: -75.r,
          child: Lottie.asset(
            Assets.lotties.successLottie,
            repeat: false,
            width: 150.r,
            height: 150.r,
          ),
        ),
      ],
    );
  }
}
