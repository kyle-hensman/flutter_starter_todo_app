import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';

import 'package:flutter_starter_todo_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';

import '../../../../_helpers/setup_isar.dart';
import '../../../../_mocks/data_sources/local_todo_service.dart';
import '../../../../_mocks/data_sources/local_todo_service.mocks.dart';

void main() {
  late Isar isar;
  late MockLocalTodoService mockLocalTodoService;
  late TodoRepository todoRepository;

  setUpAll(() async {
    isar = await setupIsar();
  });

  tearDownAll(() async {
    isar.close(deleteFromDisk: true);
  });

  setUp(() async {
    mockLocalTodoService = FakeLocalTodoService(isar: isar);
    todoRepository = TodoRepositoryImpl(localTodoService: mockLocalTodoService);
  });

  group('TodoRepository', () {
    test('should create a subclass of the TodoRepository', () async {
      // assert
      expect(todoRepository, isA<TodoRepository>());
    });
  });
}
