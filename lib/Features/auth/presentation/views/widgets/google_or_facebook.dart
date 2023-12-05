import 'package:flutter/material.dart';
import 'package:graduation_project/generated/assets.dart';

class GoogleOrFaceBook extends StatelessWidget {
  const GoogleOrFaceBook({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Image.asset(Assets.imagesGoogle),
        ),
        const SizedBox(
          width: 60,
        ),
        InkWell(
          onTap: () {},
          child: Image.asset(Assets.imagesFaceBook),
        )
      ],
    );
  }
}
