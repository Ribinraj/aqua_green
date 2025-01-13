part of 'fetch_area_bloc.dart';

@immutable
sealed class FetchAreaEvent {}

final class FetchAreaInitialEvent extends FetchAreaEvent {}

final class FetchAreaWithRouteId extends FetchAreaEvent {
  final String routeId;

  FetchAreaWithRouteId({required this.routeId});
}
