part of 'update_password_bloc.dart';

@immutable
sealed class UpdatePasswordEvent {}

final class UpdatePasswordButtonClickEvent extends UpdatePasswordEvent {
  final String userId;
  final String password;

  UpdatePasswordButtonClickEvent({required this.userId, required this.password});
}
