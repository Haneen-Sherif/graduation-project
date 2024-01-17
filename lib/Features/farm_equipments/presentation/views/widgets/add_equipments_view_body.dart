import 'package:flutter/material.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/add_equipments_form.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class AddEquipmentsViewBody extends StatefulWidget {
  const AddEquipmentsViewBody({super.key});

  @override
  State<AddEquipmentsViewBody> createState() => _AddEquipmentsViewBodyState();
}

class _AddEquipmentsViewBodyState extends State<AddEquipmentsViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController addEquipmentController;
  late TextEditingController countController;

  @override
  void initState() {
    addEquipmentController = TextEditingController();
    countController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addEquipmentController.dispose();
    countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 57,
          ),
        ),
        const SliverToBoxAdapter(
          child: Align(
              alignment: Alignment.center,
              child: CustomTitle(title: "Add Equipments")),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 71,
          ),
        ),
        SliverToBoxAdapter(
          // hasScrollBody: false,
          child: AddEquipmentsForm(
            formKey: formKey,
            size: size,
            addEquipmentController: addEquipmentController,
            countController: countController,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 16,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: HomeFooterWidget(size: size),
        )
      ],
    );
  }
}
