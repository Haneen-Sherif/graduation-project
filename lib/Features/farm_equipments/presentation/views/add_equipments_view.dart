import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/add_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class AddEquipmentsView extends StatelessWidget {
  const AddEquipmentsView({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Add Equipments"),
          centerTitle: true,
        ),
        body: AddEquipmentsViewBody(id: id),
      ),
    );
  }
}
