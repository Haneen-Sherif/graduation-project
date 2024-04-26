import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/farm_equipments_view_body.dart';
import 'package:graduation_project/constants.dart';

import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/routes.dart';

class FarmEquipmentsView extends StatelessWidget {
  const FarmEquipmentsView({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    print(id);
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            context.push(
              AppRoutes.kAddEquipmentView,
              extra: id,
            );
          },
        ),
        // drawer: const CustomDrawer(),
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Farm Equipments"),
          centerTitle: true,
        ),

        body: FarmEquipmentsViewBody(id: id),
      ),
    );
  }
}
