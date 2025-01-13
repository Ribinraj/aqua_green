part of 'fetch_unit_bloc.dart';

@immutable
sealed class FetchUnitEvent {}

final class FetchUnitInitialEvent extends FetchUnitEvent {}

final class FetchUnitWithRouteIdandAreaId extends FetchUnitEvent {
  final String routeId;
  final String areaId;

  FetchUnitWithRouteIdandAreaId({required this.routeId, required this.areaId});
}
