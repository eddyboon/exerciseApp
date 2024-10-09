import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String tableName = 'exercises';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'gymbro.db');
    final database =
        await openDatabase(databasePath, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE $tableName(
          name TEXT PRIMARY KEY,
          sets INTEGER,
          reps INTEGER
        )
      ''');
    });

    return database;
  }

  void addExercise(String name, int sets, int reps) async {
    final db = await database;
    await db.insert(tableName, {'name': name, 'sets': sets, 'reps': reps});
  }
}
