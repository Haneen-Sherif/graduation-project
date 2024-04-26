import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';

import 'package:graduation_project/core/utils/Widgets/custom_drawer_item.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomDrawerBody2 extends StatelessWidget {
  const CustomDrawerBody2({
    Key? key,
    required this.nameIdentifier,
  }) : super(key: key);

  final String nameIdentifier;

  @override
  Widget build(BuildContext context) {
    final response = BlocProvider.of<RatingCubit>(context).isUserSubscriped;
    print(response);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDrawerItem(
          onTap: () {
            while (context.canPop()) {
              context.pop();
            }
            context.pushReplacement(AppRoutes.kHomeView2);
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
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kDetectView);
          },
          title: 'Disease Detection',
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
        CustomDrawerItem(
          onTap: () {
            context.pop();
            context.push(AppRoutes.kAllMessagesView);
          },
          title: 'Chat',
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
        // CustomDrawerItem(
        //   onTap: () {
        //     context.pop();
        //     showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return Dialog(
        //             elevation: 0,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.only(
        //                     topLeft: Radius.circular(20),
        //                     topRight: Radius.circular(20))), //this right here
        //             child: Column(
        //               mainAxisSize: MainAxisSize.min,
        //               children: [
        //                 Container(
        //                   width: double.infinity,
        //                   decoration: BoxDecoration(
        //                     borderRadius: BorderRadius.only(
        //                         topLeft: Radius.circular(20),
        //                         topRight: Radius.circular(20)),
        //                     color: kPrimaryColor,
        //                   ),
        //                   child: Padding(
        //                     padding: const EdgeInsets.symmetric(
        //                         horizontal: 50, vertical: 25),
        //                     child: Text(
        //                       "Subscription Plan",
        //                       style: Styles.textStyle15(context).copyWith(
        //                           fontWeight: FontWeight.w600,
        //                           color: Colors.white),
        //                     ),
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 48,
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.symmetric(horizontal: 8),
        //                   child: Column(
        //                     children: [
        //                       Container(
        //                         decoration: BoxDecoration(
        //                             border:
        //                                 Border.all(color: Color(0xffE4E4E4)),
        //                             borderRadius: BorderRadius.circular(40),
        //                             color: Colors.white,
        //                             boxShadow: [
        //                               BoxShadow(
        //                                   blurRadius: 4,
        //                                   offset: Offset(0, 4),
        //                                   spreadRadius: 0,
        //                                   color: Color(0xff26323814)
        //                                       .withOpacity(0.8))
        //                             ]),
        //                         padding: EdgeInsets.symmetric(
        //                             horizontal: 10, vertical: 4),
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Text(
        //                               "20 Detections",
        //                               style: Styles.textStyle12(context)
        //                                   .copyWith(color: Color(0xff131925)),
        //                             ),
        //                             Row(
        //                               children: [
        //                                 Text(
        //                                   r"$",
        //                                   style: Styles.textStyle12(context)
        //                                       .copyWith(
        //                                           fontWeight: FontWeight.w700),
        //                                 ),
        //                                 Text(
        //                                   "15",
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold),
        //                                 )
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 22,
        //                       ),
        //                       Container(
        //                         decoration: BoxDecoration(
        //                             border:
        //                                 Border.all(color: Color(0xffE4E4E4)),
        //                             borderRadius: BorderRadius.circular(40),
        //                             color: Colors.white,
        //                             boxShadow: [
        //                               BoxShadow(
        //                                   blurRadius: 4,
        //                                   offset: Offset(0, 4),
        //                                   spreadRadius: 0,
        //                                   color: Color(0xff26323814)
        //                                       .withOpacity(0.8))
        //                             ]),
        //                         padding: EdgeInsets.symmetric(
        //                             horizontal: 10, vertical: 4),
        //                         child: Row(
        //                           mainAxisAlignment:
        //                               MainAxisAlignment.spaceBetween,
        //                           children: [
        //                             Text(
        //                               "20 consultations",
        //                               style: Styles.textStyle12(context)
        //                                   .copyWith(color: Color(0xff131925)),
        //                             ),
        //                             Row(
        //                               children: [
        //                                 Text(
        //                                   r"$",
        //                                   style: Styles.textStyle12(context)
        //                                       .copyWith(
        //                                           fontWeight: FontWeight.w700),
        //                                 ),
        //                                 Text(
        //                                   "15",
        //                                   style: TextStyle(
        //                                       fontWeight: FontWeight.bold),
        //                                 )
        //                               ],
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         height: 96,
        //                       ),
        //                       CustomButton(
        //                         width: double.infinity,
        //                         text: "Get Started",
        //                         onPressed: () {
        //                           if (response == "false") {
        //                             context.pop();
        //                             showModalBottomSheet(
        //                                 context: context,
        //                                 shape: RoundedRectangleBorder(
        //                                     borderRadius:
        //                                         BorderRadius.circular(16)),
        //                                 builder: (context) {
        //                                   return BlocProvider(
        //                                     create: (context) => PaymentCubit(
        //                                         CheckoutRepoImpl()),
        //                                     child: PaymentMethodsBottomSheet(
        //                                         id: nameIdentifier),
        //                                   );
        //                                 });
        //                           } else {
        //                             context.pop();
        //                             ScaffoldMessenger.of(context).showSnackBar(
        //                               SnackBar(
        //                                 content:
        //                                     Text("You are already subscribed"),
        //                               ),
        //                             );
        //                           }
        //                         },
        //                       ),
        //                     ],
        //                   ),
        //                 ),
        //                 SizedBox(
        //                   height: 17,
        //                 ),
        //                 Text(
        //                   "Or start Free Trial",
        //                   style: Styles.textStyle11(context),
        //                 ),
        //                 SizedBox(
        //                   height: 19,
        //                 ),
        //               ],
        //             ),
        //           );
        //         });
        //   },
        //   title: 'Subscription',
        // ),
        // Divider(
        //   color: Color(0xffD7D5D5),
        // ),
      ],
    );
  }
}
