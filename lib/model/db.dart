import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:my_notes/model/model.dart';

const toDoActiveStatus = 0;
const toDoDoneStatus = 1;

const databaseName = 'todos.db';
const databaseVersion = 1;
const sqlCreate = '''
CREATE TABLE "todos" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "title" TEXT NOT NULL,
	 "created" text NOT NULL,
	 "updated" TEXT NOT NULL,
	 "status" integer DEFAULT $toDoActiveStatus
);
''';

const toDoTable = 'todos';

class DB {
  DB._();

  static final DB sharedInstance = DB._();

  Database _database;

  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<Database> initDB() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    String path = join(docsDirectory.path, databaseName);

    return await openDatabase(path, version: databaseVersion,
        onCreate: (Database db, int version) async {
      await db.execute(sqlCreate);
    });
  }

  void createTodo(Todo todo) async {
    final db = await database;
    await db.insert(toDoTable, todo.toMapAutoID());
  }

  void updateTodo(Todo todo) async {
    final db = await database;
    await db
        .update(toDoTable, todo.toMap(), where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteTodo(Todo todo) async {
    final db = await database;
    await db.delete(toDoTable, where: 'id=?', whereArgs: [todo.id]);
  }

  void deleteAllTodos({int status = toDoDoneStatus}) async {
    final db = await database;
    await db.delete(toDoTable, where: 'status=?', whereArgs: [status]);
  }

  Future<List<Todo>> retrieveTodos(
      {TodoStatus status = TodoStatus.active}) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(toDoTable,
        where: 'status=?', whereArgs: [status.index], orderBy: 'updated ASC');

    // Convert List<Map<String, dynamic>> to List<Todo_object>
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        created: DateTime.parse(maps[i]['created']),
        updated: DateTime.parse(maps[i]['updated']),
        status: maps[i]['status'],
      );
    });
  }
}
