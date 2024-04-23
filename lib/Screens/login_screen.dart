import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sankalp/Utils/image_const.dart';
import 'package:sankalp/Utils/string_const.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.asset(
              logoImage,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: StringConst.email,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: StringConst.password,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      onPressed: () {
                        context.go('/products');
                      },
                      child: const Text(
                        StringConst.signIn,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
