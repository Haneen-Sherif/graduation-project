import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';

import 'package:graduation_project/core/utils/Widgets/custom_drawer_item.dart';
import 'package:graduation_project/core/utils/Widgets/custom_subscription_widget.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomDrawerBody extends StatelessWidget {
  const CustomDrawerBody({
    Key? key,
    required this.nameIdentifier,
  }) : super(key: key);

  final String nameIdentifier;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RatingCubit>(context).isSubscripted(nameIdentifier);

    final response = BlocProvider.of<RatingCubit>(context).isUserSubscriped;
    // print("111111111111111 is Subscriped? $response");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDrawerItem(
          onTap: () {
            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacement(AppRoutes.kHomeView);
          },
          title: 'Home',
        ),
        Divider(
          color: Color(0xffD7D5D5),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kProfileView, extra: nameIdentifier);
          },
          title: 'Profile',
        ),
        Divider(
          color: Color(0xffD7D5D5),
        ),
        const SizedBox(
          height: 30,
        ),
        // CustomDrawerItem(
        //   onTap: () {
        //     context.pop();
        //     context.push(AppRoutes.kDetectView);
        //   },
        //   title: 'Disease Detection',
        // ),
        // Divider(
        //   color: Color(0xffD7D5D5),
        // ),
        // const SizedBox(
        //   height: 30,
        // ),
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kFarmEquipmentsView, extra: nameIdentifier);
          },
          title: 'Farm Equipments',
        ),

        Divider(
          color: Color(0xffD7D5D5),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kOurTeamView);
          },
          title: 'About',
        ),
        Divider(
          color: Color(0xffD7D5D5),
        ),
        const SizedBox(
          height: 30,
        ),
        // CustomDrawerItem(
        //   onTap: () {
        //     context.pop();
        //     context.push(AppRoutes.kAllMessagesView);
        //   },
        //   title: 'Chat',
        // ),
        // Divider(
        //   color: Color(0xffD7D5D5),
        // ),
        // const SizedBox(
        //   height: 30,
        // ),
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kChatView);
          },
          title: 'Doc Bot',
        ),
        Divider(
          color: Color(0xffD7D5D5),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {
            context.pop();
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomSubscriptionWidget(
                    response: response,
                    nameIdentifier: nameIdentifier,
                  );
                });
          },
          title: 'Subscription',
        ),
        Divider(
          color: Color(0xffD7D5D5),
        ),
      ],
    );
  }
}
