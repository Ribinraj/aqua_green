import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Loginrepo repository;
  LoginBloc({required this.repository}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginButtonClickingEvent>(loginevent);
  }

  FutureOr<void> loginevent(
      LoginButtonClickingEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final response = await repository.userlogin(
        mobileNumber: event.mobielnumber, password: event.password);
    if (!response.error && response.status == 200) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState(message: response.message));
    }
  }
          @override
  Future<void> close() {
    repository.dispose();
    return super.close();
  }
}
