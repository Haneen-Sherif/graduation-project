import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/sign_in_view.dart';
import 'package:graduation_project/Features/splash/presentation/views/splash_view.dart';

abstract class AppRoutes {
  static String kSignInView = '/signInView';
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
    ],
  );
}
