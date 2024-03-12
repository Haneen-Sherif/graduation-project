import 'package:flutter/material.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/add_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
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
            child: CustomAppBar(
              anotherKey: addEquipmentKey,
            )),
        body: AddEquipmentsViewBody(id: widget.id),
      ),
    );
  }
}
