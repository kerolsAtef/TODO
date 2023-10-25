import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../domain/models/to_do_model.dart';
import '../../domain/repositiories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository; // Repository for CRUD operations.

  TodoBloc({required this.todoRepository}) : super(TodoInitial());

    @override
    Stream<TodoState> mapEventToState(TodoEvent event) async* {
      if (event is UpdateTodoStatus) {
        try {
          // Update the 'isChecked' status of the ToDo item.
          await todoRepository.updateTodoStatus(event.todo);
          yield TodoLoadSuccess(await todoRepository.getAllTodos());
        } catch (e) {
          yield TodoError('Failed to update ToDo status: $e');
        }
      } else if (event is AddingTodo) {
        try {
          // Add the new ToDo item.
          await todoRepository.createTodo(event.todo);
          yield AddingTodoState(event.todo); // Emit the added ToDo item.
        } catch (e) {
          yield TodoError('Failed to add ToDo item: $e');
        }
      }
      // Handle other events like fetching and deleting ToDo items.
    }

  }

