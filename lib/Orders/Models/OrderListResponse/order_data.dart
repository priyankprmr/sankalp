import 'dart:convert';

import 'package:collection/collection.dart';

import 'order_list_data.dart';

class OrderListData {
  int? currentPage;
  List<OrderData>? data;

  OrderListData({this.currentPage, this.data});

  factory OrderListData.fromMap(Map<String, dynamic> data) => OrderListData(
        currentPage: data['current_page'] as int?,
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => OrderData.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderListData].
  factory OrderListData.fromJson(String data) {
    return OrderListData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderListData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderListData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => currentPage.hashCode ^ data.hashCode;
}
