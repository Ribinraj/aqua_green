part of 'update_units_bloc.dart';

@immutable
sealed class UpdateUnitsState {}

final class UpdateUnitsInitial extends UpdateUnitsState {}

final class UpdateUnitLoadingState extends UpdateUnitsState {}

final class UpdateUnitSuccessState extends UpdateUnitsState {
  final String message;

  UpdateUnitSuccessState({required this.message});
}

final class UpdateUnitErrorState extends UpdateUnitsState {
  final String message;

  UpdateUnitErrorState({required this.message});
}
