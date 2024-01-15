import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';

class EditEquipmentsForm extends StatelessWidget {
  const EditEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.editEquipmentController,
    required this.countController,
    required this.index,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController editEquipmentController;
  final TextEditingController countController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46),
        child: Column(
          children: [
            CustomTextFormField(
              controller: editEquipmentController,
              width: size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Equipment name must not be empty';
                }
                return null;
              },
              text: BlocProvider.of<EquipmentsCubit>(context)
                  .equipmentsList[index]
                  .name,
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
              text: "Edit",
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
