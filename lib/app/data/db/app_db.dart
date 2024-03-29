import 'package:flutter/foundation.dart';
import 'package:machine_test_norq/app/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CartDatabaseProvider {
  static const String tableName = 'cart';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'cart_database.db'),
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $tableName(
            id INTEGER PRIMARY KEY,
            productId INTEGER,
            title TEXT,
            price REAL,
            description TEXT,
            category TEXT,
            image TEXT,
            ratingRate REAL,
            ratingCount INTEGER,
            quantity INTEGER
          )
          ''',
        );
      },
      version: 1,
    );
  }

  Future<bool> hasData() async {
    final db = await database;
    final count =
        Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM cart')) ??
            0;
    return count > 0;
  }

  Future<void> addToCart(ProductModel product) async {
    final db = await database;
    // Convert rating to JSON string
    await db.insert(
      tableName,
      product.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    ); // Use replace to handle conflicts
  }

  Future<void> removeFromCart(int id) async {
    final db = await database;
    await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> addToCartInDatabase(ProductModel product) async {
    try {
      final db = await database;
      final existingProduct = await db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [product.id],
      );
      if (existingProduct.isNotEmpty) {
        // If the product already exists in the cart, update its quantity
        final currentQuantity = existingProduct.first['quantity'] as int;
        await db.update(
          tableName,
          {'quantity': currentQuantity + 1},
          where: 'id = ?',
          whereArgs: [product.id],
        );
      } else {
        // If the product doesn't exist in the cart, insert it with quantity 1
        await db.insert(tableName, product.toJson());
      }
    } catch (e) {
      debugPrint('Error adding product to cart in database: $e');
      rethrow; // Propagate the error for handling elsewhere if needed
    }
  }

  Future<void> removeFromCartInDatabase(int productId) async {
    try {
      final db = await database;
      final existingProduct = await db.query(
        tableName,
        where: 'id = ?',
        whereArgs: [productId],
      );
      if (existingProduct.isNotEmpty) {
        // If the product exists in the cart, decrement its quantity
        final currentQuantity = existingProduct.first['quantity'] as int;
        if (currentQuantity > 1) {
          // If quantity is greater than 1, decrement it
          await db.update(
            tableName,
            {'quantity': currentQuantity - 1},
            where: 'id = ?',
            whereArgs: [productId],
          );
        } else {
          // If quantity is 1, remove the product from the cart
          await db.delete(
            tableName,
            where: 'id = ?',
            whereArgs: [productId],
          );
        }
      }
    } catch (e) {
      debugPrint('Error removing product from cart in database: $e');
      rethrow; // Propagate the error for handling elsewhere if needed
    }
  }

  Future<List<ProductModel>> getDbItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return ProductModel.fromMap(maps[i]);
    });
  }
}
