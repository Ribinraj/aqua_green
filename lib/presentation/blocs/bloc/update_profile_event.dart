part of 'update_profile_bloc.dart';

@immutable
sealed class UpdateProfileEvent {}

final class UpdateProfileButtonclickEvent extends UpdateProfileEvent {
  final String fullname;
  final String password;

  UpdateProfileButtonclickEvent({required this.fullname, required this.password});
}
