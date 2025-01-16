import 'dart:async';

import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final Loginrepo repository;
  UpdateProfileBloc({required this.repository})
      : super(UpdateProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) {});
    on<UpdateProfileButtonclickEvent>(updateprofile);
  }

  FutureOr<void> updateprofile(UpdateProfileButtonclickEvent event,
      Emitter<UpdateProfileState> emit) async {
    emit(UpdatProfileLoadingState());
    final response = await repository.updateprofile(password: event.password,fullname: event.fullname);
    if (!response.error && response.status == 200) {
      emit(UpdateProfileSuccessState());
    } else {
      emit(UpdateProfileErrorState(message: response.message));
    }
  }
}
