import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/farm_equipments_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class FarmEquipmentsView extends StatefulWidget {
  const FarmEquipmentsView({super.key});

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
            child: CustomAppBar(
              anotherKey: farmKey,
            )),
        body: BlocProvider(
          create: (context) => EquipmentsCubit(),
          child: const FarmEquipmentsViewBody(),
        ),
      ),
    );
  }
}
