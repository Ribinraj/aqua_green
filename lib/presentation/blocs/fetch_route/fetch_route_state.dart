part of 'fetch_route_bloc.dart';

@immutable
sealed class FetchRouteState {}

final class FetchRouteInitial extends FetchRouteState {}

final class FetchRouteLoadingState extends FetchRouteState {}

final class FetchRouteSuccessState extends FetchRouteState {
  final List<RouteModel> routes;

  FetchRouteSuccessState({required this.routes});
}

final class FetchRouteErrorState extends FetchRouteState {
  final String message;

  FetchRouteErrorState({required this.message});
}
