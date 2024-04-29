part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {}

class UpdateSuccess extends ProfileState {
  final String message;

  UpdateSuccess({required this.message});

  List<Object> get props => [message];
}

class ProfileFailure extends ProfileState {
  final String message;

  ProfileFailure({required this.message});

  List<Object> get props => [message];
}
