import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Auth/Providers/auth_state_provider.dart';
import 'package:sankalp/Auth/enums/login_result.dart';

final isLoggedInProvider = Provider((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.result == LoginResult.success;
});
