part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure({required this.message});

  List<Object> get props => [message];
}
