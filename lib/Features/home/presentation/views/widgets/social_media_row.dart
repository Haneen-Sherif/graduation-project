import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation_project/core/utils/Widgets/custom_social_icon.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    super.key,
    required this.borderColor,
    required this.iconColor,
  });

  final Color borderColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomSocialIcon(
          onPressed: () {},
          borderColor: borderColor,
          icon: FontAwesomeIcons.facebookF,
          iconColor: iconColor,
        ),
        CustomSocialIcon(
          onPressed: () {},
          borderColor: borderColor,
          icon: FontAwesomeIcons.linkedinIn,
          iconColor: iconColor,
        ),
        CustomSocialIcon(
          onPressed: () {},
          borderColor: borderColor,
          icon: FontAwesomeIcons.twitter,
          iconColor: iconColor,
        ),
      ],
    );
  }
}
