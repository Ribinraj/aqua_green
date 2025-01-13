part of 'fetch_unit_bloc.dart';

@immutable
sealed class FetchUnitState {}

final class FetchUnitInitial extends FetchUnitState {}
final class FetchUnitLoadingState extends FetchUnitState {}

final class FetchUnitSuccessState extends FetchUnitState {
  final List<UnitModel> units;

  FetchUnitSuccessState({required this.units});
}
final class FetchUnitWithRouteIdandAreaIdSuccessState extends FetchUnitState {
  final List<UnitModel> units;

  FetchUnitWithRouteIdandAreaIdSuccessState({required this.units});


}
final class FetchUnitErrorState extends FetchUnitState {
  final String message;

  FetchUnitErrorState({required this.message});
}