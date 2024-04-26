import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/farm_equipments_view_body.dart';
import 'package:graduation_project/constants.dart';

import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/routes.dart';

class FarmEquipmentsView extends StatefulWidget {
  const FarmEquipmentsView({super.key, required this.id});

  final String id;

  @override
  State<FarmEquipmentsView> createState() => _FarmEquipmentsViewState();
}

class _FarmEquipmentsViewState extends State<FarmEquipmentsView> {
  GlobalKey<ScaffoldState> farmKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: farmKey,
        floatingActionButton: FloatingActionButton(
          backgroundColor: kPrimaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            context.push(
              AppRoutes.kAddEquipmentView,
              extra: widget.id,
            );
          },
        ),
        // drawer: const CustomDrawer(),
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Farm Equipments"),
          centerTitle: true,
        ),

        body: FarmEquipmentsViewBody(id: widget.id),
      ),
    );
  }
}
