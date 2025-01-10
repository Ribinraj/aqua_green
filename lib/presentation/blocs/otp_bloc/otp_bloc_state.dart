part of 'otp_bloc_bloc.dart';

@immutable
sealed class OtpBlocState {}

final class OtpBlocInitial extends OtpBlocState {}

final class OtpLoadingState extends OtpBlocState {}

final class OtpSuccessState extends OtpBlocState {
  final String customerid;

  OtpSuccessState({required this.customerid});
}

final class OtpErrorState extends OtpBlocState {
  final String message;

  OtpErrorState({required this.message});
}
