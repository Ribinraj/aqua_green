import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_password_event.dart';
part 'update_password_state.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  final Loginrepo repository;
  UpdatePasswordBloc({required this.repository})
      : super(UpdatePasswordInitial()) {
    on<UpdatePasswordEvent>((event, emit) {});
    on<UpdatePasswordButtonClickEvent>(updatepassword);
  }

  FutureOr<void> updatepassword(UpdatePasswordButtonClickEvent event,
      Emitter<UpdatePasswordState> emit) async {
    emit(UpdatePasswordLoadingState());
    final response = await repository.updatepassword(
        password: event.password, userId: event.userId);
    if (!response.error && response.status == 200) {
      emit(UpdatePasswordSuccessState());
    } else {
      emit(UpdatepasswordErrorState(message: response.message));
    }
  }
}
