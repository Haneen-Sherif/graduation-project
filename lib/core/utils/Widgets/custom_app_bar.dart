import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/generated/assets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.anotherKey,
  });

  final GlobalKey<ScaffoldState> anotherKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
        color: Color(0xffF4F4F4),
        image: DecorationImage(
          image: AssetImage(Assets.imagesAppBarBG),
          fit: BoxFit.fill,
        ),
      ),
      child: ListTile(
        leading: IconButton(
            onPressed: () {
              anotherKey.currentState!.openDrawer();
            },
            icon: const Icon(
              Icons.menu,
              size: 40,
            ),
          ),
        title: Image.asset(Assets.imagesLogo_1),
      ),
    );
  }

}
