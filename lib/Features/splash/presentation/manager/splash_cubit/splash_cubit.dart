import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SplashCubit extends Cubit<double> {
  SplashCubit() : super(0.0);

  void startAnimation(BuildContext context) async {
    for (double opacity = 0.1; opacity <= 1.0; opacity += 0.1) {
      emit(opacity);
      await Future.delayed(
        const Duration(milliseconds: 200),
      );
    }
    // context.pushReplacement(AppRoutes.kSignInView);
  }
}