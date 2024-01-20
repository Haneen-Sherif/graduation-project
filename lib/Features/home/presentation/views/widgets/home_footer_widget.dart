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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Assets.imagesDecoration_2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Image.asset(
              Assets.imagesLogo_1,
              width: size.width * 0.5,
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
                    const SizedBox(
                      height: 6,
                    ),
                    SocialMediaRow(
                      borderColor: Colors.white.withOpacity(0.25),
                      iconColor: Colors.white,
                    )
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
    );
  }
}
