import 'package:flutter/material.dart';
import 'package:food_app/data/local/db_helper.dart';
import 'package:food_app/models/food_item.dart';

class CartProvider with ChangeNotifier {
  final Map<int, int> _cart = {};
  final Map<int, FoodItem> _items = {};
  final DBHelper _dbHelper = DBHelper();

  CartProvider() {
    loadCartFromDB();
  }

  Future<void> loadCartFromDB() async {
    final data = await _dbHelper.getCart();
    for (var row in data) {
      final item = FoodItem(
        id: row['id'],
        name: row['name'],
        price: row['price'],
        image: row['image'],
        isVeg: true,
        foodType: 'food',
      );
      _items[item.id] = item;
      _cart[item.id] = row['quantity'];
    }
    notifyListeners();
  }

  int getQuantity(int id) {
    return _cart[id] ?? 0;
  }

  void addToCart(FoodItem item) {
    if (_cart.containsKey(item.id)) {
      _cart[item.id] = _cart[item.id]! + 1;
    } else {
      _cart[item.id] = 1;
      _items[item.id] = item;
    }
    _dbHelper.insertOrUpdateCart(item, _cart[item.id]!);
    notifyListeners();
  }

  void increaseQty(int id) {
    _cart[id] = _cart[id]! + 1;
    _dbHelper.insertOrUpdateCart(_items[id]!, _cart[id]!);
    notifyListeners();
  }

  void decreaseQty(int id) {
    if (_cart[id]! > 1) {
      _cart[id] = _cart[id]! - 1;
      _dbHelper.insertOrUpdateCart(_items[id]!, _cart[id]!);
    } else {
      _cart.remove(id);
      _items.remove(id);
      _dbHelper.deleteCartItem(id);
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

  int get totalPrice =>
      _cart.entries.fold(0, (sum, e) => sum + (_items[e.key]!.price * e.value));
}
