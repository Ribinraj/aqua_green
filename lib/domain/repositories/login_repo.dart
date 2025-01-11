import 'dart:convert';
import 'dart:developer';

import 'package:aqua_green/core/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

class Loginrepo {
  final http.Client client;
  Loginrepo({http.Client? client}) : client = client ?? http.Client();
  Future<ApiResponse> userlogin(
      {required String mobileNumber, required String password}) async {
    debugPrint('mobilenumber$mobileNumber');
     debugPrint('mobilenumber$password');
    try {
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.login}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            {'userMobileNumber': mobileNumber, 'userPassword': password}),
      );

      final responseData = jsonDecode(response.body);
     // log(response.toString());
      if (!responseData["error"] && responseData["status"] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        
        return ApiResponse(
          data: null,
          message: responseData['messages'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['messages'] ?? 'Something went wrong',
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

//sendotp//
  Future<ApiResponse<String>> sendotp({required String mobilenumber}) async {
    try {
      var response = await client.post(Uri.parse('${Endpoints.baseUrl}${Endpoints.login}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userMobileNumber': mobilenumber}));
      final responseData = jsonDecode(response.body);
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: responseData["data"]["userId"],
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

//verifyotp//
  Future<ApiResponse> verifyotp({required customerid, required otp}) async {
    try {
      debugPrint('otp$otp');
      var response = await client.post(Uri.parse('${Endpoints}${Endpoints}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'customerId': customerid, 'customerOTP': otp}));
      final responseData = jsonDecode(response.body);
      if (!responseData["error"] && responseData["status"] == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        // preferences.setBool('LOGIN', true);
        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
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
