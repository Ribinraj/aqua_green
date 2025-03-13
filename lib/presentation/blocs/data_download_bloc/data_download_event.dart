part of 'data_download_bloc.dart';

@immutable
sealed class DataDownloadEvent {}
class DownloadAllDataEvent extends DataDownloadEvent {}
final class CheckDataStatusEvent extends DataDownloadEvent{}
class RefreshAllDataEvent extends DataDownloadEvent {}