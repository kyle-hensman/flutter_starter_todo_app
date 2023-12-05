import 'package:mockito/annotations.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/remove_todo_usecase.dart';

import 'remove_todo_usecase.mocks.dart';

class FakeRemoveTodoUsecase extends MockRemoveTodoUsecase
    implements RemoveTodoUsecase {
  final TodoRepository todoRepository;

  FakeRemoveTodoUsecase({
    required this.todoRepository,
  });
}

@GenerateNiceMocks([MockSpec<RemoveTodoUsecase>()])
void main() {}
