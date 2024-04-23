import 'package:flutter/foundation.dart' show immutable;
import 'package:go_router/go_router.dart';
import 'package:sankalp/Screens/login_screen.dart';
import 'package:sankalp/Screens/order_list_screen.dart';

@immutable
class RouterConfigRoutes {
  static GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/products",
        builder: (context, state) => const OrderListScreen(),
      )
    ],
  );
}
