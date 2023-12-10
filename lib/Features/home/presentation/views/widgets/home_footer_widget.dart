import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/social_media_row.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class HomeFooterWidget extends StatelessWidget {
  const HomeFooterWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.imagesDecoration_2),
        Positioned(
          top: size.height * 0.01,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Image.asset(
                Assets.imagesLogo_1,
                width: 120,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        '©FishShield \nAll Rights Reserved. ',
                        textAlign: TextAlign.center,
                        style: Styles.textStyle10.copyWith(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      const SocialMediaRow()
                    ],
                  ),
                  ClipOval(
                    child: Image.asset(
                      Assets.imagesFrancesco,
                      width: 80,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
