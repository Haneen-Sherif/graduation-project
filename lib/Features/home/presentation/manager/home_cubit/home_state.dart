part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeMessageSuccess extends HomeState {
  final String message;

  HomeMessageSuccess({required this.message});

  List<Object> get props => [message];
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});

  List<Object> get props => [message];
}
