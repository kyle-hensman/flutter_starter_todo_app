import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';

class IsarHelper {
  Future<bool> addTodoToIsar(Isar isar, TodoModel newTodo) async {
    await isar.writeTxn(() async {
      await isar.todos.put(newTodo);
    });
    return Future.value(true);
  }

  Future<bool> removeTodoFromIsar(Isar isar, int id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
    return Future.value(true);
  }

  Future<bool> toggleTodoFromIsar(Isar isar, int id) async {
    await isar.writeTxn(() async {
      var todo = await isar.todos.where().idEqualTo(id).findFirst();
      if (todo != null && todo.id != null && todo.title != null) {
        await isar.todos.put(
            TodoModel(id: id, title: todo.title, complete: !todo.complete));
      }
    });
    return Future.value(true);
  }
}
