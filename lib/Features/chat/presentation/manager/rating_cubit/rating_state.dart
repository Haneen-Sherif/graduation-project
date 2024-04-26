part of 'rating_cubit.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSetLoading extends RatingState {}

class RatingCalcLoading extends RatingState {}

class SubscribeLoading extends RatingState {}

class IsSubscribedLoading extends RatingState {}

class IsSubscibedSuccess extends RatingState {}

class IsNotSubscibedSuccess extends RatingState {}

class RatingSuccess extends RatingState {
  final String message;

  RatingSuccess({required this.message});

  List<Object> get props => [message];
}

class RatingSetSuccess extends RatingState {
  final String message;

  RatingSetSuccess({required this.message});

  List<Object> get props => [message];
}

class SubscribeSuccess extends RatingState {
  final String message;

  SubscribeSuccess({required this.message});

  List<Object> get props => [message];
}

class RatingCalcSuccess extends RatingState {}

class RatingFailure extends RatingState {
  final String message;

  RatingFailure({required this.message});

  List<Object> get props => [message];
}

class RatingSetFailure extends RatingState {
  final String message;

  RatingSetFailure({required this.message});

  List<Object> get props => [message];
}

class RatingCalcFailure extends RatingState {
  final String message;

  RatingCalcFailure({required this.message});

  List<Object> get props => [message];
}

class SubscribeFailure extends RatingState {
  final String message;

  SubscribeFailure({required this.message});

  List<Object> get props => [message];
}

class IsSubscribedFailure extends RatingState {
  final String message;

  IsSubscribedFailure({required this.message});

  List<Object> get props => [message];
}
