import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sankalp/Utils/shared_pref.dart';
import 'package:sankalp/Utils/shared_pref_const.dart';

final userIdProvider = Provider(
  (ref) => Shared.pref.getInt(SharedPrefConst.userId),
);
