import 'package:sqflite/sqflite.dart';
import '../../domain/models/to_do_model.dart';

class LocalDatabase {
  final String dbName = 'todo_db.db';
  late Database _db;

  Future<void> initialize() async {
    _db = await openDatabase(dbName, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos (
        id TEXT PRIMARY KEY,
        title TEXT,
        time INTEGER,
        isChecked INTEGER
      )
    ''');
  }

  Database get database => _db;

  // Create a new ToDo item.
  Future<int> createTodo(Todo todo) async {
    return await _db.insert('todos', todo.toMap());
  }

  // Retrieve a single ToDo item by its ID.
  Future<Todo?> getTodo(String id) async {
    List<Map<String, dynamic>> result = await _db.query(
      'todos',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Todo.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Retrieve all ToDo items.
  Future<List<Todo>> getAllTodos() async {
    List<Map<String, dynamic>> results = await _db.query('todos');

    return results.map((data) => Todo.fromMap(data)).toList();
  }

  // Update an existing ToDo item.
  Future<int> updateTodo(Todo todo) async {
    return await _db.update('todos', todo.toMap(),
        where: 'id = ?', whereArgs: [todo.id]);
  }

  // Delete a ToDo item by its ID.
  Future<int> deleteTodo(String id) async {
    return await _db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
