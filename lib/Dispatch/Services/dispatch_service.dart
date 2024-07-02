import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sankalp/Dispatch/Models/Dispatch/create_dispatch_data.dart';
import 'package:sankalp/Dispatch/Models/Dispatch/create_dispatch_response.dart';
import 'package:sankalp/Dispatch/Models/get_pack_data_response.dart';
import 'package:sankalp/Utils/api_result.dart';
import 'package:http/http.dart' as http;
import 'package:sankalp/Utils/api_utils.dart';
import 'package:sankalp/Utils/parameter_const.dart';

class DispatchService {
  static Future<ApiResult> getPackData({required String barcode}) async {
    const uri = '${ApiConst.url}${Endpoints.getPackData}';

    final response = await http.post(Uri.parse(uri),
        body: {ParameterConst.barcode: barcode, 'type': '0'});
    debugPrint("Status code-->${response.statusCode}");
    debugPrint("Response body-->${response.body}");
    switch (response.statusCode) {
      case 200:
        return Success(
          response: GetPackDataResponse.fromJson(response.body),
        );
      default:
        return Failure(response: null);
    }
  }

  static Future<ApiResult> createDispatch({
    required CreateDispatchData createDispatchData,
  }) async {
    const uri = '${ApiConst.url}${Endpoints.createDispatch}';

    final response = await http.post(
      Uri.parse(uri),
      body: jsonEncode(
        createDispatchData,
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    debugPrint("Status code-->${response.statusCode}");
    debugPrint("Response body-->${response.body}");
    switch (response.statusCode) {
      case 200:
        return Success(
          response: CreateDispatchResponse.fromJson(response.body),
        );
      default:
        return Failure(response: null);
    }
  }
}
