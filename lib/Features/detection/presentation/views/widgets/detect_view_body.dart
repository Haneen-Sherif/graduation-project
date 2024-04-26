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
          child: UploadFile(size: size, id: id),
        ),
      ],
    );
  }
}
