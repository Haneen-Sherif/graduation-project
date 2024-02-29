import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';

class EditEquipmentsForm extends StatefulWidget {
  const EditEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.editEquipmentController,
    required this.countController,
    required this.index,
    required this.descriptionController,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController editEquipmentController;
  final TextEditingController countController;
  final TextEditingController descriptionController;
  final int index;

  @override
  State<EditEquipmentsForm> createState() => _EditEquipmentsFormState();
}

class _EditEquipmentsFormState extends State<EditEquipmentsForm> {
  final picker = ImagePicker();
  File? img;

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 46),
        child: Column(
          children: [
            CustomTextFormField(
              controller: widget.editEquipmentController,
              width: widget.size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Equipment name must not be empty';
                }
                return null;
              },
              hintText: BlocProvider.of<EquipmentsCubit>(context)
                  .equipmentsList[widget.index]
                  .name,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              controller: widget.countController,
              width: widget.size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Count must not be empty';
                }
                return null;
              },
              hintText: BlocProvider.of<EquipmentsCubit>(context)
                  .equipmentsList[widget.index]
                  .count
                  .toString(),
              obscureText: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomTextFormField(
              controller: widget.descriptionController,
              width: widget.size.width,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description must not be empty';
                }
                return null;
              },
              hintText: BlocProvider.of<EquipmentsCubit>(context)
                  .equipmentsList[widget.index]
                  .description,
              obscureText: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: img == null
                  ? Image.asset(BlocProvider.of<EquipmentsCubit>(context)
                      .equipmentsList[widget.index]
                      .image)
                  : Image.file(img!),
            ),
            const SizedBox(
              height: 38,
            ),
            CustomButton(
              width: widget.size.width * 0.4,
              text: "Edit",
              onPressed: () {
                if (widget.formKey.currentState!.validate()) {
                  widget.formKey.currentState!.save();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
