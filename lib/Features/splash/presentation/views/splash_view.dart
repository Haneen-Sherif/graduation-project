import 'package:flutter/material.dart';
import 'package:graduation_project/Features/splash/presentation/views/widgets/splash_view_body.dart';
import 'package:graduation_project/constants.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      backgroundColor: kSecondaryColor,
      body: SplashViewBody(),
    );
  }
}
