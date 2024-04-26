import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/farm_equipments/data/models/equipments_model.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:image_picker/image_picker.dart';

class EditEquipmentsForm extends StatefulWidget {
  const EditEquipmentsForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.id,
    required this.equipmentId,
    this.editEquipmentController,
    this.countController,
    this.descriptionController,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final TextEditingController? editEquipmentController;
  final TextEditingController? countController;
  final TextEditingController? descriptionController;
  final String id;
  final int equipmentId;

  @override
  State<EditEquipmentsForm> createState() => _EditEquipmentsFormState();
}

class _EditEquipmentsFormState extends State<EditEquipmentsForm> {
  final picker = ImagePicker();
  File? img;
  String? imgValidationError;
  Future<EquipmentsModel>? _futureEquipment;
  bool isLoading = false;

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        img = File(pickedFile.path);
        imgValidationError = null;
      });
    }
  }

  @override
  void initState() {
    _futureEquipment = _fetchEquipment();
    super.initState();
  }

  Future<EquipmentsModel> _fetchEquipment() async {
    return await BlocProvider.of<EquipmentsCubit>(context)
        .getEquipment(widget.id, widget.equipmentId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EquipmentsModel>(
      future: _futureEquipment,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: kPrimaryColor,
          ));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final equipment = snapshot.data!;
          return _buildForm(equipment);
        }
      },
    );
  }

  Widget _buildForm(EquipmentsModel equipment) {
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
              content: Text("Equipment updated successfully"),
              backgroundColor: kPrimaryColor,
            ),
          );

          context.pop();
        } else if (state is EquipmentsFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: Form(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 46),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              Text(
                "Equipment Name",
                style: Styles.textStyle15(context),
              ),
              SizedBox(
                height: 9,
              ),
              CustomTextFormField(
                controller: widget.editEquipmentController,
                width: widget.size.width,
                hintText: equipment.name,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Count",
                style: Styles.textStyle15(context),
              ),
              SizedBox(
                height: 9,
              ),
              CustomTextFormField(
                controller: widget.countController,
                width: widget.size.width,
                hintText: equipment.count.toString(),
                obscureText: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                "Discription",
                style: Styles.textStyle15(context),
              ),
              SizedBox(
                height: 9,
              ),
              CustomTextFormField(
                controller: widget.descriptionController,
                width: widget.size.width,
                hintText: equipment.description,
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    pickImage();
                  },
                  child: Stack(
                    children: [
                      img == null
                          ? Image.network(equipment.photoPath!)
                          : Image.file(img!),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              Center(
                child: CustomButton(
                  width: widget.size.width * 0.4,
                  text: "Edit",
                  onPressed: () {
                    String? newEquipmentName =
                        widget.editEquipmentController?.text == ''
                            ? equipment.name
                            : widget.editEquipmentController?.text;
                    String? newDescription =
                        widget.descriptionController?.text == ''
                            ? equipment.description
                            : widget.descriptionController?.text;
                    int newCount = widget.countController!.text == ''
                        ? int.parse(equipment.count.toString())
                        : int.parse(widget.countController!.text);

                    if (newEquipmentName != equipment.name ||
                        newDescription != equipment.description ||
                        newCount != equipment.count ||
                        img != null) {
                      BlocProvider.of<EquipmentsCubit>(context).editEquipment(
                        widget.id,
                        newEquipmentName,
                        newDescription,
                        newCount,
                        img ?? File(equipment.photoPath!),
                        widget.equipmentId,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("There are no changes to update"),
                      ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
