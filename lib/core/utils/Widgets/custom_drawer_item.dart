import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomDrawerItem extends StatelessWidget {
  const CustomDrawerItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            Text(
              title,
              style: Styles.textStyle25.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
