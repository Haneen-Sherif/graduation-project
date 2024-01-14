import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer_item.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomDrawerBody extends StatelessWidget {
  const CustomDrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDrawerItem(
          onTap: () {},
          title: 'Disease Detection',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {
            context.push(AppRoutes.kFarmEquipmentsView);
          },
          title: 'Farm Equipments',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {},
          title: 'Disease Reports',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {},
          title: 'Fish Information',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {},
          title: 'Awarness',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {},
          title: 'EMP Existence',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {},
          title: 'About',
        ),
        const SizedBox(
          height: 30,
        ),
        CustomDrawerItem(
          onTap: () {
            context.push(AppRoutes.kChatView);
          },
          title: 'Q&A , Chat',
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}