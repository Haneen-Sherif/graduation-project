import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/farm_equipments_view_body.dart';

class FarmEquipmentsView extends StatelessWidget {
  const FarmEquipmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => EquipmentsCubit(),
        child: const FarmEquipmentsViewBody(),
      ),
    );
  }
}
