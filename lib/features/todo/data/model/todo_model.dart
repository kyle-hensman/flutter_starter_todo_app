// ignore_for_file: overridden_fields, annotate_overrides

import 'package:isar_community/isar.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';

part 'todo_model.g.dart';

@Collection(inheritance: false, accessor: 'todos')
@Name('Todo')
class TodoModel extends TodoEntity {
  @override
  final Id? id;
  final String? title;
  final bool complete;

  const TodoModel({
    this.id = Isar.autoIncrement,
    this.title,
    this.complete = false,
  });

  @override
  String toString() {
    return 'TodoModel($id, $title, $complete)';
  }

  TodoEntity toEntity() {
    return TodoEntity(
      id: id ?? 0,
      title: title ?? '',
      complete: complete,
    );
  }

  factory TodoModel.fromEntity(TodoEntity todo) {
    return TodoModel(
      id: todo.id ?? 0,
      title: todo.title ?? '',
      complete: todo.complete,
    );
  }
}
