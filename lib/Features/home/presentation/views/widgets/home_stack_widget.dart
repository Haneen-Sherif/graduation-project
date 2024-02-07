import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class HomeStackWidget extends StatelessWidget {
  const HomeStackWidget({
    super.key,
    required this.size,
    required this.scaffoldKey,
  });

  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AspectRatio(
        aspectRatio: 0.7,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(Assets.imagesFishBG),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                ),
                title: Image.asset(
                  Assets.imagesLogo_1,
                  height: 40,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Early detection, lifelong wellness.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle30,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    AutoSizeText(
                      'Dive into our Fish Disease App.',
                      maxLines: 2,
                      style: Styles.textStyle18.copyWith(
                        color: const Color(0xFF030303),
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              CustomButton(
                width: size.width * 0.65,
                text: "Detect",
                onPressed: () {
                  context.push(AppRoutes.kDetectView);
                },
              ),
              const SizedBox(
                height: 110,
              )
            ],
          ),
        ),
      ),
    );
  }
}
