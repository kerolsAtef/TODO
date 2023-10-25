import 'package:flutter/material.dart';

import '../../data/local/db.dart';
import '../../data/remote/firestore_service.dart';
import '../../domain/models/to_do_model.dart';

class InsertViewModel {
  final LocalDatabase localDatabase;
  final FirestoreService firestoreService;

  InsertViewModel({required this.localDatabase, required this.firestoreService});

  // Function to handle the selected date and time
  DateTime selectedDateTime = DateTime.now();

  // Function to update the selected date and time
  void updateSelectedDateTime(DateTime newDateTime) {
    selectedDateTime = newDateTime;
  }

  // Function to save a new ToDo item
  Future<void> saveTodo(String title, String time) async {
    final todo = Todo(
      id: UniqueKey().toString(),
      title: title,
      time: time,
      isChecked: 0
    );

    // Save the ToDo item to local storage
    await localDatabase.createTodo(todo);

    // Save the ToDo item to Firestore
    await firestoreService.createTodo(todo);
  }
}
