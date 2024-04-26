import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';

import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';

import 'package:graduation_project/core/utils/Widgets/custom_drawer_item.dart';
import 'package:graduation_project/core/utils/Widgets/custom_subscription_widget.dart';
import 'package:graduation_project/core/utils/routes.dart';

import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawerBody extends StatefulWidget {
  const CustomDrawerBody({
    super.key,
  });

  @override
  State<CustomDrawerBody> createState() => _CustomDrawerBodyState();
}

class _CustomDrawerBodyState extends State<CustomDrawerBody> {
  String nameIdentifier = '';
  Future<void> getId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final accessToken = prefs.getString('accessToken');

    List<String> parts = accessToken!.split('.');
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    print(payload);
    print(payloadMap[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']);

    nameIdentifier = payloadMap[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    setState(() {});
  }

  @override
  void initState() {
    getId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RatingCubit>(context).isSubscripted(nameIdentifier);

    final response = BlocProvider.of<RatingCubit>(context).isUserSubscriped;
    print("111111111111111 is Subscriped? $response");
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
          onTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            final accessToken = prefs.getString('accessToken');

            List<String> parts = accessToken!.split('.');
            final payload = _decodeBase64(parts[1]);
            final payloadMap = json.decode(payload);
            if (payloadMap is! Map<String, dynamic>) {
              throw Exception('invalid payload');
            }
            print(payload);
            print(payloadMap[
                'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']);

            String nameIdentifier = payloadMap[
                'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

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
          onTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            final accessToken = prefs.getString('accessToken');

            List<String> parts = accessToken!.split('.');
            final payload = _decodeBase64(parts[1]);
            final payloadMap = json.decode(payload);
            if (payloadMap is! Map<String, dynamic>) {
              throw Exception('invalid payload');
            }
            print(payload);
            print(payloadMap[
                'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']);

            String nameIdentifier = payloadMap[
                'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];

            BlocProvider.of<EquipmentsCubit>(context)
                .getAllEquipments(nameIdentifier, nameIdentifier);
            setState(() {});

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

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
