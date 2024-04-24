import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpertsProfileViewBody extends StatefulWidget {
  const ExpertsProfileViewBody({
    super.key,
    required this.id,
    required this.farmOwnerId,
  });

  final String id;
  final String farmOwnerId;

  @override
  State<ExpertsProfileViewBody> createState() => _ExpertsProfileViewBodyState();
}

class _ExpertsProfileViewBodyState extends State<ExpertsProfileViewBody> {
  String ownerId = '';
  Future<void> getOwnerId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the tokens from shared preferences
    final accessToken = await prefs.getString('accessToken');
    // final refreshToken = prefs.getString('refreshToken');

    // String decodedPayload = "";

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
    print("nameIdentifier $nameIdentifier");
    setState(() {
      ownerId = nameIdentifier;
    });
  }

  @override
  void initState() {
    getOwnerId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 26),
          child: CustomExpertsInfoBody(
            id: widget.id,
            ownerId: ownerId,
          ),
          // ),
        ),
        // SliverFillRemaining(
        //   hasScrollBody: false,
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: const SizedBox(
        //           height: 12,
        //         ),
        //       ),
        //       HomeFooterWidget(size: size)
        //     ],
        //   ),
        // )
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
