part of 'add_measurment_bloc.dart';

@immutable
sealed class AddMeasurmentState {}

final class AddMeasurmentInitial extends AddMeasurmentState {}

final class AddMeasurmentLoadingState extends AddMeasurmentState {}

final class AddMeasurmentSuccessState extends AddMeasurmentState {}

final class AddMeasurmentErrorState extends AddMeasurmentState {
  final String message;

  AddMeasurmentErrorState({required this.message});
}
