import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlLiteService extends GetxService {
  late Database _database;

  Future<void> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'ladangsantara.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE IF NOT EXISTS `regions` (
          `id` INTEGER PRIMARY KEY AUTOINCREMENT,
          `name` TEXT,
          `phone` TEXT,
          `address` TEXT,
          `province` TEXT,
          `regency` TEXT,
          `district` TEXT,
          `village` TEXT,
          `postal_code` TEXT,
          `is_default` INTEGER,
          `created_at` TEXT,
          `updated_at` TEXT,
          `deleted_at` TEXT
        )
      ''');
      },
    );

    // Print the schema to the console for verification
    List<Map<String, dynamic>> tableInfo =
        await _database.rawQuery('PRAGMA table_info(regions)');
    print(tableInfo);
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    return await _database.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    try {
      // Try to execute the query if _database is already initialized
      return await _database.query(table);
    } catch (e) {
      // If _database is not yet initialized, wait until it is initialized
      await Future.delayed(const Duration(milliseconds: 100));
      return await query(table); // Retry the query
    }
  }

  Future<int> update(String table, Map<String, dynamic> data) async {
    return await _database.update(
      table,
      data,
      where: 'id = ?',
      whereArgs: [data['id']],
    );
  }

  Future<int> delete(String table, int id) async {
    return await _database.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  void onInit() async {
    super.onInit();
    await initDatabase();
  }
}
