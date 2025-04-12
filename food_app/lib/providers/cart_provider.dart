import 'package:flutter/material.dart';
import 'package:food_app/models/food_item.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _cart = {}; 
  final Map<int, FoodItem> _items = {};

  void addToCart(FoodItem item) {
    if (_cart.containsKey(item.id)) {
      _cart[item.id] = _cart[item.id]! + 1;
    } else {
      _cart[item.id] = 1;
      _items[item.id] = item;
    }
    notifyListeners();
  }

  void increaseQty(int id) {
    _cart[id] = _cart[id]! + 1;
    notifyListeners();
  }

  void decreaseQty(int id) {
    if (_cart[id]! > 1) {
      _cart[id] = _cart[id]! - 1;
    } else {
      _cart.remove(id);
      _items.remove(id);
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get items => _cart.entries.map((e) {
        final item = _items[e.key]!;
        return {
          'item': item,
          'qty': e.value,
        };
      }).toList();

  int get totalPrice => _cart.entries.fold(0, (sum, e) => sum + (_items[e.key]!.price * e.value));
}