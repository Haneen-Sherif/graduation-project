import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/Features/chat/presentation/views/chat_view.dart';
import 'package:graduation_project/Features/home/presentation/views/home_view.dart';
import 'package:graduation_project/Features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static String kSignInView = '/signInView';
  static String kSignUpView = '/signUpView';
  static String kHomeView = '/homeView';
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        // builder: (context, state) => const SplashView(),
        builder: (context, state) => const ChatView(),
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
    ],
  );
}
