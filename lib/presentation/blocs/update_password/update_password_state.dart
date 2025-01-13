part of 'update_password_bloc.dart';

@immutable
sealed class UpdatePasswordState {}

final class UpdatePasswordInitial extends UpdatePasswordState {}

final class UpdatePasswordLoadingState extends UpdatePasswordState {}

final class UpdatePasswordSuccessState extends UpdatePasswordState {
  
}

final class UpdatepasswordErrorState extends UpdatePasswordState {
  final String message;

  UpdatepasswordErrorState({required this.message});
}
