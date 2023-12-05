import 'package:mockito/annotations.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/toggle_todo_usecase.dart';

import 'toggle_todo_usecase.mocks.dart';

class FakeToggleTodoUsecase extends MockToggleTodoUsecase
    implements ToggleTodoUsecase {
  final TodoRepository todoRepository;

  FakeToggleTodoUsecase({
    required this.todoRepository,
  });
}

@GenerateNiceMocks([MockSpec<ToggleTodoUsecase>()])
void main() {}
