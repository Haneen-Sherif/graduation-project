import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/splash/presentation/manager/splash_cubit/splash_cubit.dart';
import 'package:graduation_project/Features/splash/presentation/views/widgets/custom_splash_text.dart';
import 'package:graduation_project/generated/assets.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: _SplashViewBody(),
    );
  }
}

class _SplashViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<SplashCubit>().startAnimation(context);
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<SplashCubit, double>(
            builder: (context, opacity) {
              return AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(milliseconds: 2000),
                child: Image.asset(Assets.imagesDecoration),
              );
            },
          ),
          Column(
            children: [
              BlocBuilder<SplashCubit, double>(
                builder: (context, opacity) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 2000),
                    child: Image.asset(Assets.imagesLogo_1),
                  );
                },
              ),
              const SizedBox(
                height: 42,
              ),
              BlocBuilder<SplashCubit, double>(
                builder: (context, opacity) {
                  return AnimatedOpacity(
                    opacity: opacity,
                    duration: const Duration(milliseconds: 2000),
                    child: Center(
                      child: SizedBox(
                        width: width * 0.7,
                        child: Image.asset(Assets.imagesSplash),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 60,
              ),
              BlocBuilder<SplashCubit, double>(
                builder: (context, opacity) {
                  return AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(milliseconds: 2000),
                      child: CustomSplashText(width: width));
                },
              ),
              const SizedBox(
                height: 60,
              ),
              // BlocBuilder<SplashCubit, double>(
              //   builder: (context, opacity) {
              //     return AnimatedOpacity(
              //       opacity: opacity,
              //       duration: const Duration(milliseconds: 2000),
              //       child: CustomButton(
              //         onPressed: () {
              //           context.push(
              //             AppRoutes.kSignInView,
              //           );
              //         },
              //         width: width * 0.8,
              //         text: 'Start',
              //       ),
              //     );
              //   },
              // ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
