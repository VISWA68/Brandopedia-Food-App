import 'package:flutter/material.dart';
import 'package:food_app/data/local/db_helper.dart';
import 'package:food_app/models/food_item.dart';

class FavouritesProvider with ChangeNotifier {
  final List<FoodItem> _favourites = [];
  final DBHelper _dbHelper = DBHelper();

  List<FoodItem> get favourites => _favourites;

  Future<void> loadFavourites() async {
    final items = await _dbHelper.getFavourites();
    _favourites.clear();
    _favourites.addAll(items);
    notifyListeners();
  }

  bool isFavourite(int id) {
    return _favourites.any((item) => item.id == id);
  }

  Future<void> toggleFavourite(FoodItem item) async {
    final isFav = isFavourite(item.id);
    if (isFav) {
      await _dbHelper.removeFromFavourites(item.id);
      _favourites.removeWhere((i) => i.id == item.id);
    } else {
      await _dbHelper.addToFavourites(item);
      _favourites.add(item);
    }
    notifyListeners();
  }
}
