import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Auth/Providers/is_logged_in_provider.dart';
import 'package:sankalp/Auth/Screens/login_screen.dart';
import 'package:sankalp/Orders/Screens/order_list_screen.dart';
import 'package:sankalp/Utils/design_const.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Shared.pref = await SharedPreferences.getInstance();
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final isLoggedin = ref.watch(isLoggedInProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignConst.borderRadius),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(DesignConst.borderRadius),
              ),
            ),
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
         
          if (isLoggedin) {
            return const OrderListScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
