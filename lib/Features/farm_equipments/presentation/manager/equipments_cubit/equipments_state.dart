part of 'equipments_cubit.dart';

@immutable
abstract class EquipmentsState {}

class EquipmentsInitial extends EquipmentsState {}

class EquipmentsLoading extends EquipmentsState {}

class EquipmentsSuccess extends EquipmentsState {}

class EquipmentsFailure extends EquipmentsState {
  final String message;

  EquipmentsFailure({required this.message});

  List<Object> get props => [message];
}
