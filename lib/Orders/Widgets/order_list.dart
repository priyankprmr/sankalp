import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Orders/Providers/order_list_provider.dart';
import 'package:sankalp/Orders/Widgets/order_card.dart';
import 'package:sankalp/Utils/string_const.dart';

class OrderList extends ConsumerStatefulWidget {
  const OrderList({super.key});

  @override
  ConsumerState<OrderList> createState() => _OrderListState();
}

class _OrderListState extends ConsumerState<OrderList> {
  TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {});
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: Column(
        children: [
          TextFormField(
            controller: queryController,
            onChanged: (value) {
              setState(() {});
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: StringConst.searchAllOrders,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: ref.watch(
                orderListFutureProvider(queryController.text).future,
              ),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.none:
                    return const Center(
                      child: Text('Something went wrong!!!!'),
                    );
                  case ConnectionState.active:
                    return const Center();
                  case ConnectionState.done:
                    final data = snapshot.data ?? [];
                    return data.isEmpty
                        ? const Center(
                            child: Text('No data found',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textScaler: TextScaler.linear(1.0),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final order = data.elementAt(index);
                              return OrderCard(order: order);
                            },
                          );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
