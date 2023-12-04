import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/core/utils/locator.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

class ToggleTodoUsecase implements Usecase<bool, void> {
  final TodoRepository _todoRepository;

  ToggleTodoUsecase({
    TodoRepository? todoRepository,
  }) : _todoRepository = todoRepository ?? locator.get<TodoRepository>();

  @override
  Future<bool> call({void params, int? id}) {
    print('toggle usecase');
    if (id != null) {
      return _todoRepository.toggleTodo(id);
    } else {
      return Future.value(false);
    }
  }
}
