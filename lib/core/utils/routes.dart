import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/check_email_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/forgot_password_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/password_changed_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/reset_password_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/all_messages_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/chat_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/real_time_chat_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/real_time_chat_view_2.dart';
import 'package:graduation_project/Features/detection/presentation/views/detect_view.dart';
import 'package:graduation_project/Features/detection/presentation/views/show_result_view.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/disease_info_view.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/experts_profile_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/add_equipments_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/edit_equipments_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/farm_equipments_view.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view_2.dart';
import 'package:graduation_project/Features/our_team/presentation/views/our_team_view.dart';
import 'package:graduation_project/Features/profle/presentation/views/profile_view.dart';
import 'package:graduation_project/Features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static String kSignInView = '/signInView';
  static String kSignUpView = '/signUpView';
  static String kHomeView = '/homeView';
  static String kHomeView2 = '/homeView2';
  static String kDiseaseInfoView = '/diseaseInfoView/:index';
  static String kAddEquipmentView = '/addEquipmentView/:id';
  static String kEditEquipmentView = '/editEquipmentView/:id/:equipmentId';
  static String kExpertsProfileView = '/expertsProfileView/:id/:farmOwnerId';
  static String kFarmEquipmentsView = '/farmEquipmentView/:id';
  static String kChatView = '/chatView';
  static String kProfileView = '/profileView/:id';
  static String kRealTimeChatView = '/realTimeChatView/:name/:id/:ownerId';
  static String kRealTimeChatView2 = '/realTimeChatView2/:userName/:roomName';
  static String kDetectView = '/detectView/:id';
  static String kShowResultView =
      '/showResultView/:name/:per/:img/:type/:action';
  static String kExpertsView = '/expertsView';
  static String kForgotPasswordView = '/forgotPasswordView';
  static String kCheckEmailView = '/checkEmailView/:email';
  static String kResetPasswordView = '/resetPasswordView/:email/:code';
  static String kPasswordChangedView = '/passwordChangedView';
  static String kOurTeamView = '/ourTeamView';
  static String kAllMessagesView = '/allMessagesView';
  static String kMyCartView = '/myCartView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kSignInView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: SignInView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: SignUpView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kForgotPasswordView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ForgotPasswordView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kCheckEmailView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: CheckEmailView(email: state.extra.toString()),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kResetPasswordView,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String email = extras['email'].toString();
          final String code = extras['code'].toString();
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ResetPasswordView(
              email: email,
              code: code,
            ),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kPasswordChangedView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: PasswordChangedView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: HomeView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kHomeView2,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: HomeView2(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      // GoRoute(
      //   path: kMyCartView,
      //   pageBuilder: (context, state) {
      //     return const CustomTransitionPage(
      //       transitionDuration: Duration(seconds: 1),
      //       child: MyCartView(),
      //       transitionsBuilder: _buildCustomTransition1,
      //     );
      //   },
      // ),
      GoRoute(
        path: kDiseaseInfoView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: DiseaseInfoView(index: int.parse(state.extra.toString())),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kAddEquipmentView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: AddEquipmentsView(id: state.extra.toString()),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kEditEquipmentView,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String id = extras['id'].toString();
          final int equipmentId = int.parse(extras['equipmentId'].toString());
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: EditEquipmentsView(
              id: id,
              equipmentId: equipmentId,
            ),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kExpertsProfileView,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String id = extras['id'].toString();

          final String farmOwnerId = extras['farmOwnerId'].toString();
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ExpertsProfileView(
              id: id,
              farmOwnerId: farmOwnerId,
            ),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kFarmEquipmentsView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: FarmEquipmentsView(id: state.extra.toString()),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kChatView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ChatView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kProfileView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ProfileView(id: state.extra.toString()),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kRealTimeChatView,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String name = extras['name'].toString();

          final String id = extras['id'].toString();
          final String ownerId = extras['ownerId'].toString();
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: RealTimeChatView(name: name, id: id, ownerId: ownerId),
            transitionsBuilder: _buildCustomTransition1,
          );
          // return CustomTransitionPage(
          //   transitionDuration: Duration(seconds: 1),
          //   child: RealTimeChatView(id: state.extra.toString()),
          //   transitionsBuilder: _buildCustomTransition1,
          // );
        },
      ),
      GoRoute(
        path: kRealTimeChatView2,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String userName = extras['userName'].toString();

          final String roomName = extras['roomName'].toString();
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: RealTimeChatView2(
              userName: userName,
              roomName: roomName,
            ),
            transitionsBuilder: _buildCustomTransition1,
          );
          // return CustomTransitionPage(
          //   transitionDuration: Duration(seconds: 1),
          //   child: RealTimeChatView(id: state.extra.toString()),
          //   transitionsBuilder: _buildCustomTransition1,
          // );
        },
      ),
      GoRoute(
        path: kOurTeamView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: OurTeamView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kAllMessagesView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: AllMessagesView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kDetectView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: DetectView(id: state.extra.toString()),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kShowResultView,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extras =
              state.extra as Map<String, dynamic>;
          final String name = extras['name'].toString();
          final String type = extras['type'].toString();
          final List<dynamic> action = extras['action'];
          final double per = double.parse(extras['per'].toString());
          final String img = extras['img'].toString();
          return CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ShowResultView(
                name: name, per: per, img: img, type: type, action: action),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      // GoRoute(
      //   path: kExpertsView,
      //   pageBuilder: (context, state) {
      //     return const CustomTransitionPage(
      //       transitionDuration: Duration(seconds: 1),
      //       child: ExpertsView(),
      //       transitionsBuilder: _buildCustomTransition1,
      //     );
      //   },
      // ),
    ],
  );
}

Widget _buildCustomTransition1(BuildContext context,
    Animation<double> animation, Animation<double> animationTwo, Widget child) {
  const begin = Offset(0.0, 1.0);
  const end = Offset.zero;
  const curve = Curves.easeInOutCirc;

  var slideTween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(slideTween);

  var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
  var scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(animation);

  return FadeTransition(
    opacity: fadeAnimation,
    child: ScaleTransition(
      scale: scaleAnimation,
      child: SlideTransition(
        position: offsetAnimation,
        child: child,
      ),
    ),
  );
}

Widget _buildCustomTransition2(BuildContext context,
    Animation<double> animation, Animation<double> animationTwo, Widget child) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOutCirc;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
