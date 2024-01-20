import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFarmEquipmentItem extends StatelessWidget {
  const CustomFarmEquipmentItem({
    super.key,
    required this.text,
    required this.delete,
    required this.edit, required this.count,
  });

  final String text;
  final String count;
  final void Function() delete;
  final void Function() edit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Row(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: Styles.textStyle16.copyWith(
                letterSpacing: 0.96,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Container(
              width: 19,
              height: 19,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(side: BorderSide(width: 1)),
              ),
              child: Center(
                child: Text(
                  count,
                  style: Styles.textStyle12.copyWith(
                    letterSpacing: 0.72,
                  ),
                ),
              ),
            ),
          ],
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
