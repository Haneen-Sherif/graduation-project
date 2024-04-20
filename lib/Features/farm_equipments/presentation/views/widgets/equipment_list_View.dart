import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/manager/equipments_cubit/equipments_cubit.dart';
import 'package:graduation_project/Features/farm_equipments/presentation/views/widgets/custom_farm_equipment_item.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';

class EquipmentListView extends StatefulWidget {
  const EquipmentListView({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<EquipmentListView> createState() => _EquipmentListViewState();
}

class _EquipmentListViewState extends State<EquipmentListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentsCubit, EquipmentsState>(
        builder: (context, state) {
      print("EquipmentListView: Builder function called with state: $state");
      if (state is EquipmentsLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is EquipmentsSuccess) {
        final equipments =
            BlocProvider.of<EquipmentsCubit>(context).equipmentsList;

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
            crossAxisSpacing: 16,
          ),
          itemCount: equipments.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xffFFF9F9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.25),
                                  offset: Offset(0, 4))
                            ]),
                        child: CustomFarmEquipmentItem(
                            image: equipments[index].photoPath!,
                            count: equipments[index].count.toString(),
                            title: equipments[index].name!,
                            subTitle: equipments[index].description!,
                            delete: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return new AlertDialog(
                                    title: new Text("Delete Item"),
                                    backgroundColor: Colors.white,
                                    elevation: 0,
                                    surfaceTintColor: Colors.white,
                                    content: new Text(
                                        "Are you sure you want to permanently delete this item?"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Cancel',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          BlocProvider.of<EquipmentsCubit>(
                                                  context)
                                              .deleteEquipment(widget.id,
                                                  equipments[index].id!)
                                              .then((_) {
                                            setState(() {});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                backgroundColor: kPrimaryColor,
                                                content: Text(
                                                    'Equipment deleted successfully'),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          }).catchError((error) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Failed to delete equipment: $error'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          });
                                        },
                                        child: Text(
                                          'Delete',
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            edit: () {
                              context
                                  .push(AppRoutes.kEditEquipmentView, extra: {
                                'id': widget.id,
                                'equipmentId': equipments[index].id,
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                )
              ],
            );
          },
        );
        // // return Column(
        // //   children: equipments.map((equipment) {
        // //     return Padding(
        // //       padding:
        // //           const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        // //       child: CustomFarmEquipmentItem(
        // //         image: equipment.photoPath!,
        //         count: equipment.count.toString(),
        //         title: equipment.name!,
        //         subTitle: equipment.description!,
        //         delete: () {
        //           showDialog(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return new AlertDialog(
        //                 title: new Text("Confirm delete"),
        //                 content: new Text(
        //                     "Are you sure you want to delete this equipment?"),
        //                 actions: <Widget>[
        //                   TextButton(
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     child: Text('No'),
        //                   ),
        //                   TextButton(
        //                     onPressed: () {
        //                       BlocProvider.of<EquipmentsCubit>(context)
        //                           .deleteEquipment(widget.id, equipment.id!)
        //                           .then((_) {
        //                         setState(() {});
        //                         ScaffoldMessenger.of(context).showSnackBar(
        //                           SnackBar(
        //                             content:
        //                                 Text('Equipment deleted successfully'),
        //                           ),
        //                         );
        //                         Navigator.of(context).pop();
        //                       }).catchError((error) {
        //                         ScaffoldMessenger.of(context).showSnackBar(
        //                           SnackBar(
        //                             content: Text(
        //                                 'Failed to delete equipment: $error'),
        //                             backgroundColor: Colors.red,
        //                           ),
        //                         );
        //                       });
        //                     },
        //                     child: Text('Yes'),
        //                   ),
        //                 ],
        //               );
        //             },
        //           );
        //         },
        //         edit: () {
        //           context.push(AppRoutes.kEditEquipmentView, extra: {
        //             'id': widget.id,
        //             'equipmentId': equipment.id,
        //           });
        //           print("eeeeeeeeeeeeeeeeee${equipment.id}");
        //         },
        //       ),
        //     );
        //   }).toList(),
        // );
      } else if (state is EquipmentsFailure) {
        return Center(
          child: Text('Failed to load diseases: ${state.message}'),
        );
      } else {
        final diseases =
            BlocProvider.of<EquipmentsCubit>(context).getAllEquipments;

        print("=====================");
        print(diseases);
        print("=====================");
        final diseases2 =
            BlocProvider.of<EquipmentsCubit>(context).equipmentsList;

        print("=====================");
        print(diseases2);
        print("=====================");
        return Container();
      }
    });
  }
}
