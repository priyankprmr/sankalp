import 'package:flutter/material.dart';
import 'package:sankalp/Domain/Models/order.dart';
import 'package:sankalp/Widgets/order_card.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late List<Order> productList;

  @override
  void initState() {
    super.initState();
    productList = List.generate(
      7,
      (i) => Order(
        productName: 'Product ${i + 1}',
        code: 'CODE$i',
        casrNumber: 'SB00$i',
        batchNumber: 'BATCH$i',
        qty: (i * 10).toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: productList.length,
      itemBuilder: (BuildContext context, int index) {
        final product = productList.elementAt(index);
        return OrderCard(order: product);
      },
    );
  }
}
