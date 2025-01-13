part of 'fetch_area_bloc.dart';

@immutable
sealed class FetchAreaState {}

final class FetchAreaInitial extends FetchAreaState {}

final class FetchAreaLoadingState extends FetchAreaState {}

final class FetchAreaSuccessState extends FetchAreaState {
  final List<AreaModel> areas;

  FetchAreaSuccessState({required this.areas});
}
final class FetchAreaWithRouteIdSuccessState extends FetchAreaState {
  final List<AreaModel> areas;

  FetchAreaWithRouteIdSuccessState({required this.areas});


}
final class FetchAreaErrorState extends FetchAreaState {
  final String message;

  FetchAreaErrorState({required this.message});
}
