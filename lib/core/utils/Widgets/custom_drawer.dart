import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/social_media_row.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer_body.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.15,
                vertical: size.height * 0.1,
              ),
              child: Text(
                'Welcome',
                style: Styles.textStyle35,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: const CustomDrawerBody(),
            ),
            CustomButton(
              width: size.width * 0.7,
              text: "Log Out",
              onPressed: () {},
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    Assets.imagesLogo_1,
                    width: size.width * 0.4,
                  ),
                  SocialMediaRow(
                    iconColor: kPrimaryColor,
                    borderColor: kPrimaryColor.withOpacity(0.25),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
