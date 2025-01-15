part of 'add_measurment_bloc.dart';

@immutable
sealed class AddMeasurmentEvent {}

final class AddMeasurmentButtonclickEvent extends AddMeasurmentEvent {
  final WaterPlantDataModel datas;

  AddMeasurmentButtonclickEvent({required this.datas});
}
