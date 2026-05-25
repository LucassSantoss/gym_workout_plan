import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gym_workout_plan/models/exercise.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('workout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    print('SQLite Database Path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE exercises (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        series INTEGER NOT NULL,
        repetitions INTEGER NOT NULL,
        observations TEXT
      )
    ''');
  }

  Future<int> insertExercise(Exercise exercise) async {
    final db = await instance.database;
    return await db.insert('exercises', exercise.toMap());
  }

  Future<List<Exercise>> getExercises() async {
    final db = await instance.database;
    final result = await db.query('exercises', orderBy: 'id DESC');
    return result.map((json) => Exercise.fromMap(json)).toList();
  }

  Future<int> deleteExercise(int id) async {
    final db = await instance.database;
    return await db.delete(
      'exercises',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateExercise(Exercise exercise) async {
    final db = await instance.database;
    return await db.update(
      'exercises',
      exercise.toMap(),
      where: 'id = ?',
      whereArgs: [exercise.id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
