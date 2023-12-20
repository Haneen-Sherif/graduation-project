import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFarmEquipmentItem extends StatelessWidget {
  const CustomFarmEquipmentItem({
    super.key,
    required this.size,
    required this.text,
    required this.delete,
    required this.edit,
  });

  final Size size;
  final String text;
  final void Function() delete;
  final void Function() edit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: Styles.textStyle16.copyWith(
              letterSpacing: 0.96,
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: delete,
                child: const Icon(
                  Icons.delete,
                ),
              ),
              const SizedBox(
                width: 17,
              ),
              GestureDetector(
                onTap: edit,
                child: const Icon(
                  Icons.edit,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
