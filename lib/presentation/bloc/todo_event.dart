part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class UpdateTodoStatus extends TodoEvent {
  final Todo todo;

  UpdateTodoStatus(this.todo);
}

class AddingTodo extends TodoEvent {
  final Todo todo;

  AddingTodo(this.todo);
}

