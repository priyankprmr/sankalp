import 'package:flutter/material.dart';
import 'package:sankalp/Domain/Models/LoginResponse/login_response.dart';
import 'package:sankalp/Utils/api_utils.dart';
import 'package:http/http.dart' as http;
import 'package:sankalp/Utils/parameter_const.dart';

class LoginService {
  static Future<LoginResponse?> login(
      {required String email, required String password}) async {
    const uri = '${ApiConst.url}${Endpoints.login}';
    final body = {
      ParameterConst.email: email,
      ParameterConst.password: password,
    };
    final response = await http.post(Uri.parse(uri), body: body);
    debugPrint("Status code-->${response.statusCode}");
    debugPrint("Response body-->${response.body}");
    switch (response.statusCode) {
      case 200:
        return LoginResponse.fromJson(response.body);
      default:
        return null;
    }
  }
}
