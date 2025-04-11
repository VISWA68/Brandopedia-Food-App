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
    final path = join(await getDatabasesPath(), 'cart.db');
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
  }

  Future<void> insertOrUpdateItem(FoodItem item, int quantity) async {
    final db = await database;
    await db.insert('cart', {
      'id': item.id,
      'name': item.name,
      'price': item.price,
      'image': item.image,
      'quantity': quantity
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCart() async {
    final db = await database;
    return await db.query('cart');
  }

  Future<void> clearCart() async {
    final db = await database;
    await db.delete('cart');
  }
}
