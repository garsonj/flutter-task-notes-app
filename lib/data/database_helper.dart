import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task_item.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  static const String _tableName = 'tasks';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task_notes_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    // Use appropriate directory based on platform
    final Directory appDir;
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      appDir = await getApplicationSupportDirectory();
    } else {
      appDir = await getApplicationDocumentsDirectory();
    }
    
    final path = join(appDir.path, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        priority INTEGER NOT NULL,
        description TEXT,
        isCompleted INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTask(TaskItem task) async {
    final db = await instance.database;
    final id = await db.insert(_tableName, task.toJson());
    return id;
  }

  Future<List<TaskItem>> getAllTasks() async {
    final db = await instance.database;
    final maps = await db.query(_tableName, orderBy: 'id DESC');
    return maps.map((m) => TaskItem.fromJson(m)).toList();
  }

  Future<int> updateTask(TaskItem task) async {
    final db = await instance.database;
    return await db.update(
      _tableName,
      task.toJson(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}