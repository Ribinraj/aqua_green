import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'resend_otp_event.dart';
part 'resend_otp_state.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  final Loginrepo repository;
  ResendOtpBloc({required this.repository}) : super(ResendOtpInitial()) {
    on<ResendOtpEvent>((event, emit) {});
    on<ResendOtpClickEvent>(resendotpevent);
  }

  FutureOr<void> resendotpevent(
      ResendOtpClickEvent event, Emitter<ResendOtpState> emit) async {
    emit(ResendOtpLoadingState());
    final response = await repository.resendotp(userId: event.userId);
    if (!response.error && response.status == 200) {
      emit(ResendOtpSuccessState(userId: response.data!));
    } else {
      emit(ResendOtpErrorState(message: response.message));
    }
  }
}
