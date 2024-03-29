import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_equipments_view_body.dart';

import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class EditEquipmentsView extends StatefulWidget {
  const EditEquipmentsView(
      {super.key, required this.id, required this.equipmentId});

  final int equipmentId;
  final String id;

  @override
  State<EditEquipmentsView> createState() => _EditEquipmentsViewState();
}

class _EditEquipmentsViewState extends State<EditEquipmentsView> {
  GlobalKey<ScaffoldState> editEquipmentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("EditEquipmentsView: Build method called");
    return SafeArea(
      child: Scaffold(
        key: editEquipmentKey,
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
              padding: EdgeInsets.only(left: 21, top: 16),
              child: CustomForgotPasswordBackIcon()),
          // child: CustomAppBar(
          //   anotherKey: editEquipmentKey,
          // )
        ),
        body: EditEquipmentsViewBody(
            id: widget.id, equipmentId: widget.equipmentId),
      ),
    );
  }
}
