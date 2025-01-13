part of 'otp_bloc_bloc.dart';

@immutable
sealed class OtpBlocEvent {}

final class SendOtpClickEvent extends OtpBlocEvent {
  final String mobilenumber;


  SendOtpClickEvent({required this.mobilenumber});
}


