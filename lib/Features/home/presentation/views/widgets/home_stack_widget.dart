import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class HomeStackWidget extends StatelessWidget {
  const HomeStackWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(Assets.imagesFishBG),
        Positioned(
          top: size.height * 0.05,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                Assets.imagesLogo_1,
                height: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  size: 40,
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: size.height * 0.25,
          width: size.width * 0.9,
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Text(
              'Early detection, lifelong wellness.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Styles.textStyle30,
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.42,
          width: size.width * 0.9,
          child: Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: Text(
              'Dive into our Fish Disease App.',
              maxLines: 1,
              style: Styles.textStyle18.copyWith(
                color: const Color(0xFF030303),
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.55,
          left: size.width * 0.18,
          child: CustomButton(
            width: size.width * 0.65,
            text: "Detect",
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
