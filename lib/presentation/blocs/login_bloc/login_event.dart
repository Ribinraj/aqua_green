part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginButtonClickingEvent extends LoginEvent {
  final String mobielnumber;
  final String password;

  LoginButtonClickingEvent({required this.mobielnumber, required this.password});
}
