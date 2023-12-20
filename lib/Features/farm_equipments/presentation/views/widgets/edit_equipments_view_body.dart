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
  TextEditingController editEquipmentController = TextEditingController();
  TextEditingController countController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
        children: [
          const CustomTitle(title: "Edit Equipments"),
          SizedBox(
            height: size.height * 0.1,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: EditEquipmentsForm(
                index: widget.index,
                formKey: formKey,
                size: size,
                editEquipmentController: editEquipmentController,
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
