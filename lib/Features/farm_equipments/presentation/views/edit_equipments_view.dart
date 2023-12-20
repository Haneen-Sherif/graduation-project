import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_equipments_view_body.dart';

class EditEquipmentsView extends StatelessWidget {
  const EditEquipmentsView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EquipmentsCubit(),
        child: EditEquipmentsViewBody(index: index),
      ),
    );
  }
}
