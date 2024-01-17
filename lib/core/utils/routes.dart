import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/check_email_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/forgot_password_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/password_changed_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/reset_password_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/chat_view.dart';
import 'package:graduation_project/Features/detection/presentation/views/detect_view.dart';
import 'package:graduation_project/Features/detection/presentation/views/show_result_view.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/disease_info_view.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/experts_profile_view.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/experts_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/add_equipments_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/edit_equipments_view.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/farm_equipments_view.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view.dart';
import 'package:graduation_project/Features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static String kSignInView = '/signInView';
  static String kSignUpView = '/signUpView';
  static String kHomeView = '/homeView';
  static String kDiseaseInfoView = '/diseaseInfoView/:index';
  static String kAddEquipmentView = '/addEquipmentView';
  static String kEditEquipmentView = '/editEquipmentView/:index';
  static String kExpertsProfileView = '/expertsProfileView/:index';
  static String kFarmEquipmentsView = '/farmEquipmentView';
  static String kChatView = '/chatView';
  static String kDetectView = '/detectView';
  static String kShowResultView = '/showResultView';
  static String kExpertsView = '/expertsView';
  static String kForgotPasswordView = '/forgotPasswordView';
  static String kCheckEmailView = '/checkEmailView';
  static String kResetPasswordView = '/resetPasswordView';
  static String kPasswordChangedView = '/passwordChangedView';
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
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: CheckEmailView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kResetPasswordView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ResetPasswordView(),
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
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: AddEquipmentsView(),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kEditEquipmentView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: EditEquipmentsView(index: int.parse(state.extra.toString())),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kExpertsProfileView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: ExpertsProfileView(index: int.parse(state.extra.toString())),
            transitionsBuilder: _buildCustomTransition2,
          );
        },
      ),
      GoRoute(
        path: kFarmEquipmentsView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: FarmEquipmentsView(),
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
        path: kDetectView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: DetectView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kShowResultView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ShowResultView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
      GoRoute(
        path: kExpertsView,
        pageBuilder: (context, state) {
          return const CustomTransitionPage(
            transitionDuration: Duration(seconds: 1),
            child: ExpertsView(),
            transitionsBuilder: _buildCustomTransition1,
          );
        },
      ),
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
