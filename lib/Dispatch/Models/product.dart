import 'package:flutter/foundation.dart' show immutable;

@immutable
class Product {
  final String productCode;
  final String caseNo;
  final String batchNo;
  final String qty;
  final String id;

  const Product({
    required this.productCode,
    required this.caseNo,
    required this.batchNo,
    required this.qty,
    required this.id,
  });
}