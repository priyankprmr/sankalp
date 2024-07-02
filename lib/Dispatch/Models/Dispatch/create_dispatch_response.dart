import 'dart:convert';

import 'package:collection/collection.dart';

class CreateDispatchResponse {
  bool? success;
  List<dynamic>? data;
  String? message;

  CreateDispatchResponse({this.success, this.data, this.message});

  @override
  String toString() {
    return 'CreateDispatchResponse(success: $success, data: $data, message: $message)';
  }

  factory CreateDispatchResponse.fromMap(Map<String, dynamic> data) {
    return CreateDispatchResponse(
      success: data['success'] as bool?,
      data: data['data'] as List<dynamic>?,
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data,
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CreateDispatchResponse].
  factory CreateDispatchResponse.fromJson(String data) {
    return CreateDispatchResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CreateDispatchResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  CreateDispatchResponse copyWith({
    bool? success,
    List<dynamic>? data,
    String? message,
  }) {
    return CreateDispatchResponse(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! CreateDispatchResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}
