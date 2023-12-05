import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/remove_todo_usecase.dart';

import '../../../../_helpers/containts.dart';
import '../../../../_mocks/repositories/todo_respository.mocks.dart';

Future<void> main() async {
  late MockTodoRepository mockTodoRepository;
  late RemoveTodoUsecase removeTodoUsecase;

  setUp(() async {
    mockTodoRepository = MockTodoRepository();
    removeTodoUsecase = RemoveTodoUsecase(todoRepository: mockTodoRepository);
  });

  group('RemoveTodoUsecase', () {
    test('should be a subclass of UseCase', () async {
      // assert
      expect(removeTodoUsecase, isA<Usecase>());
    });

    test('should return true after removing a new todo', () async {
      // arrange
      when(mockTodoRepository.removeTodo(testTodoModel.id))
          .thenAnswer((_) async => Future.value(true));

      // act
      final result = await removeTodoUsecase(id: testTodoModel.id);

      // assert
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return false after failing to remove a new todo', () async {
      // arrange
      when(mockTodoRepository.removeTodo(testTodoModel.id))
          .thenAnswer((_) => Future.value(false));

      // act
      final result = await removeTodoUsecase(id: testTodoModel.id);

      // assert
      expect(result, isA<bool>());
      expect(result, false);
    });
  });
}
