part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class VerificationLoading extends AuthState {}

class VerificationSuccess extends AuthState {}

class ChangedSuccess extends AuthState {}

class VerificationFailure extends AuthState {
  final String message;

  VerificationFailure({required this.message});

  List<Object> get props => [message];
}

class AuthSuccess extends AuthState {
  final String message;

  AuthSuccess({required this.message});

  List<Object> get props => [message];
}

class LoginSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  List<Object> get props => [message];
}
