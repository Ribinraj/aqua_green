import 'dart:convert';
import 'dart:developer';

import 'package:aqua_green/core/urls.dart';
import 'package:aqua_green/data/area_model.dart';
import 'package:aqua_green/data/route_model.dart';
import 'package:aqua_green/data/unit_model.dart';
import 'package:aqua_green/presentation/widgets/shared_preference.dart';
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
  MeasurmentsRepo({http.Client? client}) : client = client ?? http.Client();
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
      {required String unitId, required String latitude, required String longitude}) async {
  
    try {
       final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.updateUnits}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode(
            {'unitId': unitId, 'latt': latitude ,'long':longitude}),
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
  void dispose() {
    client.close();
  }
}
