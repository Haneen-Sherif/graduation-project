import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_up_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:graduation_project/Features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static String kSignInView = '/signInView';
  static String kSignUpView = '/signUpView';
  static String kHomeView = '/homeView';
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
            transitionDuration: const Duration(seconds: 5),
            key: state.pageKey,
            child: const SignInView(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              return FadeTransition(
                opacity:
                    CurveTween(curve: Curves.easeInOutCirc).animate(animation),
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
            child: const HomeViewBody(),
            transitionsBuilder: (context, animation, animationTwo, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
}
