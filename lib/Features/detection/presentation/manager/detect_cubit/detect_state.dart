part of 'detect_cubit.dart';

@immutable
abstract class DetectState {}

class DetectInitial extends DetectState {}

class DetectLoading extends DetectState {}

class DetectSuccess extends DetectState {}

class DetectFailure extends DetectState {
  final String message;

  DetectFailure({required this.message});

  List<Object> get props => [message];
}
