import 'package:flutter/material.dart';
import 'package:sankalp/Auth/Screens/login_screen.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:sankalp/Utils/string_const.dart';
import 'package:sankalp/Orders/Widgets/order_list.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    StringConst.orders,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaler: TextScaler.linear(2.0),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: TextButton(
                            onPressed: () async {
                              showDialog<bool>(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  title: const Text('Sankalp'),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 10.0,
                                  ),
                                  titlePadding: const EdgeInsets.symmetric(
                                    horizontal: 15.0,
                                    vertical: 10.0,
                                  ),
                                  children: [
                                    const Text(
                                      "Are you sure you want to logout?",
                                    ),
                                    const SizedBox(height: 10.0,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        const SizedBox(
                                          width: 10.0,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ).then(
                                (logout) {
                                  if (logout == true) {
                                    Shared.pref.clear();
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                              );
                            },
                            child: const Text(
                              "Logout",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ];
                    },
                  )
                ],
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
    );
  }
}
