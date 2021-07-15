import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutterprovider/model/product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _items = <Product>[];

  final int unitPrice = 50;
  int _totalCountProduct = 0;

  int get totalCountProduct => _totalCountProduct;

  UnmodifiableListView<Product> get items =>
      UnmodifiableListView<Product>(_items);

  void addItem(int id, Product item) {
    _items.add(item);
    notifyListeners();
  }

  void addCount() {
    _totalCountProduct++;
    notifyListeners();
  }

  void clearItem() {
    _items.clear();
    _totalCountProduct = 0;
    notifyListeners();
  }

  int quantity(int id) {
    return _items[id].quantity;
  }

  int get totalPrice {
    int total = 0;

    for (int i = 0; i < _items.length; i++) {
      total += _items[i].quantity * unitPrice;
    }
    return total;
  }
}
