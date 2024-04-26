import 'package:flutter/material.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/upload_file.dart';

class DetectViewBody extends StatelessWidget {
  const DetectViewBody({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(children: [
            const SizedBox(
              height: 55,
            ),
            UploadFile(size: size, id: id),
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
            // HomeFooterWidget(size: size)
          ]),
        )
      ],
    );
  }
}
