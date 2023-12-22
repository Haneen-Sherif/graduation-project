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
  TextEditingController addEquipmentController = TextEditingController();
  TextEditingController countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Align(
              alignment: Alignment.center,
              child: CustomTitle(title: "Add Equipments")),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: size.height * 0.1,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: AddEquipmentsForm(
            formKey: formKey,
            size: size,
            addEquipmentController: addEquipmentController,
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
        )
      ],
    );
  }
}
