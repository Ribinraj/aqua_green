import 'dart:async';

import 'package:aqua_green/data/reports.dart';
import 'package:aqua_green/domain/repositories/measurments_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'fetch_report_event.dart';
part 'fetch_report_state.dart';

class FetchReportBloc extends Bloc<FetchReportEvent, FetchReportState> {
  final MeasurmentsRepo repository;
  FetchReportBloc({required this.repository}) : super(FetchReportInitial()) {
    on<FetchReportEvent>((event, emit) {});
    on<FetchReportInitialEvent>(fetchreport);
  }

  FutureOr<void> fetchreport(
      FetchReportInitialEvent event, Emitter<FetchReportState> emit) async {
    emit(FetchReportLoadingState());
    final response = await repository.fetchreport();
    if (!response.error && response.status == 200) {
      emit(FetchReportSuccessState(reports: response.data!));
    } else {
      emit(FetchReportErrorState(message: response.message));
    }
  }
}
