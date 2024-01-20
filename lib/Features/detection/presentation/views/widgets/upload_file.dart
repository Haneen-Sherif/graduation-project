import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UploadFile extends StatelessWidget {
  const UploadFile({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 38),
      padding: const EdgeInsets.all(38),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E5E5),
        border: const DashedBorder.fromBorderSide(
          dashLength: 8,
          side: BorderSide(color: Color(0x7F585EC7), width: 3),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            Assets.imagesUpload,
          ),
          const SizedBox(
            height: 61,
          ),
          CustomButton(
            width: size.width * 0.6,
            text: "Import Image",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}