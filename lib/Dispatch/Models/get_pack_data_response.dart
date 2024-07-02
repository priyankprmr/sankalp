import 'dart:convert';

import 'package:collection/collection.dart';

class GetPackDataResponse {
  int? count;
  int? productId;
  String? boxCode;
  int? productQty;
  String? productName;
  String? batchNumber;
  String? debitQty;

  GetPackDataResponse({
    this.count,
    this.productId,
    this.boxCode,
    this.productQty,
    this.productName,
    this.batchNumber,
    this.debitQty,
  });

  @override
  String toString() {
    return 'GetPackDataResponse(count: $count, productId: $productId, boxCode: $boxCode, productQty: $productQty, productName: $productName, batchNumber: $batchNumber, debitQty: $debitQty)';
  }

  factory GetPackDataResponse.fromMap(Map<String, dynamic> data) {
    return GetPackDataResponse(
      count: data['count'] as int?,
      productId: data['product_id'] as int?,
      boxCode: data['box_code'] as String?,
      productQty: data['product_qty'] as int?,
      productName: data['product_name'] as String?,
      batchNumber: data['batch_number'] as String?,
      debitQty: data['debit_qty'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'count': count,
        'product_id': productId,
        'box_code': boxCode,
        'product_qty': productQty,
        'product_name': productName,
        'batch_number': batchNumber,
        'debit_qty': debitQty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [GetPackDataResponse].
  factory GetPackDataResponse.fromJson(String data) {
    return GetPackDataResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetPackDataResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  GetPackDataResponse copyWith({
    int? count,
    int? productId,
    String? boxCode,
    int? productQty,
    String? productName,
    String? batchNumber,
    String? debitQty,
  }) {
    return GetPackDataResponse(
      count: count ?? this.count,
      productId: productId ?? this.productId,
      boxCode: boxCode ?? this.boxCode,
      productQty: productQty ?? this.productQty,
      productName: productName ?? this.productName,
      batchNumber: batchNumber ?? this.batchNumber,
      debitQty: debitQty ?? this.debitQty,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! GetPackDataResponse) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      count.hashCode ^
      productId.hashCode ^
      boxCode.hashCode ^
      productQty.hashCode ^
      productName.hashCode ^
      batchNumber.hashCode ^
      debitQty.hashCode;
}
