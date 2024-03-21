part of 'experts_cubit.dart';

@immutable
abstract class ExpertsState {}

class ExpertsInitial extends ExpertsState {}

class ExpertsLoading extends ExpertsState {}

class ExpertsSuccess extends ExpertsState {}

class ExpertsFailure extends ExpertsState {
  final String message;

  ExpertsFailure({required this.message});

  List<Object> get props => [message];
}
