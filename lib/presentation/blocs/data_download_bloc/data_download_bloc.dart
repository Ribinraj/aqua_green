import 'dart:async';

import 'package:aqua_green/domain/database/download_routedatabaseHelpeerclass.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'data_download_event.dart';
part 'data_download_state.dart';

// class DataDownloadBloc extends Bloc<DataDownloadEvent, DataDownloadState> {
//   final DataSyncService dataSyncService;

//   DataDownloadBloc({required this.dataSyncService})
//       : super(DataDownloadInitial()) {
//     on<DataDownloadEvent>((event, emit) {});
//     on<DownloadAllDataEvent>(_downloadData);
//     on<CheckDataStatusEvent>(_checkDataStatus);
//   }

//   FutureOr<void> _downloadData(
//       DownloadAllDataEvent event, Emitter<DataDownloadState> emit) async {
//     emit(DataDownloadLoadingState());
//     try {
//       final success = await dataSyncService.downloadAllData();
//       if (success) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setBool('data_downloaded', true);
//         emit(DatadownloadSuccessState(message: 'Data downloaded Successfully'));
//         // Automatically trigger loading initial data after download
//         add(LoadInitialDataEvent());
//       } else {
//         emit(DatadownloadErrorState(message: 'Failed to download data'));
//       }
//     } catch (e) {
//       emit(DatadownloadErrorState(
//           message: 'Error downloading data: ${e.toString()}'));
//     }
//   }

//   FutureOr<void> _checkDataStatus(
//       CheckDataStatusEvent event, Emitter<DataDownloadState> emit) async {
//     emit(DataDownloadCheckingState());
//     try {
//       // First check if data is downloaded flag is set
//       final prefs = await SharedPreferences.getInstance();
//       final isDataDownloaded = prefs.getBool('data_downloaded') ?? false;

//       if (isDataDownloaded) {
//         emit(DataAlreadyDownloadedState());

//         return;
//       }

//       // If flag not set, check database as fallback
//       final routes = await dataSyncService.getLocalRoutes();
//       if (routes.isNotEmpty) {
//         // If we found data but the flag wasn't set, update the flag
//         await prefs.setBool('data_downloaded', true);
//         emit(DataAlreadyDownloadedState());
//       } else {
//         emit(DataNotDownloadedState());
//       }
//     } catch (e) {
//       emit(DatadownloadErrorState(
//           message: 'Error checking data status: ${e.toString()}'));
//     }
//   }
// }
///////////////////////////////////////////////
class DataDownloadBloc extends Bloc<DataDownloadEvent, DataDownloadState> {
  final DataSyncService dataSyncService;
  DataDownloadBloc({required this.dataSyncService})
      : super(DataDownloadInitial()) {
    on<DataDownloadEvent>((event, emit) {});
    on<DownloadAllDataEvent>(downloaddata);
    on<RefreshAllDataEvent>(refreshData);
    // on<CheckDataStatusEvent>(_checkDataStatus);
  }

  FutureOr<void> downloaddata(
      DownloadAllDataEvent event, Emitter<DataDownloadState> emit) async {
    emit(DataDownloadLoadingState());

    try {
      final success = await dataSyncService.downloadAllData();
      if (success) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('data_downloaded', true);
        emit(DatadownloadSuccessState(message: 'Data downloaded Successfully'));
      } else {
        emit(DatadownloadErrorState(message: 'failed to download data'));
      }
    } catch (e) {
      emit(DatadownloadErrorState(
          message: 'Error downloading data : ${e.toString()}'));
    }
  }

  FutureOr<void> refreshData(
      RefreshAllDataEvent event, Emitter<DataDownloadState> emit) async {
    emit(DataDownloadLoadingState());
    try {
      // Then download fresh data
      final success = await dataSyncService.downloadAllData();
      if (success) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('data_downloaded', true);
        emit(DataRefreshSuccessState(message: 'Data refreshed Successfully'));
      } else {
        emit(DatadownloadErrorState(message: 'Failed to refresh data'));
      }
    } catch (e) {
      emit(DatadownloadErrorState(
          message: 'Error refreshing data: ${e.toString()}'));
    }
  }

  // FutureOr<void> _checkDataStatus(
  //     CheckDataStatusEvent event, Emitter<DataDownloadState> emit) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final isDataDownloaded = prefs.getBool('data_downloaded') ?? false;
  //     if (isDataDownloaded) {
  //       emit(DataAlreadyDownloadedState());
  //     } else {
  //       emit(DataNotDownloadedState());
  //     }
  //   } catch (e) {
  //      emit(DatadownloadErrorState(
  //         message: 'Error checking data status: ${e.toString()}'));
  //   }
  // }
}
