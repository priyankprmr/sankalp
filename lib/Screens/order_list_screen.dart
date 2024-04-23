import 'package:flutter/material.dart';
import 'package:sankalp/Utils/string_const.dart';
import 'package:sankalp/Widgets/order_list.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                StringConst.orders,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textScaler: TextScaler.linear(2.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: StringConst.searchAllOrders,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Expanded(
                flex: 3,
                child: OrderList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SimpleBarcodeScannerPage(),
            ),
          );
          debugPrint("Result-->$res");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
