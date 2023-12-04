import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<bool> addTodo(TodoEntity todo);
  Future<bool> removeTodo(int id);
  Future<bool> toggleTodo(int id);
}
