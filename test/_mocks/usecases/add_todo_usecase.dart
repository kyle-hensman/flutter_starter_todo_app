import 'package:mockito/annotations.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/add_todo_usecase.dart';

import 'add_todo_usecase.mocks.dart';

class FakeAddTodoUsecase extends MockAddTodoUsecase implements AddTodoUsecase {
  final TodoRepository todoRepository;

  FakeAddTodoUsecase({
    required this.todoRepository,
  });
}

@GenerateNiceMocks([MockSpec<AddTodoUsecase>()])
void main() {}
