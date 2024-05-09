import 'package:sankalp/Domain/Models/LoginResponse/login_response.dart';
import 'package:sankalp/Domain/Services/login_service.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:sankalp/Utils/shared_pref_const.dart';
import 'package:sankalp/enums/login_result.dart';

class LoginViewmodel {
  int? get userId => Shared.pref.getInt(SharedPrefConst.userId);
  bool get isAlredyLoggedIn => userId != null;
  String? get email => Shared.pref.getString(SharedPrefConst.email);
  String get displayName => Shared.pref.getString(SharedPrefConst.name)!;

  LoginResponse  _loginResponse = LoginResponse();
  LoginResponse get loginResponse => _loginResponse;

  Future<LoginResult> login(
      {required String email, required String password}) async {
    final response = await LoginService.login(email: email, password: password);
    if (response == null) return LoginResult.aborted;
    final isSuccess = response.success ?? false;
    if (isSuccess) {
      _loginResponse = response;
      return LoginResult.success;
    } else {
      return LoginResult.failure;
    }
  }
}
