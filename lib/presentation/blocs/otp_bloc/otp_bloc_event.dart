part of 'otp_bloc_bloc.dart';

@immutable
sealed class OtpBlocEvent {}

final class SendOtpClickEvent extends OtpBlocEvent {
  final String mobilenumber;
  final bool isResend;

  SendOtpClickEvent({required this.mobilenumber, this.isResend = false});
}

final class VerifyOtpClickEvent extends OtpBlocEvent {
  final String otp;
  final String customerid;

  VerifyOtpClickEvent({required this.otp, required this.customerid});
}
