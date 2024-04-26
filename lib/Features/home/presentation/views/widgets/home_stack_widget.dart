import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/detect_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeStackWidget extends StatefulWidget {
  const HomeStackWidget({
    super.key,
    required this.size,
    required this.scaffoldKey,
  });

  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomeStackWidget> createState() => _HomeStackWidgetState();
}

class _HomeStackWidgetState extends State<HomeStackWidget> {
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

    bool response = BlocProvider.of<RatingCubit>(context).isUserSubscriped;
    setState(() {});
    return AspectRatio(
      aspectRatio: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.imagesFishBG),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    widget.scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                title: Image.asset(
                  Assets.imagesLogo_1,
                  height: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Early detection, lifelong wellness.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle30(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    AutoSizeText(
                      'Dive into our Fish Disease App.',
                      maxLines: 2,
                      style: Styles.textStyle18(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              FittedBox(
                child: DetectButton(
                  space: 16,
                  myWidget: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff349caa),
                              borderRadius: BorderRadius.circular(26)),
                          height: 26,
                          width: 26,
                          child: Image.asset(Assets.iconsRight),
                        ),
                      ],
                    ),
                  ),
                  color: Color(0xff087ca8),
                  text: "Detect",
                  onPressed: () {
                    setState(() {});
                    if (response == true) {
                      context.push(AppRoutes.kDetectView,
                          extra: nameIdentifier);
                    } else if (response == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You have to be subscribed"),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 55,
              )
            ],
          ),
        ),
      ),
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
