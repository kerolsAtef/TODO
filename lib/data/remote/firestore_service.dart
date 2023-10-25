import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/models/to_do_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId; // Add a user ID to identify the current user.

  FirestoreService(this.userId);

  // Create a new ToDo item in Firestore for the specific user.
  Future<void> createTodo(Todo todo) async {
    await _firestore.collection('users').doc(userId).collection('todos').add({
      'title': todo.title,
      'time': todo.time,
      'isChecked': todo.isChecked,
    });
  }

  // Retrieve a single ToDo item from Firestore by its document ID for the specific user.
  Future<Todo> getTodo(String documentId) async {
    final DocumentSnapshot doc = await _firestore.collection('users').doc(userId).collection('todos').doc(documentId).get();

    return Todo(
      id: documentId,
      title: doc['title'],
      time: doc['time'],
      isChecked: doc['isChecked'],
    );
  }

  // Retrieve all ToDo items from Firestore for the specific user.
  Future<List<Todo>> getAllTodos() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('users').doc(userId).collection('todos').get();

    return querySnapshot.docs.map((doc) {
      return Todo(
        id: doc.id,
        title: doc['title'],
        time: doc['time'],
        isChecked: doc['isChecked'],
      );
    }).toList();
  }

  // Update an existing ToDo item in Firestore for the specific user.
  Future<void> updateTodo(Todo todo) async {
    await _firestore.collection('users').doc(userId).collection('todos').doc(todo.id).update({
      'title': todo.title,
      'time': todo.time,
      'isChecked': todo.isChecked,
    });
  }

  // Delete a ToDo item from Firestore by its document ID for the specific user.
  Future<void> deleteTodo(String documentId) async {
    await _firestore.collection('users').doc(userId).collection('todos').doc(documentId).delete();
  }
}
