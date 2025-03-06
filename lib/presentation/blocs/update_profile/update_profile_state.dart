part of 'update_profile_bloc.dart';

@immutable
sealed class UpdateProfileState {}

final class UpdateProfileInitial extends UpdateProfileState {}

final class UpdatProfileLoadingState extends UpdateProfileState {}

final class UpdateProfileSuccessState extends UpdateProfileState {}

final class UpdateProfileErrorState extends UpdateProfileState {
  final String message;

  UpdateProfileErrorState({required this.message});
}
