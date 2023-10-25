import 'package:sqflite/sqflite.dart';
import '../../data/local/db.dart';
import '../../domain/models/to_do_model.dart';

class TodoRepository {
  final LocalDatabase localDatabase;
  final Database database;

  TodoRepository({required this.localDatabase, required this.database});

  // Function to retrieve all ToDo items from local storage.
  Future<List<Todo>> getAllTodos() async {
    final List<Map<String, dynamic>> todoMaps = await database.query('todos');
    return List.generate(todoMaps.length, (i) {
      return Todo.fromMap(todoMaps[i]);
    });
  }

  // Function to update the 'isChecked' status of a ToDo item.
  Future<void> updateTodoStatus(Todo todo) async {
    await database.update(
      'todos',
      {
        'isChecked': todo.isChecked, // Convert bool to int (1 for true, 0 for false).
      },
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  // Function to create a new ToDo item in local storage.
  Future<void> createTodo(Todo todo) async {
    await database.insert(
      'todos',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
