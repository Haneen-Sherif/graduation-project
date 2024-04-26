import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:graduation_project/Features/chat/services/chat_service.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomExpertsInfoBody extends StatefulWidget {
  const CustomExpertsInfoBody({
    super.key,
    required this.id,
    required this.ownerId,
  });

  final String id;
  final String ownerId;

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

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final name = await prefs.getString('username');

    username = name!;
    print(username);
    return username;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<RatingCubit>(context).isSubscripted(widget.ownerId);

    bool response = BlocProvider.of<RatingCubit>(context).isUserSubscriped;
    final expertsCubit = BlocProvider.of<ExpertsCubit>(context);
    final Size size = MediaQuery.sizeOf(context);
    return FutureBuilder<ExpertsModel>(
      future: expertsCubit.getExpert(widget.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: kPrimaryColor,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final expert = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.25,
                width: double.infinity,
                color: Color(0xff57ACB5),
                child: Stack(clipBehavior: Clip.none, children: [
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: BlocListener<RatingCubit, RatingState>(
                        listener: (context, state) {
                          if (state is RatingSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: kPrimaryColor,
                              ),
                            );
                          }
                        },
                        child: RatingBar.builder(
                          itemSize: 18,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(widget.ownerId);
                            print(expert.id!);
                            // When the rating changes, call the setRating method from RatingCubit
                            BlocProvider.of<RatingCubit>(context)
                                .setRating(rating, widget.ownerId, expert.id!);
                          },
                        )),
                  ),
                  Positioned(
                    bottom: -40,
                    left: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Color(0xff57ACB5),
                      radius: size.width * 0.18,
                      child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(size.width * 0.30),
                          child: Image.network(
                            expert.personalPhoto!,
                            fit: BoxFit.cover,
                            width: size.width * 0.30,
                            height: size.width * 0.30,
                          )),
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
                              if (response == true) {
                                String roomId =
                                    await ChatService.generateChatRoomId(
                                        [username, expert.userName!]);

                                context.push(
                                  AppRoutes.kRealTimeChatView,
                                  extra: {
                                    'name': roomId,
                                    'id': expert.id,
                                    'ownerId': widget.ownerId
                                  },
                                );
                              } else if (response == false) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("You have to be subscribed"),
                                  ),
                                );
                              }
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
