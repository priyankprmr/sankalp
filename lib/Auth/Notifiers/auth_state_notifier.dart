import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Auth/Models/auth_state.dart';
import 'package:sankalp/Auth/Viewmodel/login_viewmodel.dart';
import 'package:sankalp/Auth/enums/login_result.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _loginViewmodel = LoginViewmodel();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_loginViewmodel.isAlredyLoggedIn) {
      state = AuthState(
        result: LoginResult.success,
        isLoading: false,
        userId: _loginViewmodel.userId,
      );
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _loginViewmodel.login(email: email, password: password);
    final userId = _loginViewmodel.userId;
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }
}
