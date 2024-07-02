import 'dart:convert';

import 'package:collection/collection.dart';

class OrderData {
  int? id;
  String? seqNo;
  String? type;
  String? orderId;
  String? invoiceNo;
  String? partyName;
  dynamic note;
  String? chrPublish;
  String? chrDelete;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderData({
    this.id,
    this.seqNo,
    this.type,
    this.orderId,
    this.invoiceNo,
    this.partyName,
    this.note,
    this.chrPublish,
    this.chrDelete,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderData.fromMap(Map<String, dynamic> data) => OrderData(
        id: data['id'] as int?,
        seqNo: data['seq_no'] as String?,
        type: data['type'] as String?,
        orderId: data['order_id'] as String?,
        invoiceNo: data['invoice_no'] as String?,
        partyName: data['party_name'] as String?,
        note: data['note'] as dynamic,
        chrPublish: data['chrPublish'] as String?,
        chrDelete: data['chrDelete'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'seq_no': seqNo,
        'type': type,
        'order_id': orderId,
        'invoice_no': invoiceNo,
        'party_name': partyName,
        'note': note,
        'chrPublish': chrPublish,
        'chrDelete': chrDelete,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderData].
  factory OrderData.fromJson(String data) {
    return OrderData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! OrderData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      seqNo.hashCode ^
      type.hashCode ^
      orderId.hashCode ^
      invoiceNo.hashCode ^
      partyName.hashCode ^
      note.hashCode ^
      chrPublish.hashCode ^
      chrDelete.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;
}
