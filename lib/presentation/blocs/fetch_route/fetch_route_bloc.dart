import 'dart:async';

import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/domain/database/download_routedatabaseHelpeerclass.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'fetch_route_event.dart';
part 'fetch_route_state.dart';

class FetchRouteBloc extends Bloc<FetchRouteEvent, FetchRouteState> {
  //final MeasurmentsRepo repository;
  final DataSyncService dataSyncService;
  FetchRouteBloc({required this.dataSyncService})
      : super(FetchRouteInitial()) {
    on<FetchRouteEvent>((event, emit) {});
    on<FetchRouteInitialEvent>(fetchroute);
  }

  FutureOr<void> fetchroute(
      FetchRouteInitialEvent event, Emitter<FetchRouteState> emit) async {
    emit(FetchRouteLoadingState());
    final response = await dataSyncService.getLocalRoutes();
    if (response.isNotEmpty) {
      emit(FetchRouteSuccessState(routes: response));
    }
    // if (!response.error && response.status == 200) {
    //   emit(FetchRouteSuccessState(routes: response.data!));
    // }
    else {
      emit(FetchRouteErrorState(message:'No units Downloaded'));
    }
  }
}
