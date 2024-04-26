import 'package:flutter/material.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_eqipments_form.dart';

class EditEquipmentsViewBody extends StatefulWidget {
  const EditEquipmentsViewBody(
      {super.key, required this.id, required this.equipmentId});

  final String id;
  final int equipmentId;

  @override
  State<EditEquipmentsViewBody> createState() => _EditEquipmentsViewBodyState();
}

class _EditEquipmentsViewBodyState extends State<EditEquipmentsViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController editEquipmentController;
  late TextEditingController countController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    editEquipmentController = TextEditingController();
    countController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editEquipmentController.dispose();
    countController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 71,
          ),
        ),
        SliverToBoxAdapter(
          child: EditEquipmentsForm(
            equipmentId: widget.equipmentId,
            descriptionController: descriptionController,
            id: widget.id,
            formKey: formKey,
            size: size,
            editEquipmentController: editEquipmentController,
            countController: countController,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(
                  height: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
