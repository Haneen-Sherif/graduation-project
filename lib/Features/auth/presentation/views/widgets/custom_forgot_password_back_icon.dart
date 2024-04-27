import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/generated/assets.dart';

class CustomForgotPasswordBackIcon extends StatelessWidget {
  const CustomForgotPasswordBackIcon({
    super.key,
    this.color,
    this.onTap,
  });

  final Color? color;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap ?? context.pop();
      },
      child: SizedBox(
        width: 39,
        height: 39,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 39,
                height: 39,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFFD8DADC),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child:
                    Image.asset(Assets.iconsBack, color: color ?? Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
