import 'package:flutter/material.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/add_equipments_form.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class AddEquipmentsViewBody extends StatefulWidget {
  const AddEquipmentsViewBody({super.key, required this.id});

  final String id;

  @override
  State<AddEquipmentsViewBody> createState() => _AddEquipmentsViewBodyState();
}

class _AddEquipmentsViewBodyState extends State<AddEquipmentsViewBody> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController countController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    nameController = TextEditingController();
    countController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    countController.dispose();
    descriptionController.dispose();
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
            child: CustomTitle(title: "Add Equipments"),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 71,
          ),
        ),
        SliverToBoxAdapter(
          // hasScrollBody: false,
          child: AddEquipmentsForm(
            id: widget.id,
            descriptionController: descriptionController,
            formKey: formKey,
            size: size,
            nameController: nameController,
            countController: countController,
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(
                  height: 16,
                ),
              ),
              // HomeFooterWidget(size: size),
            ],
          ),
        )
      ],
    );
  }
}
