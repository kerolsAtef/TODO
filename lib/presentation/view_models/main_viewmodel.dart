import '../../data/local/db.dart';
import '../../data/remote/firestore_service.dart';
import '../../domain/models/to_do_model.dart';

class HomeViewModel {
  final LocalDatabase localDatabase;
  final FirestoreService firestoreService;

  HomeViewModel({required this.localDatabase, required this.firestoreService});

  // List to hold ToDo items
  List<Todo> todoList = [];

  // Function to retrieve ToDo items from local storage
  Future<void> getLocalTodos() async {
    final todos = await localDatabase.getAllTodos();
    todoList = todos;
  }

  // Function to retrieve ToDo items from Firestore
  Future<void> getRemoteTodos() async {
    final todos = await firestoreService.getAllTodos();
    todoList = todos;
  }
}
