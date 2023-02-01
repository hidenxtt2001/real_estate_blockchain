import 'package:dartz/dartz.dart' as z;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_blockchain/config/app_color.dart';
import 'package:real_estate_blockchain/config/app_size.dart';
import 'package:real_estate_blockchain/data/message/domain/entities/chat_room/chat_room.dart';
import 'package:real_estate_blockchain/feature/app/module.dart';
import 'package:real_estate_blockchain/feature/core/application/application.dart';
import 'package:real_estate_blockchain/feature/core/module.dart';
import 'package:real_estate_blockchain/feature/core/presentation/widgets/w_error.dart';
import 'package:real_estate_blockchain/languages/languages.dart';
import 'package:real_estate_blockchain/utils/utils.dart';

import '../module.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final s = S.of(context);
    return Scaffold(
      appBar: CustomAppbar(
        context,
        title: Text(s.message),
      ),
      body: SingleChildScrollView(
        child: BlocSelector<MessageBloc, MessageState,
            z.Tuple2<List<ChatRoom>, Status>>(
          selector: (state) {
            return z.Tuple2(state.rooms, state.status);
          },
          builder: (context, tuple2) {
            final rooms = tuple2.value1;
            final status = tuple2.value2;

            return status.maybeWhen(
              failure: (_) {
                return WError(message: _);
              },
              loading: () {
                return const WLoading();
              },
              idle: () {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(vertical: AppSize.extraWidthDimens),
                  itemBuilder: (context, index) {
                    final item = rooms[index];
                    return MessagePersonItem(
                      onPressed: () {
                        context.push($appRoute.messageChat, extra: {
                          "bloc": context.read<MessageBloc>(),
                          "room": item,
                        });
                      },
                      room: item,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      indent: AppSize.extraWidthDimens,
                      endIndent: AppSize.extraWidthDimens,
                      thickness: 1.r,
                      height: 0,
                      color: AppColor.kBorderColor(
                          context.watch<AppBloc>().state.mode),
                    );
                  },
                  itemCount: rooms.length,
                );
              },
              orElse: () {
                return kEmpty;
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
