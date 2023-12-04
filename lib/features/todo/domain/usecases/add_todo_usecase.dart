import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/core/utils/locator.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

class AddTodoUsecase implements Usecase<bool, void> {
  final TodoRepository _todoRepository;

  AddTodoUsecase({
    TodoRepository? todoRepository,
  }) : _todoRepository = todoRepository ?? locator.get<TodoRepository>();

  @override
  Future<bool> call({void params, TodoEntity? todo}) {
    if (todo != null) {
      return _todoRepository.addTodo(todo);
    } else {
      return Future.value(false);
    }
  }
}
