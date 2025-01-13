part of 'update_units_bloc.dart';

@immutable
sealed class UpdateUnitsEvent {}

final class UpdateUnitButtonclickEvent extends UpdateUnitsEvent {
  final String unitId;
  final String lattitude;
  final String longitude;

  UpdateUnitButtonclickEvent({required this.unitId, required this.lattitude, required this.longitude});
}
