import 'package:food_app/models/food_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._();
  static Database? _db;

  DBHelper._();

  factory DBHelper() => _instance;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'app_data.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) {
    db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        image TEXT,
        quantity INTEGER
      )
    ''');

    db.execute('''
      CREATE TABLE favourites (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        image TEXT,
        isVeg INTEGER,
        foodType TEXT
      )
    ''');
  }

  Future<void> insertOrUpdateCart(FoodItem item, int quantity) async {
    final db = await database;
    await db.insert('cart', {
      'id': item.id,
      'name': item.name,
      'price': item.price,
      'image': item.image,
      'quantity': quantity
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteCartItem(int id) async {
    final db = await database;
    await db.delete('cart', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    final db = await database;
    return await db.query('cart');
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }

   Future<void> addToFavourites(FoodItem item) async {
    final db = await database;
    await db.insert('favourites', {
      'id': item.id,
      'name': item.name,
      'price': item.price,
      'image': item.image,
      'isVeg': item.isVeg ? 1 : 0,
      'foodType': item.foodType
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeFromFavourites(int id) async {
    final db = await database;
    await db.delete('favourites', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FoodItem>> getFavourites() async {
    final db = await database;
    final result = await db.query('favourites');
    return result.map((json) => FoodItem(
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      image: json['image'] as String,
      isVeg: (json['isVeg'] as int) == 1,
      foodType: json['foodType'] as String,
    )).toList();
  }

  Future<bool> isFavourite(int id) async {
    final db = await database;
    final result = await db.query('favourites', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}

