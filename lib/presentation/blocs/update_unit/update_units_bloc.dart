import 'dart:async';

import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_units_event.dart';
part 'update_units_state.dart';

class UpdateUnitsBloc extends Bloc<UpdateUnitsEvent, UpdateUnitsState> {
  final MeasurmentsRepo repository;
  UpdateUnitsBloc({required this.repository}) : super(UpdateUnitsInitial()) {
    on<UpdateUnitsEvent>((event, emit) {});
    on<UpdateUnitButtonclickEvent>(updateUnit);
  }

  FutureOr<void> updateUnit(
      UpdateUnitButtonclickEvent event, Emitter<UpdateUnitsState> emit) async {
    emit(UpdateUnitLoadingState());
    final response = await repository.updateunit(
        unitId: event.unitId,
        latitude: event.lattitude,
        longitude: event.longitude);
    if (!response.error && response.status == 200) {
      emit(UpdateUnitSuccessState(message: response.message));
    } else {
      emit(UpdateUnitErrorState(message: response.message));
    }
  }
}
