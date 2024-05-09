import 'package:flutter/foundation.dart' show immutable;

@immutable
class ApiConst {
  const ApiConst._();
  static const url = 'https://sankalp.mpiric.us/api/';
}

@immutable
class Endpoints {
  const Endpoints._();
  static const login = 'login';
  static const getDispatch = 'get_dispatch';
}
