import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Domain/Models/auth/auth_state.dart';
import 'package:sankalp/Domain/Viewmodels/login_viewmodel.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:sankalp/enums/login_result.dart';

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
    final result = await _loginViewmodel.login(email: email, password: password);
    final userId = _loginViewmodel.userId;
    if (result == LoginResult.success && userId != null) {
     SaveInPrefs.instance.saveLoginData(_loginViewmodel.loginResponse.data!);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }
}
