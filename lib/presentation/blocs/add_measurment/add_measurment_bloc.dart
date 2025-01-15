import 'dart:async';

import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_measurment_event.dart';
part 'add_measurment_state.dart';

class AddMeasurmentBloc extends Bloc<AddMeasurmentEvent, AddMeasurmentState> {
  final MeasurmentsRepo repository;
  AddMeasurmentBloc({required this.repository})
      : super(AddMeasurmentInitial()) {
    on<AddMeasurmentEvent>((event, emit) {});
    on<AddMeasurmentButtonclickEvent>(addmeasurement);
  }

  FutureOr<void> addmeasurement(AddMeasurmentButtonclickEvent event,
      Emitter<AddMeasurmentState> emit) async {
    emit(AddMeasurmentLoadingState());
    final response = await repository.addmeasurments(datas: event.datas);
    if (!response.error && response.status == 200) {
      emit(AddMeasurmentSuccessState());
    }
    else{
      emit(AddMeasurmentErrorState(message: response.message));
    }
  }
}
