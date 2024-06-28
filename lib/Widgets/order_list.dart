import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Domain/Models/OrderListResponse/order_list_data.dart';
import 'package:sankalp/Providers/order_list_provider.dart';
import 'package:sankalp/Widgets/order_card.dart';

class OrderList extends ConsumerWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<OrderData>> orderList = ref.watch(orderListProvider(''));
    return RefreshIndicator(
      onRefresh: () {
        orderList = ref.refresh(orderListProvider(''));
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: orderList.when(
        data: (data) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              final order = data.elementAt(index);
              return OrderCard(order: order);
            },
          );
        },
        error: (error, stackTrace) => const Center(
          child: Text('No data found'),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
