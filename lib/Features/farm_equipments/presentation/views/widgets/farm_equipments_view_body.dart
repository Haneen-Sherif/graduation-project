import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/equipment_list_View.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/routes.dart';

class FarmEquipmentsViewBody extends StatefulWidget {
  const FarmEquipmentsViewBody({super.key, required this.id});

  final String id;

  @override
  State<FarmEquipmentsViewBody> createState() => _FarmEquipmentsViewBodyState();
}

class _FarmEquipmentsViewBodyState extends State<FarmEquipmentsViewBody> {
  @override
  void initState() {
    print(widget.id);
    print(
        "listttttttttt${BlocProvider.of<EquipmentsCubit>(context).equipmentsList}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          context.push(
                            AppRoutes.kAddEquipmentView,
                            extra: widget.id,
                          );
                        },
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                    ]),
              ),
            ),

            SliverToBoxAdapter(
                child: EquipmentListView(
              id: widget.id,
            )),
            // }
            //   },
            // ),
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
