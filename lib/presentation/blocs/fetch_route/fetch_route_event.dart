part of 'fetch_route_bloc.dart';

@immutable
sealed class FetchRouteEvent {}
final class FetchRouteInitialEvent extends FetchRouteEvent{}