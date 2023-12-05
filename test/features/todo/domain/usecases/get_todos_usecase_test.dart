import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/get_todos_usecase.dart';

import '../../../../_helpers/containts.dart';
import '../../../../_mocks/repositories/todo_respository.mocks.dart';

Future<void> main() async {
  late MockTodoRepository mockTodoRepository;
  late GetTodosUsecase getTodosUsecase;

  setUp(() async {
    mockTodoRepository = MockTodoRepository();
    getTodosUsecase = GetTodosUsecase(todoRepository: mockTodoRepository);
  });

  group('GetTodosUsecase', () {
    test('should be a subclass of UseCase', () async {
      // assert
      expect(getTodosUsecase, isA<Usecase>());
    });

    test('should return a list of valid todos from the respotiory', () async {
      // arrange
      when(mockTodoRepository.getTodos())
          .thenAnswer((_) async => Future.value([testTodoEntity]));

      // act
      final result = await getTodosUsecase();

      // assert
      expect(result, isA<List<TodoEntity>>());
      expect(result, [testTodoEntity]);
      expect(result[0], isA<TodoEntity>());
      expect(result[0].id, testTodoEntity.id);
      expect(result[0].title, testTodoEntity.title);
      expect(result[0].complete, testTodoEntity.complete);
    });

    test('should return an empty list if no todos are found in the repository',
        () async {
      // arrange
      when(mockTodoRepository.getTodos())
          .thenAnswer((_) async => Future.value([]));

      // act
      final result = await getTodosUsecase();

      // assert
      expect(result, isA<List<TodoEntity>>());
      expect(result, []);
    });
  });
}
