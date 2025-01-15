part of 'fetch_report_bloc.dart';

@immutable
sealed class FetchReportEvent {}
final class FetchReportInitialEvent extends FetchReportEvent{}