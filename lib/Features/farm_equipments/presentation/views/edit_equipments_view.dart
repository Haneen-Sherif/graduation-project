import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class EditEquipmentsView extends StatelessWidget {
  const EditEquipmentsView({
    Key? key,
    required this.id,
    required this.equipmentId,
  }) : super(key: key);

  final int equipmentId;
  final String id;

  @override
  Widget build(BuildContext context) {
    print("EditEquipmentsView: Build method called");
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Edit Equipments"),
          centerTitle: true,
        ),
        body: EditEquipmentsViewBody(
          id: id,
          equipmentId: equipmentId,
        ),
      ),
    );
  }
}
