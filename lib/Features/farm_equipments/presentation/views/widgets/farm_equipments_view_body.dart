import 'package:flutter/material.dart';

import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/equipment_list_View.dart';

class FarmEquipmentsViewBody extends StatelessWidget {
  const FarmEquipmentsViewBody({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

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
              id: id,
            ),
            const SizedBox(
              height: 11,
            ),
          ],
        ),
      ),
    );
  }
}
