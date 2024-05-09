import 'package:flutter/material.dart';
import 'package:sankalp/Domain/Models/OrderListResponse/order_list_response.dart';
import 'package:sankalp/Utils/api_utils.dart';
import 'package:sankalp/Utils/parameter_const.dart';
import 'package:http/http.dart' as http;

class GetOrderListService {
  static Future<OrderListResponse?> getOrderList({
    String? search,
    required String userId,
    required String compId,
  }) async {
    const uri = '${ApiConst.url}${Endpoints.getDispatch}';
    final body = {
      ParameterConst.search: search,
      ParameterConst.userId: userId,
      ParameterConst.compId: compId,
    };
    final response = await http.post(Uri.parse(uri), body: body);
    debugPrint("Status code-->${response.statusCode}");
    debugPrint("Response body-->${response.body}");
    switch (response.statusCode) {
      case 200:
        return OrderListResponse.fromJson(response.body);
      default:
        return null;
    }
  }
}
