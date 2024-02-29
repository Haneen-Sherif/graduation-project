import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';

class AddEquipmentsForm extends StatefulWidget {
  const AddEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.addEquipmentController,
    required this.countController,
    required this.descriptionController,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController addEquipmentController;
  final TextEditingController countController;
  final TextEditingController descriptionController;

  @override
  State<AddEquipmentsForm> createState() => _AddEquipmentsFormState();
}

class _AddEquipmentsFormState extends State<AddEquipmentsForm> {
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
              controller: widget.addEquipmentController,
              width: widget.size.width,
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
              text: "Count",
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
              text: "Description",
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
                  ? Image.asset(Assets.imagesEquiImage)
                  : Image.file(img!),
            ),
            const SizedBox(
              height: 38,
            ),
            CustomButton(
              width: widget.size.width * 0.4,
              text: "Add",
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
