import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String exerciseTable = 'exercises';

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
    final database = await openDatabase(databasePath, version: 1,
        onCreate: (db, version) async {
      // type is either push or pull
      // currentDay is the day of exercise that was last done. Eg. if there is pull, push, pull and it is 3 days, and the last day was pull, then the next day will be push, so currentDay will be 1 so that we kno the next day is push
      await db.execute('''
        CREATE TABLE $exerciseTable(
          name TEXT PRIMARY KEY,
          sets INTEGER NOT NULL,
          reps INTEGER NOT NULL,
          weights INTEGER NOT NULL,
          type TEXT NOT NULL,
          currentDay INTEGER NOT NULL
        )
      ''');
    });

    return database;
  }

  void addExercise(String name, int sets, int reps, int weights, String type,
      int currentDay) async {
    final db = await database;
    await db.insert(
      exerciseTable,
      {
        'name': name,
        'sets': sets,
        'reps': reps,
        'weights': weights,
        'type': type,
        'currentDay': currentDay
      },
    );
  }

  // Get currentDay of first exercise
  Future<int> getFirstExerciseDay() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    if (maps.isNotEmpty) {
      return maps[0]['currentDay'] ?? 0;
    } else {
      return 0;
    }
  }

  // Set currentDay to all exercises
  void setAllExercisesDay(int day) async {
    final db = await database;
    await db.update(exerciseTable, {'currentDay': day});
  }

  // Delete database
  Future<void> deleteDatabase() async {
    databaseFactory.deleteDatabase(await getDatabasesPath());
  }
}
