import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/add_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class AddEquipmentsView extends StatefulWidget {
  const AddEquipmentsView({super.key, required this.id});

  final String id;

  @override
  State<AddEquipmentsView> createState() => _AddEquipmentsViewState();
}

class _AddEquipmentsViewState extends State<AddEquipmentsView> {
  GlobalKey<ScaffoldState> addEquipmentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: addEquipmentKey,
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
              padding: EdgeInsets.only(left: 21, top: 16),
              child: CustomForgotPasswordBackIcon()),
        ),
        body: AddEquipmentsViewBody(id: widget.id),
      ),
    );
  }
}
