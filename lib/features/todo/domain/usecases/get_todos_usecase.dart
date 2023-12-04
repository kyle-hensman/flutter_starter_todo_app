import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/core/utils/locator.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

class GetTodosUsecase implements Usecase<List<TodoEntity>, void> {
  final TodoRepository _todoRepository;

  GetTodosUsecase({
    TodoRepository? todoRepository,
  }) : _todoRepository = todoRepository ?? locator.get<TodoRepository>();

  @override
  Future<List<TodoEntity>> call({void params}) async {
    return await _todoRepository.getTodos();
  }
}
