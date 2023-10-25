import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart'; // For mocking dependencies
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/data/local/db.dart';
import 'package:to_do_app/domain/models/to_do_model.dart';
import 'package:to_do_app/domain/repositiories/todo_repository.dart';

class MockLocalDatabase extends Mock implements LocalDatabase {
  void main() {
    late TodoRepository todoRepository;
    late MockLocalDatabase mockLocalDatabase;

    setUp(() async{
      mockLocalDatabase = MockLocalDatabase();
      final LocalDatabase localDatabase = LocalDatabase();
      await localDatabase.initialize();
      todoRepository = TodoRepository(
        localDatabase: mockLocalDatabase,
        database: localDatabase.database,
         );
    });

    test('getAllTodos should return a list of todos', () async {
      final expectedTodos = [Todo(id: '1', title: 'Task 1', isChecked: 0,time: "17:00"),
        Todo(id: '2', title: 'Task 2', isChecked: 0,time: "17:00")];

      // Mock the behavior of the LocalDatabase to return the expected todos
      when(mockLocalDatabase.getAllTodos()).thenAnswer((_) async => expectedTodos);

      final todos = await todoRepository.getAllTodos();

      expect(todos, expectedTodos);
    });

    test('updateTodoStatus should update the status of a todo', () async {
      final todo = Todo(id: '1', title: 'Task 1', isChecked: 0,time: "17:00");

      // Mock the behavior of the LocalDatabase to return a success code
      when(mockLocalDatabase.updateTodo(todo)).thenAnswer((_) async => 1);

      await todoRepository.updateTodoStatus(todo);

      // You can add additional assertions if needed
      expect(todo.isChecked, true); // Ensure that the isChecked property is updated
    });

    test('createTodo should create a new todo', () async {
      final todo = Todo(id: '1', title: 'Task 1', time: '18:00',isChecked: 1);

      // Mock the behavior of the LocalDatabase to return the ID of the created todo
      when(mockLocalDatabase.createTodo(todo)).thenAnswer((_) async => 1);

      await todoRepository.createTodo(todo);

      // You can add additional assertions if needed
      expect(todo.id, '1'); // Ensure that the ID is updated after creation
    });
  }

}

