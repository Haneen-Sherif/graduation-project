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
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: Column(children: [
                SizedBox(
                  height: 57,
                ),
                CustomTitle(title: "Farm Equipments"),
                SizedBox(
                  height: 74,
                ),
              ]),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomButton(
                        width: size.width * 0.6,
                        text: "Add Equipment",
                        onPressed: () {
                          context.push(AppRoutes.kAddEquipmentView);
                        },
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                    ]),
              ),
            ),
            SliverList.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 16,
              ),
              itemCount: equipmentsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomFarmEquipmentItem(
                    image: equipmentsList[index].image,
                    count: equipmentsList[index].count.toString(),
                    title: equipmentsList[index].name,
                    subTitle: equipmentsList[index].description,
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
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                const Expanded(
                  child: SizedBox(
                    height: 16,
                  ),
                ),
                HomeFooterWidget(size: size)
              ]),
            )
          ],
        ),
      ),
    );
  }
}
