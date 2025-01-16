import 'dart:async';

import 'package:aqua_green/data/user_model.dart';
import 'package:aqua_green/domain/repositories/login_repo.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_profile_event.dart';
part 'fetch_profile_state.dart';

class FetchProfileBloc extends Bloc<FetchProfileEvent, FetchProfileState> {
  final Loginrepo repository;
  FetchProfileBloc({required this.repository}) : super(FetchProfileInitial()) {
    on<FetchProfileEvent>((event, emit) {});
    on<FetchProfileInitailEvent>(fetechprofile);
  }

  FutureOr<void> fetechprofile(
      FetchProfileInitailEvent event, Emitter<FetchProfileState> emit) async {
    emit(FetchProfileLoadingState());
    final response = await repository.fetchprofile();
    if (!response.error && response.status == 200) {
      emit(FetchProfileSuccessState(user: response.data!));
    } else {
      emit(FetchProfileErrorState(message: response.message));
    }
  }
}
