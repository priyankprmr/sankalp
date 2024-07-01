import 'dart:collection';

import 'package:flutter/foundation.dart' show immutable;

@immutable
class CreateDispatchData extends MapView<String, dynamic> {
  final int type;
  final int orderId;
  final int invoiceNo;
  final String partyName;
  final String barcodeScan;
  final int id;
  final Iterable<String> item;
  final Iterable<int> intItemId;
  final Iterable<int> qty;
  final Iterable<String> caseNo;
  final Iterable<String> batchNumber;
  final String note;
  final String mode;
  CreateDispatchData({
    required this.type,
    required this.orderId,
    required this.invoiceNo,
    required this.partyName,
    required this.barcodeScan,
    required this.id,
    required this.item,
    required this.intItemId,
    required this.qty,
    required this.caseNo,
    required this.batchNumber,
    required this.note,
    required this.mode,
  }) : super(
          {
            "type": type,
            "order_id": orderId,
            "invoice_no": invoiceNo,
            "party_name": partyName,
            "BarcodeScan": barcodeScan,
            "api": 'true',
            "id": id,
            "Item": item,
            "intItemID": intItemId,
            "Qty": qty,
            "CaseNo": caseNo,
            "batch_number": batchNumber,
            "note": note,
            "mode": mode,
          },
        );
}
