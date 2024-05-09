import 'dart:convert';

import 'package:collection/collection.dart';

import 'order_data.dart';

class OrderListResponse {
  bool? success;
  OrderListData? data;
  String? message;

  OrderListResponse({this.success, this.data, this.message});

  factory OrderListResponse.fromMap(Map<String, dynamic> data) {
    return OrderListResponse(
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : OrderListData.fromMap(data['data'] as Map<String, dynamic>),
      message: data['message'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'success': success,
        'data': data?.toMap(),
        'message': message,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderListResponse].
  factory OrderListResponse.fromJson(String data) {
    return OrderListResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderListResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderListResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => success.hashCode ^ data.hashCode ^ message.hashCode;
}
