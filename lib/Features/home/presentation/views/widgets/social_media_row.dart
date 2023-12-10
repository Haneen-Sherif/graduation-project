import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_project/core/utils/Widgets/custom_social_icon.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSocialIcon(
          onPressed: () {},
          borderColor: Colors.white.withOpacity(0.25),
          icon: FontAwesomeIcons.facebookF,
          iconColor: Colors.white,
        ),
        CustomSocialIcon(
          onPressed: () {},
          borderColor: Colors.white.withOpacity(0.25),
          icon: FontAwesomeIcons.linkedinIn,
          iconColor: Colors.white,
        ),
        CustomSocialIcon(
          onPressed: () {},
          borderColor: Colors.white.withOpacity(0.25),
          icon: FontAwesomeIcons.twitter,
          iconColor: Colors.white,
        ),
      ],
    );
  }
}
