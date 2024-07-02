import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Auth/Models/auth_state.dart';
import 'package:sankalp/Auth/Notifiers/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (_) => AuthStateNotifier(),
);
