import 'dart:collection';
import 'dart:convert';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class CreateDispatchData extends MapView<String, dynamic> {
  CreateDispatchData({
    required int type,
    required String orderId,
    required String invoiceNo,
    required String partyName,
    required String barcodeScan,
    required int id,
    required Iterable<String> item,
    required Iterable<String> intItemId,
    required Iterable<String> qty,
    required Iterable<String> caseNo,
    required Iterable<String> batchNumber,
    required String note,
    required String mode,
  }) : super(
          {
            "type": type,
            "order_id": orderId,
            "invoice_no": invoiceNo,
            "party_name": partyName,
            "BarcodeScan": barcodeScan,
            "api": 'true',
            "id": id,
            "Item": jsonEncode(item),
            "intItemID": jsonEncode(intItemId),
            "Qty": jsonEncode(qty),
            "CaseNo": jsonEncode(caseNo),
            "batch_number": jsonEncode(batchNumber),
            "note": note,
            "mode": mode,
          },
        );
}
