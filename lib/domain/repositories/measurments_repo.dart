import 'dart:convert';
import 'dart:developer';

import 'package:aqua_green/core/urls.dart';
import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/data/plant_datamodel.dart';
import 'package:aqua_green/data/reports.dart';
import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/domain/database/measurment_savedatabase.dart';

import 'package:aqua_green/presentation/widgets/shared_preference.dart';
import 'package:aqua_green/presentation/widgets/sync_progress.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class MeasurmentsRepo {
  final http.Client client;
  final WaterPlantDatabaseHelper waterPlantDatabaseHelper;
  MeasurmentsRepo({http.Client? client})
      : client = client ?? http.Client(),
        waterPlantDatabaseHelper = WaterPlantDatabaseHelper.instance;
  //////////fetch routes ////////////////
  Future<ApiResponse<List<RouteModel>>> fetcchroutes() async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.fetchroutes}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      final responseData = jsonDecode(response.body);

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> jsonList = responseData['data'];
        final List<RouteModel> routeList =
            jsonList.map((json) => RouteModel.fromJson(json)).toList();

        return ApiResponse(
          data: routeList,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

//////////fetch area///////////////
  Future<ApiResponse<List<AreaModel>>> fetcharea() async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.fetchareas}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      final responseData = jsonDecode(response.body);

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> jsonList = responseData['data'];
        final List<AreaModel> arealist =
            jsonList.map((json) => AreaModel.fromJson(json)).toList();

        return ApiResponse(
          data: arealist,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  //////////fetch unit///////////////
  Future<ApiResponse<List<UnitModel>>> fetchunit() async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.fetchUnits}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      final responseData = jsonDecode(response.body);

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> jsonList = responseData['data'];
        final List<UnitModel> unitlist =
            jsonList.map((json) => UnitModel.fromJson(json)).toList();

        return ApiResponse(
          data: unitlist,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

////updaatunit///////////
  Future<ApiResponse> updateunit(
      {required String unitId,
      required String latitude,
      required String longitude}) async {
    log(unitId);

    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.updateUnits}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body:
            jsonEncode({'unitId': unitId, 'latt': latitude, 'long': longitude}),
      );

      final responseData = jsonDecode(response.body);
      // log(response.toString());
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  ///////////addmeasurments////////////
  Future<ApiResponse> addmeasurments(
      {required WaterPlantDataModel datas}) async {
    // log(datas.pictures.length.toString());
  
    try {
      final hasNetwork = await NetworkChecker.hasNetwork();
      if (!hasNetwork) {
        await waterPlantDatabaseHelper.insertWaterPlantData(datas);
        return ApiResponse(
          data: null,
          message: 'Data saved locally',
          error: false,
          status: 200,
        );
      }
      final token = await getUserToken();
      var response = await client.post(
          Uri.parse('${Endpoints.baseUrl}${Endpoints.addmeasure}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode(datas));
      log('Response Data: ${response.body}');
      final responseData = jsonDecode(response.body);
      // log(responseData.toString());
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        await waterPlantDatabaseHelper.insertWaterPlantData(datas);
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      await waterPlantDatabaseHelper.insertWaterPlantData(datas);
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  Future<void> syncPendingData() async {
    if (!await NetworkChecker.hasNetwork()) return;
    final pendingData = await waterPlantDatabaseHelper.getStoredData();
    if (pendingData.isEmpty) return;
    SyncProgress().startSync(pendingData.length);
    for (var data in pendingData){
      try {
        final result= await addmeasurments(datas: data);
        if (!result.error) {
          await waterPlantDatabaseHelper.deleteWaterPlantData(data.id!);
         
        }
          SyncProgress().updateProgress();
      } catch (e) {
        log('Error syncing task: ${e.toString()}');
        continue;
      }
    } 
    SyncProgress().completeSync();
  }
  ////////////////
  // Future<ApiResponse> addmeasurments(
  //     {required WaterPlantDataModel datas}) async {
  //   // log(datas.pictures.length.toString());
  //   log(datas.toJson().toString());
  //   try {
  //     final token = await getUserToken();
  //     var response = await client.post(
  //         Uri.parse('${Endpoints.baseUrl}${Endpoints.addmeasure}'),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization': token,
  //         },
  //         body: jsonEncode(datas));
  //     log('Response Data: ${response.body}');
  //     final responseData = jsonDecode(response.body);
  //     // log(responseData.toString());
  //     if (!responseData["error"] && responseData["status"] == 200) {
  //       return ApiResponse(
  //         data: null,
  //         message: responseData['message'] ?? 'Success',
  //         error: false,
  //         status: responseData["status"],
  //       );
  //     } else {
  //       return ApiResponse(
  //         data: null,
  //         message: responseData['message'] ?? 'Something went wrong',
  //         error: true,
  //         status: responseData["status"],
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     log(e.toString());
  //     return ApiResponse(
  //       data: null,
  //       message: 'Network or server error occurred',
  //       error: true,
  //       status: 500,
  //     );
  //   }
  // }

  Future<ApiResponse<List<ReportModel>>> fetchreport() async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.fetchreport}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      final responseData = jsonDecode(response.body);

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> jsonList = responseData['data'];
        final List<ReportModel> reportlist =
            jsonList.map((json) => ReportModel.fromJson(json)).toList();

        return ApiResponse(
          data: reportlist,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

  void dispose() {
    client.close();
  }
}
