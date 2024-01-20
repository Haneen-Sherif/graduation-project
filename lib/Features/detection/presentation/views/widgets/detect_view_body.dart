import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/upload_file.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class DetectViewBody extends StatelessWidget {
  const DetectViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(children: [
            const SizedBox(
              height: 40,
            ),
            Text('Image Upload', style: Styles.textStyle27),
            const SizedBox(
              height: 55,
            ),
            UploadFile(size: size),
            const SizedBox(
              height: 40,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 38),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: kPrimaryColor.withOpacity(0.16),
              ),
              child: Row(
                children: [
                  Image.asset(Assets.imagesGallery),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      height: 1,
                      decoration: BoxDecoration(
                        color: const Color(0xff5A5D95),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  Image.asset(Assets.imagesCheckmark)
                ],
              ),
            ),
            const SizedBox(
              height: 56,
            ),
            CustomButton(
              color: const Color(0xff59595E),
              width: size.width * 0.6,
              text: "Show Result",
              onPressed: () {
                context.push(AppRoutes.kShowResultView);
              },
            ),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(children: [
            const Expanded(
              child: SizedBox(
                height: 56,
              ),
            ),
            HomeFooterWidget(size: size)
          ]),
        )
      ],
    );
  }
}
