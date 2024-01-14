import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kSignInView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const SignInView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kSignUpView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const SignUpView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kHomeView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const HomeView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
                  Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kDiseaseInfoView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: DiseaseInfoView(index: int.parse(state.extra.toString())),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
                  Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kAddEquipmentView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const AddEquipmentsView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kEditEquipmentView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: EditEquipmentsView(index: int.parse(state.extra.toString())),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kExpertsProfileView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: ExpertsProfileView(index: int.parse(state.extra.toString())),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kFarmEquipmentsView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const FarmEquipmentsView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
                  Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kChatView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const ChatView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
                  Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kDetectView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const DetectView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
              Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kShowResultView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const ShowResultView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
              Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
      GoRoute(
        path: kExpertsView,
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            transitionDuration: const Duration(seconds: 1),
            child: const ExpertsView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              const begin = Offset(0.0, 1.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutCirc;
              var slideTween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(slideTween);

              var fadeAnimation =
              Tween<double>(begin: 0.0, end: 1.0).animate(animation);
              var scaleAnimation =
              Tween<double>(begin: 0.5, end: 1.0).animate(animation);

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
            },
          );
        },
      ),
    ],
  );
}
