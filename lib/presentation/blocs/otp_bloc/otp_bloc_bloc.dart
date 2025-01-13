import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'otp_bloc_event.dart';
part 'otp_bloc_state.dart';

class OtpBlocBloc extends Bloc<OtpBlocEvent, OtpBlocState> {
  final Loginrepo repository;
  OtpBlocBloc({required this.repository}) : super(OtpBlocInitial()) {
    on<OtpBlocEvent>((event, emit) {});
    on<SendOtpClickEvent>(sendotpevent);
  }

  FutureOr<void> sendotpevent(
      SendOtpClickEvent event, Emitter<OtpBlocState> emit) async {
    emit(OtpLoadingState());
    final response = await repository.sendotp(mobilenumber: event.mobilenumber);
    if (!response.error && response.status == 200) {
      emit(OtpSuccessState(userId: response.data!));
    } else {
      emit(OtpErrorState(message: response.message));
    }
  }
}
