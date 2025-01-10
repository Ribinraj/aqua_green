part of 'verify_otp_bloc.dart';

@immutable
sealed class VerifyOtpEvent {}

final class VerifyOtpclickEvent extends VerifyOtpEvent {
  final String otp;
  final String customerid;

  VerifyOtpclickEvent({required this.otp, required this.customerid});
}
