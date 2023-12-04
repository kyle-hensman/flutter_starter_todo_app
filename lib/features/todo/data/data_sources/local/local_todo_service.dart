import 'package:flutter/foundation.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:isar/isar.dart';

import 'package:flutter_starter_todo_app/core/utils/locator.dart';
import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';

abstract class LocalTodoService {
  Future<List<TodoEntity>> getTodos();
  Future<bool> addTodo(TodoEntity todo);
  Future<bool> removeTodo(int id);
  Future<bool> toggleTodo(int id);
}

class LocalTodoServiceImpl implements LocalTodoService {
  final Isar _isar;

  LocalTodoServiceImpl({
    Isar? isar,
  }) : _isar = isar ?? locator.get<Isar>();

  @override
  Future<List<TodoEntity>> getTodos() async {
    final List<TodoEntity> todoEntities = [];
    try {
      final todos = await _isar.todos.where().findAll();

      for (final todo in todos) {
        todoEntities.add(todo.toEntity());
      }

      if (todoEntities.isNotEmpty) {
        return todoEntities;
      } else {
        return [];
      }
    } catch (e) {
      debugPrint('Local Todo Service - getTodos Error: $e');
      throw Exception('Local Todo Service - getTodos Error: $e');
    }
  }

  @override
  Future<bool> addTodo(TodoEntity todo) async {
    int? id;
    final todoModel = TodoModel(
      id: todo.id,
      title: todo.title,
      complete: todo.complete,
    );

    try {
      await _isar.writeTxn(() async {
        id = await _isar.todos.put(todoModel);
      });
      return id != null;
    } catch (e) {
      debugPrint('Local Todo Service - addTodo Error: $e');
      throw Exception('Local Todo Service - addTodo Error: $e');
    }
  }

  @override
  Future<bool> removeTodo(int id) async {
    try {
      bool success = false;
      await _isar.writeTxn(() async {
        success = await _isar.todos.delete(id);
      });
      return success;
    } catch (e) {
      debugPrint('Local Todo Service - removeTodo Error: $e');
      throw Exception('Local Todo Service - removeTodo Error: $e');
    }
  }

  @override
  Future<bool> toggleTodo(int id) async {
    print('toggle todo');
    try {
      bool success = false;
      var todo = await _isar.todos.filter().idEqualTo(id).findFirst();
      print(todo);

      if (todo != null) {
        await _isar.writeTxn(() async {
          print(todo);

          await _isar.todos.put(TodoModel(
            id: todo.id,
            title: todo.title,
            complete: !todo.complete,
          ));
          success = true;
        });
      }
      return success;
    } catch (e) {
      debugPrint('Local Todo Service - toggleTodo Error: $e');
      throw Exception('Local Todo Service - toggleTodo Error: $e');
    }
  }
}
