import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/farm_equipments/data/models/equipments_model.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsState> {
  EquipmentsCubit() : super(EquipmentsInitial());

  final List<EquipmentsModel> equipmentsList = [
    const EquipmentsModel(
      image: Assets.imagesEqui1,
      name: "Optical Dissolved Oxygen Meter",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      count: 4,
    ),
    const EquipmentsModel(
      image: Assets.imagesEqui2,
      name: "Dissolved Oxygen Meter",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      count: 5,
    ),
    const EquipmentsModel(
      image: Assets.imagesEqui1,
      name: "Optical Dissolved Oxygen Meter",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      count: 8,
    ),
    const EquipmentsModel(
      image: Assets.imagesEqui2,
      name: "Dissolved Oxygen Meter",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      count: 0,
    ),
  ];
}
