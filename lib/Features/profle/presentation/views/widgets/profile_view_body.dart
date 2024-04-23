import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/generated/assets.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 153,
            width: double.infinity,
            color: Color(0xff57ACB5),
            child: Stack(clipBehavior: Clip.none, children: [
              // Positioned(
              //   bottom: -75,
              //   left: 0,
              //   right: 0,
              //   child: CircleAvatar(
              //     backgroundColor: Color(0xff57ACB5),
              //     radius: 90,
              //     child: ClipRRect(
              //         borderRadius: BorderRadius.circular(153),
              //         child: Image.network(expert.personalPhoto!)),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 21, right: 21),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomForgotPasswordBackIcon(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 100,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: new Text("Delete Account"),
                            backgroundColor: Colors.white,
                            elevation: 0,
                            surfaceTintColor: Colors.white,
                            content: new Text(
                                "Are you sure you want to delete account ?"),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  try {
                                    BlocProvider.of<AuthCubit>(context)
                                        .deleteAccount(id);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: kPrimaryColor,
                                        content: Text(
                                            'Account deleted successfully'),
                                      ),
                                    );
                                    context.pop();
                                    context
                                        .pushReplacement(AppRoutes.kSignInView);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Image.asset(Assets.iconsDeleteAccount))
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
      ),
    );
  }
}
