import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomExpertsInfoBody extends StatefulWidget {
  const CustomExpertsInfoBody({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<CustomExpertsInfoBody> createState() => _CustomExpertsInfoBodyState();
}

class _CustomExpertsInfoBodyState extends State<CustomExpertsInfoBody>
    with WidgetsBindingObserver {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String username = '';
  @override
  void initState() {
    super.initState();
    getName();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(username)
        .update({'status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  // Map<String, dynamic>? userMap;
  String chatRoomId(String user1, String user2) {
    // if (user1.isEmpty || user2.isEmpty) {
    //   print("user1: $user1");
    //   print("user2: $user2");
    //   return '';
    // }

    String firstCharUser1 = user1[0].toLowerCase();
    String firstCharUser2 = user2[0].toLowerCase();

    if (firstCharUser1.codeUnitAt(0) > firstCharUser2.codeUnitAt(0)) {
      print("$user1$user2");
      return "$user1$user2";
    } else {
      print("$user1$user2");
      return "$user2$user1";
    }
  }

  // String chatRoomId(String user1, String user2) {
  //   if (user1[0].toLowerCase().codeUnits[0] >
  //       user2.toLowerCase().codeUnits[0]) {
  //     return "$user1$user2";
  //   } else {
  //     return "$user2$user1";
  //   }
  // }

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final name = await prefs.getString('username');

    username = name!;
    print(username);
    return username;
  }

  @override
  Widget build(BuildContext context) {
    final expertsCubit = BlocProvider.of<ExpertsCubit>(context);
    return FutureBuilder<ExpertsModel>(
      future: expertsCubit.getExpert(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final expert = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 153,
                width: double.infinity,
                color: Color(0xff57ACB5),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                    bottom: -75,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff57ACB5),
                      radius: 90,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(153),
                          child: Image.network(expert.personalPhoto!)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16, left: 21, right: 21),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomForgotPasswordBackIcon(
                          color: Colors.white,
                        ),
                        GestureDetector(
                            onTap: () async {
                              String roomId =
                                  await chatRoomId(username, expert.userName!);

                              context.push(
                                AppRoutes.kRealTimeChatView,
                                extra: {
                                  'name': roomId,
                                  'id': expert.id,
                                },
                              );
                            },
                            child: Image.asset(Assets.iconsChat))
                      ],
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 100,
              ),
              // const Align(
              //   alignment: Alignment.center,
              //   child: CustomTitle(title: "Experts Contacts"),
              // ),
              // const SizedBox(
              //   height: 56,
              // ),

              // CustomExpertsInfo(
              //   // expertsList: expertsList,
              //   id: widget.id,
              //   title: 'Age : ',
              //   subTitle: expert.age.toString(),
              // ),
              // const SizedBox(
              //   height: 14,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomExpertsInfo(
                      // expertsList: expertsList,
                      id: widget.id,
                      title: 'Name : ',
                      subTitle: expert.userName!,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomExpertsInfo(
                      id: widget.id,
                      title: 'From : ',
                      subTitle: expert.address!,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CustomExpertsInfo(
                      id: widget.id,
                      title: 'Email : ',
                      subTitle: expert.email!,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Professional information :",
                      style: Styles.textStyle12(context).copyWith(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff979799)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(expert.moreInfo!,
                          style: Styles.textStyle15(context)
                              .copyWith(color: Colors.black.withOpacity(0.78))),
                    ),
                  ],
                ),
              ),

              // CustomExpertsInfo(
              //   id: id,
              //   title: 'mobile : ',
              //   subTitle: expert.phoneNumber!,
              // ),
              // const SizedBox(
              //   height: 14,
              // ),

              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Expanded(
              //       flex: 5,
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           CustomExpertsInfo(
              //             // expertsList: expertsList,
              //             id: id,
              //             title: 'Name : ',
              //             subTitle: expert.userName!,
              //           ),
              //           const SizedBox(
              //             height: 14,
              //           ),
              //           // CustomExpertsInfo(
              //           //   // expertsList: expertsList,
              //           //   id: widget.id,
              //           //   title: 'Age : ',
              //           //   subTitle: expert.age.toString(),
              //           // ),
              //           const SizedBox(
              //             height: 14,
              //           ),
              //           CustomExpertsInfo(
              //             id: id,
              //             title: 'From : ',
              //             subTitle: expert.address!,
              //           ),
              //           const SizedBox(
              //             height: 14,
              //           ),
              //           CustomExpertsInfo(
              //             id: id,
              //             title: 'mobile : ',
              //             subTitle: expert.phoneNumber!,
              //           ),
              //           const SizedBox(
              //             height: 14,
              //           ),
              //           CustomExpertsInfo(
              //             id: id,
              //             title: 'Email : ',
              //             subTitle: expert.email!,
              //           ),
              //           const SizedBox(
              //             height: 22,
              //           )
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 27,
              //     ),
              //     Expanded(
              //       flex: 4,
              //       child: Image.network(expert.personalPhoto!),
              //     )
              //   ],
              // ),
            ],
          );
        }
      },
    );
  }
}
