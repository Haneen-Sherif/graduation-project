import 'package:flutter/material.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/edit_eqipments_form.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class EditEquipmentsViewBody extends StatefulWidget {
  const EditEquipmentsViewBody({super.key, required this.index});

  final int index;

  @override
  State<EditEquipmentsViewBody> createState() => _EditEquipmentsViewBodyState();
}

class _EditEquipmentsViewBodyState extends State<EditEquipmentsViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController editEquipmentController;

  late TextEditingController countController;

  @override
  void initState() {
    editEquipmentController = TextEditingController();
    countController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    editEquipmentController.dispose();
    countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Align(
              alignment: Alignment.center,
              child: CustomTitle(title: "Edit Equipments")),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.1,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: EditEquipmentsForm(
            index: widget.index,
            formKey: formKey,
            size: size,
            editEquipmentController: editEquipmentController,
            countController: countController,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 8,
          ),
        ),
        SliverToBoxAdapter(
          child: HomeFooterWidget(size: size),
        ),
      ],
    );
  }
}
