part of 'fetch_report_bloc.dart';

@immutable
sealed class FetchReportState {}

final class FetchReportInitial extends FetchReportState {}

final class FetchReportLoadingState extends FetchReportState {}

final class FetchReportSuccessState extends FetchReportState {
  final List<ReportModel> reports;

  FetchReportSuccessState({required this.reports});
}

final class FetchReportErrorState extends FetchReportState {
  final String message;

  FetchReportErrorState({required this.message});

}
