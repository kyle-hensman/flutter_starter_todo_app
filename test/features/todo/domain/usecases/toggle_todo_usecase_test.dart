import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/core/usecases/usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/toggle_todo_usecase.dart';

import '../../../../_helpers/containts.dart';
import '../../../../_mocks/repositories/todo_respository.mocks.dart';

Future<void> main() async {
  late MockTodoRepository mockTodoRepository;
  late ToggleTodoUsecase toggleTodoUsecase;

  setUp(() async {
    mockTodoRepository = MockTodoRepository();
    toggleTodoUsecase = ToggleTodoUsecase(todoRepository: mockTodoRepository);
  });

  group('ToggleTodoUsecase', () {
    test('should be a subclass of UseCase', () async {
      // assert
      expect(toggleTodoUsecase, isA<Usecase>());
    });

    test('should return true after successful toggling a todo', () async {
      // arrange
      when(mockTodoRepository.toggleTodo(testTodoModel.id))
          .thenAnswer((_) async => Future.value(true));

      // act
      final result = await toggleTodoUsecase(id: testTodoModel.id);

      // assert
      expect(result, isA<bool>());
      expect(result, true);
    });

    test('should return false after failing to toggling a todo', () async {
      // arrange
      when(mockTodoRepository.toggleTodo(testTodoModel.id))
          .thenAnswer((_) => Future.value(false));

      // act
      final result = await toggleTodoUsecase(id: testTodoModel.id);

      // assert
      expect(result, isA<bool>());
      expect(result, false);
    });
  });
}
