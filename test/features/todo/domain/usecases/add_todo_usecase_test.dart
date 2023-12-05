import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/add_todo_usecase.dart';

import '../../../../_helpers/containts.dart';
import '../../../../_mocks/repositories/todo_respository.mocks.dart';

Future<void> main() async {
  late MockTodoRepository mockTodoRepository;
  late AddTodoUsecase addTodoUsecase;

  setUp(() async {
    mockTodoRepository = MockTodoRepository();
    addTodoUsecase = AddTodoUsecase(todoRepository: mockTodoRepository);
  });

  group('AddTodoUsecase', () {
    test('should be a subclass of UseCase', () async {
      // assert
      expect(addTodoUsecase, isA<Usecase>());
    });
    test('should return true after removing a new todo', () async {
      // arrange
      when(mockTodoRepository.addTodo(testTodoModel))
          .thenAnswer((_) async => Future.value(true));

      // act
      final result = await addTodoUsecase(todo: testTodoModel);

      // assert
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return false after failing to remove a new todo', () async {
      // arrange
      when(mockTodoRepository.addTodo(testTodoModel))
          .thenAnswer((_) => Future.value(false));

      // act
      final result = await addTodoUsecase(todo: testTodoModel);

      // assert
      expect(result, isA<bool>());
      expect(result, false);
    });
  });
}
