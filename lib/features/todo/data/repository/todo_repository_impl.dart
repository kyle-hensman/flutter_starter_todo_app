import 'package:flutter/foundation.dart';

import 'package:flutter_starter_todo_app/features/todo/data/data_sources/local/local_todo_service.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalTodoService _localTodoService;

  TodoRepositoryImpl({
    LocalTodoService? localTodoService,
  }) : _localTodoService = localTodoService ?? LocalTodoServiceImpl();

  @override
  Future<List<TodoEntity>> getTodos() async {
    try {
      var results = await _localTodoService.getTodos();
      return results;
    } catch (e) {
      debugPrint('Todo Repository - getTodos Error: $e');
      throw Exception('Todo Repository - getTodos Error: $e');
    }
  }

  @override
  Future<bool> addTodo(TodoEntity todo) async {
    try {
      var results = await _localTodoService.addTodo(todo);
      return Future.value(results);
    } catch (e) {
      debugPrint('Todo Repository - addTodo Error: $e');
      throw Exception('Todo Repository - addTodo Error: $e');
    }
  }

  @override
  Future<bool> removeTodo(int id) async {
    try {
      var results = await _localTodoService.removeTodo(id);
      return Future.value(results);
    } catch (e) {
      debugPrint('Todo Repository - removeTodo Error: $e');
      throw Exception('Todo Repository - removeTodo Error: $e');
    }
  }

  @override
  Future<bool> toggleTodo(int id) async {
    try {
      var results = await _localTodoService.toggleTodo(id);
      return Future.value(results);
    } catch (e) {
      debugPrint('Todo Repository - toggleTodo Error: $e');
      throw Exception('Todo Repository - toggleTodo Error: $e');
    }
  }
}
