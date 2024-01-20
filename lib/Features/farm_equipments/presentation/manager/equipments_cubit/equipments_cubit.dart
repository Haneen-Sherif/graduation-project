import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/farm_equipments/data/models/equipments_model.dart';
import 'package:meta/meta.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsState> {
  EquipmentsCubit() : super(EquipmentsInitial());

  final List<EquipmentsModel> equipmentsList = [
    const EquipmentsModel(
      name: "Equi1",
      count: 4,
    ),
    const EquipmentsModel(
      name: "Equi2",
      count: 5,
    ),
    const EquipmentsModel(
      name: "Equi3",
      count: 8,
    ),
    const EquipmentsModel(
      name: "Equi4",
      count: 0,
    ),
  ];
}
