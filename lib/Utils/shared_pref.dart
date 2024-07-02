import 'package:sankalp/Auth/Models/LoginResponse/data.dart';
import 'package:sankalp/Utils/shared_pref_const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart' show immutable;

class Shared {
  static late SharedPreferences pref;
}

@immutable
class SaveInPrefs {
  const SaveInPrefs._();
  static SaveInPrefs get instance => const SaveInPrefs._();

  void saveLoginData(LoginData data) {
    Shared.pref.setInt(SharedPrefConst.userId, data.id!);
    Shared.pref.setString(SharedPrefConst.email, data.email!);
    Shared.pref.setString(SharedPrefConst.name, data.name!);
  }
}
