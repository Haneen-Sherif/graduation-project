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
    return SafeArea(
      child: Column(
        children: [
          const CustomTitle(title: "Add Equipments"),
          SizedBox(
            height: size.height * 0.1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: AddEquipmentsForm(
                formKey: formKey,
                size: size,
                addEquipmentController: addEquipmentController,
                countController: countController,
              ),
            ),
          ),
          HomeFooterWidget(size: size),
        ],
      ),
    );
  }
}
