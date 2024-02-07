import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/social_media_row.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer_body.dart';
import 'package:graduation_project/core/utils/routes.dart';
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
              padding: const EdgeInsets.symmetric(
                vertical: 56,
              ),
              child: Text(
                'Welcome',
                style: Styles.textStyle35,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: CustomDrawerBody(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
              child: CustomButton(
                width: size.width,
                text: "Log Out",
                onPressed: () async {
                  await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Exit App',
                          style: TextStyle(color: kSecondaryColor),
                        ),
                        content: const Text(
                          'Do you want to close the app?',
                          style: TextStyle(color: kSecondaryColor),
                        ),
                        backgroundColor: kPrimaryColor,
                        actions: <Widget>[
                          _buildDialogButton(context, 'No', false),
                          _buildDialogButton(context, 'Yes', true),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 34, left: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: FittedBox(
                      child: Image.asset(
                        Assets.imagesLogo_1,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Expanded(
                    flex: 3,
                    child: FittedBox(
                      child: SocialMediaRow(
                        iconColor: kPrimaryColor,
                        borderColor: kPrimaryColor.withOpacity(0.25),
                      ),
                    ),
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

  Widget _buildDialogButton(BuildContext context, String text, bool value) {
    return TextButton(
      onPressed: () {
        if (value) {
          while (context.canPop()) {
            context.pop();
          }
          context.pushReplacement(AppRoutes.kSignInView);
        } else {
          Navigator.pop(context);
        }
      },
      child: Text(
        text,
        style: const TextStyle(color: kSecondaryColor),
      ),
    );
  }
}
