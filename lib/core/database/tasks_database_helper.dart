import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/task_model.dart';

class TasksDatabaseHelper {
  TasksDatabaseHelper._();

  static final TasksDatabaseHelper db = TasksDatabaseHelper._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  initDb() async {
    String? path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE tasks(
      id INTEGER PRIMARY KEY,
       title TEXT NOT NULL,
       date TEXT NOT NULL,
       time TEXT NOT NULL,
      status TEXT NOT NULL)
      ''');
      },
    );
  }

  insert(TaskModel model) async {
    var dbClient = await database;
    await dbClient!.insert(
      'tasks',
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TaskModel>> getAllTasks() async {
    var dbClient = await database;
    List<Map> maps = await dbClient!.query('tasks');
    List<TaskModel> list = maps.isEmpty
        ? []
        : maps.map((task) => TaskModel.fromJson(task)).toList();
    return list;
  }

  updateTask(TaskModel model) async {
    var dbClient = await database;
    dbClient!.update('tasks', model.toJson(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  deleteTask(TaskModel model) async {
    var dbClient = await database;
    dbClient!.delete('tasks',
        where: 'id = ?', whereArgs: [model.id]);
  }
}
