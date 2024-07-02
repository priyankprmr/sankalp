import 'dart:convert';

import 'package:collection/collection.dart';

class LoginData {
  int? id;
  int? intCompanyId;
  String? name;
  String? email;
  String? varPhone;

  LoginData({this.id, this.intCompanyId, this.name, this.email, this.varPhone});

  @override
  String toString() {
    return 'Data(id: $id, intCompanyId: $intCompanyId, name: $name, email: $email, varPhone: $varPhone)';
  }

  factory LoginData.fromMap(Map<String, dynamic> data) => LoginData(
        id: data['id'] as int?,
        intCompanyId: data['intCompanyId'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        varPhone: data['varPhone'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'intCompanyId': intCompanyId,
        'name': name,
        'email': email,
        'varPhone': varPhone,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginData].
  factory LoginData.fromJson(String data) {
    return LoginData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LoginData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      intCompanyId.hashCode ^
      name.hashCode ^
      email.hashCode ^
      varPhone.hashCode;
}
