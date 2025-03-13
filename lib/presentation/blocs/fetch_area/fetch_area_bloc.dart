import 'dart:async';

import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/domain/database/download_routedatabaseHelpeerclass.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_area_event.dart';
part 'fetch_area_state.dart';

class FetchAreaBloc extends Bloc<FetchAreaEvent, FetchAreaState> {
  final MeasurmentsRepo repository;
  final DataSyncService dataSyncService;
  List<AreaModel> allareas = [];
  FetchAreaBloc({required this.dataSyncService, required this.repository})
      : super(FetchAreaInitial()) {
    on<FetchAreaEvent>((event, emit) {});
    on<FetchAreaInitialEvent>(fetcharea);
    on<FetchAreaWithRouteId>(fetchfilteredarea);
  }

  FutureOr<void> fetcharea(
      FetchAreaInitialEvent event, Emitter<FetchAreaState> emit) async {
    emit(FetchAreaLoadingState());
    // final response = await repository.fetcharea();
    // if (!response.error && response.status == 200) {
    //   allareas = response.data!;
    //   emit(FetchAreaSuccessState(areas: response.data!));
    // }
    final response = await dataSyncService.getLocalAreas();
    if (response.isNotEmpty) {
      allareas = response;
      emit(FetchAreaSuccessState(areas: response));
    } else {
      emit(FetchAreaErrorState(message: 'Area not Downloaded'));
    }
  }

  FutureOr<void> fetchfilteredarea(
      FetchAreaWithRouteId event, Emitter<FetchAreaState> emit) async {
    emit(FetchAreaLoadingState());
    try {
      final filterdareas =
          allareas.where((area) => area.routeId == event.routeId).toList();

      if (filterdareas.isEmpty) {
        emit(FetchAreaWithRouteIdSuccessState(areas: []));
      } else {
        emit(FetchAreaWithRouteIdSuccessState(areas: filterdareas));
      }
    } catch (e) {
      emit(FetchAreaErrorState(message: 'Error filtering areas'));
    }
  }
}
