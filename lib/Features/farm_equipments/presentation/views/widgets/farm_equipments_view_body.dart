import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/farm_equipments/data/models/equipments_model.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/custom_farm_equipment_item.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/routes.dart';

class FarmEquipmentsViewBody extends StatelessWidget {
  const FarmEquipmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<EquipmentsModel> equipmentsList =
        BlocProvider.of<EquipmentsCubit>(context).equipmentsList;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomTitle(title: "Farm Equipments"),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.delete,
                size: 96,
              ),
              const SizedBox(
                height: 12,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: equipmentsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 46),
                    child: CustomFarmEquipmentItem(
                      text: equipmentsList[index].name,
                      delete: () {},
                      edit: () {
                        context.push(
                          AppRoutes.kEditEquipmentView,
                          extra: index,
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 84,
              ),
              CustomButton(
                width: size.width * 0.4,
                text: "Add",
                onPressed: () {
                  context.push(AppRoutes.kAddEquipmentView);
                },
              ),
              const SizedBox(
                height: 84,
              ),
              HomeFooterWidget(size: size)
            ],
          ),
        ),
      ),
    );
  }
}
