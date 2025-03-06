part of 'fetch_report_offline_bloc.dart';

@immutable
sealed class FetchReportOfflineState {}

final class FetchReportOfflineInitial extends FetchReportOfflineState {}
final class FetchReportOfflineLoading extends FetchReportOfflineState {}
final class FetchReportOfflineSuccess extends FetchReportOfflineState {
  final List<WaterPlantDataModel> data;

  FetchReportOfflineSuccess({required this.data});

}
final class FetchReportofflineErrorState extends FetchReportOfflineState {
  final String message;

  FetchReportofflineErrorState({required this.message});

}