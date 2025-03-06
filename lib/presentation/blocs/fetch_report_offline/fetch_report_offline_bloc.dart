import 'dart:async';

import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:aqua_green/domain/database/measurment_savedatabase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_report_offline_event.dart';
part 'fetch_report_offline_state.dart';

class FetchReportOfflineBloc
    extends Bloc<FetchReportOfflineEvent, FetchReportOfflineState> {
  final WaterPlantDatabaseHelper waterplantdatabasehelper;
  FetchReportOfflineBloc({required this.waterplantdatabasehelper})
      : super(FetchReportOfflineInitial()) {
    on<FetchReportOfflineEvent>((event, emit) {});
    on<FetchReportOfflineInitialEvent>(fetchoffline);
  }

  FutureOr<void> fetchoffline(FetchReportOfflineInitialEvent event, Emitter<FetchReportOfflineState> emit) async{
    emit(FetchReportOfflineLoading());
    try {
      final data = await waterplantdatabasehelper.getStoredData();
      emit(FetchReportOfflineSuccess(data: data));
    } catch (e) {
      emit(FetchReportofflineErrorState(message:"Failed to fetch data: ${e.toString()}"));
    }
  }
}
