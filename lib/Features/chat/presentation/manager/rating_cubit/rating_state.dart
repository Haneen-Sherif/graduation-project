part of 'rating_cubit.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingSuccess extends RatingState {
  final String message;

  RatingSuccess({required this.message});

  List<Object> get props => [message];
}

class RatingCalcSuccess extends RatingState {
  final int rateCount;

  RatingCalcSuccess({required this.rateCount});

  List<Object> get props => [rateCount];
}

class RatingFailure extends RatingState {
  final String message;

  RatingFailure({required this.message});

  List<Object> get props => [message];
}
