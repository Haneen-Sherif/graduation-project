import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class EditEquipmentsView extends StatefulWidget {
  const EditEquipmentsView({super.key, required this.index});

  final int index;

  @override
  State<EditEquipmentsView> createState() => _EditEquipmentsViewState();
}

class _EditEquipmentsViewState extends State<EditEquipmentsView> {
  GlobalKey<ScaffoldState> editEquipmentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: editEquipmentKey,
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: CustomAppBar(
              anotherKey: editEquipmentKey,
            )),
        body: BlocProvider(
          create: (context) => EquipmentsCubit(),
          child: EditEquipmentsViewBody(index: widget.index),
        ),
      ),
    );
  }
}
