import 'dart:convert';

import 'package:collection/collection.dart';

import 'data.dart';

class LoginResponse {
  bool? success;
  LoginData? data;
  String? message;

  LoginResponse({this.success, this.data, this.message});

  @override
  String toString() {
    return 'LoginResponse(success: $success, data: $data, message: $message)';
  }

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        success: data['success'] as bool?,
        data: data['data'] == null
            ? null
            : LoginData.fromMap(data['data'] as Map<String, dynamic>),
        message: data['message'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data?.toMap(),
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LoginResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}
