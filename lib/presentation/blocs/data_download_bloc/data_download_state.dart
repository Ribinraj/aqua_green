part of 'data_download_bloc.dart';

@immutable
sealed class DataDownloadState {}

final class DataDownloadInitial extends DataDownloadState {}

final class DataDownloadLoadingState extends DataDownloadState {

}

final class DatadownloadSuccessState extends DataDownloadState {
  final String message;

  DatadownloadSuccessState({required this.message});
}

final class DatadownloadErrorState extends DataDownloadState {
  final String message;

  DatadownloadErrorState({required this.message});
}
final class DataAlreadyDownloadedState extends DataDownloadState{}
final class DataNotDownloadedState extends DataDownloadState{}
class DataRefreshSuccessState extends DataDownloadState {
  final String message;
  DataRefreshSuccessState({required this.message});
}