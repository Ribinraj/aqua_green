import 'dart:async';

import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_unit_event.dart';
part 'fetch_unit_state.dart';

class FetchUnitBloc extends Bloc<FetchUnitEvent, FetchUnitState> {
  final MeasurmentsRepo repository;
  List<UnitModel> allunits = [];
  FetchUnitBloc({required this.repository}) : super(FetchUnitInitial()) {
    on<FetchUnitEvent>((event, emit) {});
      on<FetchUnitInitialEvent>(fetchunit);
    on<FetchUnitWithRouteIdandAreaId>(fetchfilteredunit);
  }

  FutureOr<void> fetchunit(FetchUnitInitialEvent event, Emitter<FetchUnitState> emit)async {
        emit(FetchUnitLoadingState());
    final response = await repository.fetchunit();
    if (!response.error && response.status == 200) {
      allunits = response.data!;
      emit(FetchUnitSuccessState(units: response.data!));
    } else {
      emit(FetchUnitErrorState(message: response.message));
    }
  }

  FutureOr<void> fetchfilteredunit(FetchUnitWithRouteIdandAreaId event, Emitter<FetchUnitState> emit) {
        emit(FetchUnitLoadingState());
 try {
      final filterdunits = allunits
          .where((units) => units.routeId == event.routeId && units.areaId==event.areaId )
          .toList();
          
      if (filterdunits.isEmpty) {
        emit(FetchUnitWithRouteIdandAreaIdSuccessState(units: []));
      } else {
        emit(FetchUnitWithRouteIdandAreaIdSuccessState(units:filterdunits));
      }
    } catch (e) {
      emit(FetchUnitErrorState(message: 'Error filtering units'));
    }
  }
}
