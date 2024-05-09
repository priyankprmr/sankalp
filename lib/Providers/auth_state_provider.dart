import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Domain/Models/auth/auth_state.dart';
import 'package:sankalp/Notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
