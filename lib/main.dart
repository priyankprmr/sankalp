import 'package:flutter/material.dart';
import 'package:sankalp/Routes/router_config.dart';
import 'package:sankalp/Utils/design_const.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: RouterConfigRoutes.router,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignConst.borderRadius),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignConst.borderRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
