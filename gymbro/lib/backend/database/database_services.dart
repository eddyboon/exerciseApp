import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final StreamController<List<String>> _exerciseNamesController =
      StreamController<List<String>>.broadcast();
  final StreamController<List<int>> _exerciseRepsController =
      StreamController<List<int>>.broadcast();
  final StreamController<List<int>> _exerciseSetsController =
      StreamController<List<int>>.broadcast();

  final String exerciseTable = 'exercises';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  DatabaseService() {
    _initializeStreams();
  }

  void _initializeStreams() {
    _getExerciseNames();
    _getExerciseReps();
    _getExerciseSets();
  }

  Stream<List<String>> get exerciseNames => _exerciseNamesController.stream;
  Stream<List<int>> get exerciseReps => _exerciseRepsController.stream;
  Stream<List<int>> get exerciseSets => _exerciseSetsController.stream;

  void notifyListeners() {
    _getExerciseNames();
    _getExerciseReps();
    _getExerciseSets();
  }

  void disposeStreams() {
    _exerciseNamesController.close();
    _exerciseRepsController.close();
    _exerciseSetsController.close();
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

  // Get all exercises
  Future<List<Map<String, dynamic>>> getExercises() async {
    final db = await database;
    return db.query(exerciseTable);
  }

  // Get all exercise names
  Future<List<String>> getExerciseNamesList() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    return List.generate(maps.length, (index) => maps[index]['name']);
  }

  // Get all exercise names as Stream of Strings
  void _getExerciseNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    _exerciseNamesController
        .add(List.generate(maps.length, (index) => maps[index]['name']));
  }

  // Get all exercise reps
  Future<List<int>> getExerciseRepsList() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    return List.generate(maps.length, (index) => maps[index]['reps']);
  }

  // get all exercise reps as Stream of Integers
  void _getExerciseReps() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    _exerciseRepsController
        .add(List.generate(maps.length, (index) => maps[index]['reps']));
  }

  // Get all exercise sets
  Future<List<int>> getExerciseSetsList() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    return List.generate(maps.length, (index) => maps[index]['sets']);
  }

  // Get all exercise sets as Stream of Integers
  void _getExerciseSets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    _exerciseSetsController
        .add(List.generate(maps.length, (index) => maps[index]['sets']));
  }

  // Get all exercise weights
  Future<List<int>> getExerciseWeightsList() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    return List.generate(maps.length, (index) => maps[index]['weights']);
  }

  // Get all exercise types
  Future<List<String>> getExerciseTypesList() async {
    final db = await database;
    List<Map<String, dynamic>> maps = await db.query(exerciseTable);
    return List.generate(maps.length, (index) => maps[index]['type']);
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
