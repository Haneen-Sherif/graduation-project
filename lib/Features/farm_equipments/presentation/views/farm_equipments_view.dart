import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/farm_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

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
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
              padding: EdgeInsets.only(top: 16, left: 21),
              child: CustomForgotPasswordBackIcon()),
          // child: CustomAppBar(
          //   anotherKey: farmKey,
          // )
        ),
        body: FarmEquipmentsViewBody(id: widget.id),
      ),
    );
  }
}
