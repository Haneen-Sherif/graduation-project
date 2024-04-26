import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:graduation_project/Features/home/presentation/views/widgets/experts_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_container.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/fish_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_stack_widget.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getName();
    getOwnerId();
    super.initState();
  }

  String username = '';
  String farmOwnerId = '';

  Future<void> getOwnerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final accessToken = await prefs.getString('accessToken');

    List<String> parts = accessToken!.split('.');
    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }
    // print(payload);
    // print(payloadMap[
    //     'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier']);

    String nameIdentifier = payloadMap[
        'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'];
    // print("nameIdentifier $nameIdentifier");
    setState(() {
      farmOwnerId = nameIdentifier;
    });
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final name = await prefs.getString('username');

    username = name!;
    // print("username: $username");
    return username;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    setState(() {});
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeStackWidget(
                size: size,
                scaffoldKey: widget.scaffoldKey,
                farmOwnerId: farmOwnerId),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 18,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "Fish Diseases",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle24(context).copyWith(
                    color: Color(0xff1D2B4F),
                  ),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: Styles.textStyle12(context)
                      .copyWith(color: Color(0xff636E88)),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 74,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 94,
              width: 74,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 79,
                    color: kPrimaryColor,
                  ),
                  Positioned(
                    top: -40,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 94,
                      child: FishListView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 18,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "Specialists",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle24(context)
                      .copyWith(color: Color(0xff1D2B4F)),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: Styles.textStyle12(context)
                      .copyWith(color: Color(0xff636E88)),
                )
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 95,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              width: 79,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 79,
                    color: kPrimaryColor,
                  ),
                  Positioned(
                    top: -70,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 122,
                      child: ExpertsListView(
                        farmOwnerId: farmOwnerId,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "Feedback",
              textAlign: TextAlign.center,
              style: Styles.textStyle24(context)
                  .copyWith(color: Color(0xff1D2B4F)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: FeedbackContainer(),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Exit App',
              ),
              content: const Text(
                'Do you want to close the app?',
              ),
              actions: <Widget>[
                _buildDialogButton(context, 'No', false),
                _buildDialogButton(context, 'Yes', true),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildDialogButton(BuildContext context, String text, bool value) {
    return TextButton(
      onPressed: () async {
        if (value) {
          while (context.canPop()) {
            context.pop();
          }
          await _firestore
              .collection('users')
              .doc(username)
              .update({'status': 'Offline'});
          exit(0);
        } else {
          Navigator.pop(context);
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: kPrimaryColor),
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
