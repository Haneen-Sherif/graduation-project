import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/equipment_list_View.dart';

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
    // final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 26,
            ),
            // const SliverToBoxAdapter(
            //   child: Column(children: [
            //     CustomTitle(title: "Farm Equipments"),
            //     SizedBox(
            //       height: 26,
            //     ),
            //   ]),
            // ),

            EquipmentListView(
              id: widget.id,
            ),

            // SliverFillRemaining(
            //     child: EquipmentListView(
            //   id: widget.id,
            // )),

            Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              // const SizedBox(
              //   height: 56,
              // ),
              // CustomButton(
              //   width: size.width * 0.6,
              //   text: "Add Equipment",
              //   onPressed: () {
              //     context.push(
              //       AppRoutes.kAddEquipmentView,
              //       extra: widget.id,
              //     );
              //   },
              // ),
              const SizedBox(
                height: 11,
              ),
            ]),
            // SliverToBoxAdapter(
            //   child: Padding(
            //     padding: const EdgeInsets.only(right: 16),
            //     child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.end,
            //         children: [
            //           CustomButton(
            //             width: size.width * 0.6,
            //             text: "Add Equipment",
            //             onPressed: () {
            //               context.push(
            //                 AppRoutes.kAddEquipmentView,
            //                 extra: widget.id,
            //               );
            //             },
            //           ),
            //           const SizedBox(
            //             height: 11,
            //           ),
            //         ]),
            //   ),
            // ),
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Column(children: [
            //     const Expanded(
            //       child: SizedBox(
            //         height: 16,
            //       ),
            //     ),
            //     HomeFooterWidget(size: size)
            //   ]),
            // )
          ],
        ),
      ),
    );
  }
}
