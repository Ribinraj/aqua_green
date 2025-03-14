import 'dart:async';

import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/domain/database/download_routedatabaseHelpeerclass.dart';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_unit_event.dart';
part 'fetch_unit_state.dart';

class FetchUnitBloc extends Bloc<FetchUnitEvent, FetchUnitState> {
  //final MeasurmentsRepo repository;
  final DataSyncService dataSyncService;
  List<UnitModel> allunits = [];
  FetchUnitBloc( {required this.dataSyncService}) : super(FetchUnitInitial()) {
    on<FetchUnitEvent>((event, emit) {});
    on<FetchUnitInitialEvent>(fetchunit);
    on<FetchUnitWithRouteIdandAreaId>(fetchfilteredunit);
  }

  FutureOr<void> fetchunit(
      FetchUnitInitialEvent event, Emitter<FetchUnitState> emit) async {
    emit(FetchUnitLoadingState());
    // final response = await repository.fetchunit();
    // if (!response.error && response.status == 200) {
    //   allunits = response.data!;
    //   emit(FetchUnitSuccessState(units: response.data!));
    final response=await dataSyncService.getLocalUnits();
    if (response.isNotEmpty) {
      allunits=response;
      emit(FetchUnitSuccessState(units: response));
    }
    else {
      emit(FetchUnitErrorState(message:'Units not Downloaded'));
    }
  }

  FutureOr<void> fetchfilteredunit(
      FetchUnitWithRouteIdandAreaId event, Emitter<FetchUnitState> emit) {
    emit(FetchUnitLoadingState());
    try {
      final filterdunits = allunits
          .where((units) =>
              units.routeId == event.routeId && units.areaId == event.areaId)
          .toList();

      if (filterdunits.isEmpty) {
        emit(FetchUnitWithRouteIdandAreaIdSuccessState(units: []));
      } else {
        emit(FetchUnitWithRouteIdandAreaIdSuccessState(units: filterdunits));
      }
    } catch (e) {
      emit(FetchUnitErrorState(message: 'Error filtering units'));
    }
  }
}
