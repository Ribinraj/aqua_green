import 'dart:convert';
import 'dart:developer';

import 'package:aqua_green/core/urls.dart';

import 'package:aqua_green/data/user_model.dart';
import 'package:aqua_green/presentation/widgets/shared_preference.dart';
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
  
      if (!responseData["error"] && responseData["status"] == 200) {
        log("token${responseData["data"]["token"]}");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        preferences.setString('USER_NUMBER', mobileNumber);
        preferences.setString('USER_PASSWORD', password);

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
      debugPrint(mobilenumber);
      var response = await client.post(
          Uri.parse('${Endpoints.baseUrl}${Endpoints.sendOtp}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userMobileNumber': mobilenumber}));
      final responseData = jsonDecode(response.body);
      //log(responseData);
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

//resendotp//
  Future<ApiResponse<String>> resendotp({required String userId}) async {
    try {
      var response = await client.post(
          Uri.parse('${Endpoints.baseUrl}${Endpoints.resendOtp}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userId': userId}));
      final responseData = jsonDecode(response.body);
      //log(responseData);
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
  Future<ApiResponse> verifyotp({required userId, required otp}) async {
    try {
      debugPrint('otp$otp');
      var response = await client.post(
          Uri.parse('${Endpoints.baseUrl}${Endpoints.verifyOtp}'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'userId': userId, 'userOTP': otp}));
      final responseData = jsonDecode(response.body);
      if (!responseData["error"] && responseData["status"] == 200) {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        // // preferences.setBool('LOGIN', true);
        // preferences.setString('USER_TOKEN', responseData["data"]["token"]);
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

  ///updatepassoword//
  Future<ApiResponse> updatepassword(
      {required String password, required String userId}) async {
    try {
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.updatepassord}'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userPassword': password,
          'confirmPassword': password,
          'userId': userId
        }),
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

  ////fetchprofile////////////
  Future<ApiResponse<UserModel>> fetchprofile() async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.fetchprofile}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      final responseData = jsonDecode(response.body);

      if (!responseData["error"] && responseData["status"] == 200) {
        final jsonuser = responseData['data'];

        final user = UserModel.fromJson(jsonuser);

        return ApiResponse(
          data: user,
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

  ///////////updateprofile////////////
  Future<ApiResponse> updateprofile(
      {required String password, required String fullname}) async {
    try {
      final token = await getUserToken();
      var response = await client.post(
        Uri.parse('${Endpoints.baseUrl}${Endpoints.updateprofile}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: jsonEncode({
          "userFullName": fullname,
          "userPassword": password,
          "password_confirmation": password
        }),
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
