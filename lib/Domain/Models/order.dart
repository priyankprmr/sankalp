import 'package:flutter/foundation.dart' show immutable;

@immutable
class Order {
  final String productName;
  final String code;
  final String casrNumber;
  final String batchNumber;
  final String qty;

  const Order({
    required this.productName,
    required this.code,
    required this.casrNumber,
    required this.batchNumber,
    required this.qty,
  });
}
