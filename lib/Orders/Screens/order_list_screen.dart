import 'package:flutter/material.dart';
import 'package:sankalp/Dispatch/Screens/create_dispatch_screen.dart';
import 'package:sankalp/Utils/string_const.dart';
import 'package:sankalp/Orders/Widgets/order_list.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                StringConst.orders,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textScaler: TextScaler.linear(2.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 3,
                child: OrderList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push<String>(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateDispatchScreen(),
            ),
          );
          
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
