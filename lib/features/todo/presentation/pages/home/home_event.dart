import 'package:equatable/equatable.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

class GetTodos extends HomePageEvent {
  const GetTodos();
}

class AddTodo extends HomePageEvent {
  final TodoEntity todo;

  const AddTodo(
    this.todo,
  );

  @override
  List<Object?> get props => [
        todo,
      ];
}

class RemoveTodo extends HomePageEvent {
  final int id;

  const RemoveTodo(
    this.id,
  );

  @override
  List<Object?> get props => [
        id,
      ];
}

class ToggleTodo extends HomePageEvent {
  final int id;

  const ToggleTodo(
    this.id,
  );

  @override
  List<Object?> get props => [
        id,
      ];
}
