import 'package:flutter_starter_todo_app/features/todo/data/data_sources/local/local_todo_service.dart';
import 'package:isar_community/isar.dart';
import 'package:mockito/annotations.dart';

import 'local_todo_service.mocks.dart';

class FakeLocalTodoService extends MockLocalTodoService
    implements LocalTodoService {
  final Isar isar;

  FakeLocalTodoService({
    required this.isar,
  });
}

@GenerateNiceMocks([MockSpec<LocalTodoService>()])
void main() {}
