import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/equipment_list_View.dart';

class FarmEquipmentsViewBody extends StatefulWidget {
  const FarmEquipmentsViewBody({super.key, required this.id});

  final String id;

  @override
  State<FarmEquipmentsViewBody> createState() => _FarmEquipmentsViewBodyState();
}

class _FarmEquipmentsViewBodyState extends State<FarmEquipmentsViewBody> {
  @override
  void initState() {
    print(widget.id);
    print(
        "listttttttttt${BlocProvider.of<EquipmentsCubit>(context).equipmentsList}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 26,
            ),
            EquipmentListView(
              id: widget.id,
            ),
            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              const SizedBox(
                height: 11,
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
