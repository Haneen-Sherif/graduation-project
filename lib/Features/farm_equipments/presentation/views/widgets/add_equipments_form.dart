import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';

class AddEquipmentsForm extends StatefulWidget {
  const AddEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.nameController,
    required this.countController,
    required this.descriptionController,
    required this.id,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController nameController;
  final TextEditingController countController;
  final TextEditingController descriptionController;
  final String id;

  @override
  State<AddEquipmentsForm> createState() => _AddEquipmentsFormState();
}

class _AddEquipmentsFormState extends State<AddEquipmentsForm> {
  final picker = ImagePicker();
  File? img;
  String? imgValidationError;
  bool isLoading = false;

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = pickedFile != null ? File(pickedFile.path) : null;
      imgValidationError = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool digitRegex = true;
    return BlocListener<EquipmentsCubit, EquipmentsState>(
        listener: (context, state) {
          if (state is EquipmentsLoading) {
            setState(() {
              isLoading = true;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
          if (state is EquipmentsSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Equipment added successfully"),
                backgroundColor: kPrimaryColor,
              ),
            );
            // BlocProvider.of<EquipmentsCubit>(context)
            //     .getAllEquipments(widget.id, widget.id);
            context.pop();
            // context.push(AppRoutes.kFarmEquipmentsView, extra: widget.id);
          } else if (state is EquipmentsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Form(
          key: widget.formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 46),
            child: Column(
              children: [
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  ),
                CustomTextFormField(
                  controller: widget.nameController,
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
                    } else if (digitRegex !=
                        RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return "The value $value is not valid for Count.";
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
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      img == null
                          ? Image.asset(Assets.imagesEquiImage)
                          : Image.file(img!),
                      if (imgValidationError != null)
                        Positioned(
                          bottom: -20,
                          right: 0,
                          child: Text(
                            imgValidationError!,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                CustomButton(
                  width: widget.size.width * 0.4,
                  text: "Add",
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      if (img == null) {
                        setState(() {
                          imgValidationError = 'Please upload an image';
                        });
                      } else {
                        widget.formKey.currentState!.save();
                        try {
                          BlocProvider.of<EquipmentsCubit>(context)
                              .addEquipment(
                                  widget.id,
                                  widget.nameController.text,
                                  widget.descriptionController.text,
                                  int.parse(widget.countController.text),
                                  img!);
                        } catch (e) {
                          print(e);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
