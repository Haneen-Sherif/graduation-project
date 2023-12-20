import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';

class AddEquipmentsForm extends StatelessWidget {
  const AddEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.addEquipmentController,
    required this.countController,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController addEquipmentController;
  final TextEditingController countController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          children: [
            CustomTextFormField(
              controller: addEquipmentController,
              width: size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Equipment name must not be empty';
                }
                return null;
              },
              text: "Equipment Name",
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 27,
            ),
            CustomTextFormField(
              controller: countController,
              width: size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Count must not be empty';
                }
                return null;
              },
              text: "Count",
              obscureText: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            CustomButton(
              width: size.width * 0.4,
              text: "Add",
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
