import 'package:mockito/annotations.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/get_todos_usecase.dart';

import 'get_todos_usecase.mocks.dart';

class FakeGetTodoUsecase extends MockGetTodosUsecase
    implements GetTodosUsecase {
  final TodoRepository todoRepository;

  FakeGetTodoUsecase({
    required this.todoRepository,
  });
}

@GenerateNiceMocks([MockSpec<GetTodosUsecase>()])
void main() {}
