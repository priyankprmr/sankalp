import 'package:flutter/foundation.dart' show immutable;

@immutable
class Product {
  final String productCode;
  final String caseNo;
  final String batchNo;
  final int qty;

  const Product({
    required this.productCode,
    required this.caseNo,
    required this.batchNo,
    required this.qty,
  });
}
