import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Orders/Models/OrderListResponse/order_list_data.dart';
import 'package:sankalp/Orders/Services/get_order_list_service.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:sankalp/Utils/shared_pref_const.dart';

final orderListFutureProvider = FutureProvider.family<List<OrderData>, String>(
  (ref, arg) async {
    
    final userId = Shared.pref.getInt(SharedPrefConst.userId).toString();
    final compId = Shared.pref.getInt(SharedPrefConst.compId).toString();

    List<OrderData> orderList = [];

    final response = await GetOrderListService.getOrderList(
      userId: userId,
      compId: compId,
      search: arg,
    );

    if (response != null) {
      final isSuccess = response.success ?? false;
      if (isSuccess) {
        orderList = response.data!.data ?? [];
      }
    }

    return orderList;
  },
);

final orderListProvider =
    StreamProvider.family<List<OrderData>, String>((ref, arg) {
  final controller = StreamController<List<OrderData>>();
  final userId = Shared.pref.getInt(SharedPrefConst.userId).toString();
  final compId = Shared.pref.getInt(SharedPrefConst.compId).toString();

  GetOrderListService.getOrderList(
    userId: userId,
    compId: compId,
    search: arg,
  ).then((response) {
    if (response != null) {
      final isSuccess = response.success ?? false;
      if (isSuccess) {
        controller.sink.add(response.data!.data!);
      }
    }
  });

  ref.onDispose(() {
    controller.close();
  });

  return controller.stream;
});
