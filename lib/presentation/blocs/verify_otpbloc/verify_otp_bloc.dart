import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final Loginrepo repository;
  VerifyOtpBloc({required this.repository}) : super(VerifyOtpInitial()) {
    on<VerifyOtpEvent>((event, emit) {});
    on<VerifyOtpclickEvent>(verifyotpevent);
  }

  FutureOr<void> verifyotpevent(
      VerifyOtpclickEvent event, Emitter<VerifyOtpState> emit) async {
    emit(VerifyOtpLoadingState());
    final response = await repository.verifyotp(
        userId:  event.userId, otp: event.otp);
    if (!response.error && response.status == 200) {
      emit(VerifyOtpSuccessState());
    } else {
      emit(VerifyOtpErrorState(message: response.message));
    }
  }
       @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
