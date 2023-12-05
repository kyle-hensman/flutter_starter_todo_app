import 'package:mockito/annotations.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

import '../data_sources/local_todo_service.mocks.dart';

import 'todo_respository.mocks.dart';

class FakeTodoRepository extends MockTodoRepository implements TodoRepository {
  final MockLocalTodoService localTodoService;

  FakeTodoRepository({
    required this.localTodoService,
  });
}

@GenerateNiceMocks([MockSpec<TodoRepository>()])
void main() {}
