part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  TodoLoadSuccess(this.todos);
}

class TodoError extends TodoState {
  final String error;

  TodoError(this.error);
}

class AddingTodoState extends TodoState {
  final Todo addedTodo;

  AddingTodoState(this.addedTodo);
}
