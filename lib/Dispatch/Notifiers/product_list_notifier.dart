import 'package:flutter/material.dart';
import 'package:sankalp/Dispatch/Models/product.dart';

class ProductListNotifier extends ChangeNotifier {
  final List<Product> _productList = [];
  List<Product> get productList => _productList;

  void add(Product product) {
    _productList.add(product);
    notifyListeners();
  }

  void remove(int index) {
    _productList.removeAt(index);
    notifyListeners();
  }
}
