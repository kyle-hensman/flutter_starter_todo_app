import 'package:flutter_test/flutter_test.dart';
import 'package:isar_community/isar.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/features/todo/data/data_sources/local/local_todo_service.dart';
import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';

import '../../../../../_helpers/setup_isar.dart';
import '../../../../../_helpers/containts.dart';
import '../../../../../_helpers/isar_hepler.dart';
import '../../../../../_mocks/data_sources/local_todo_service.dart';
import '../../../../../_mocks/data_sources/local_todo_service.mocks.dart';

final listOfTodoModels = [testTodoModel];

void main() {
  late IsarHelper isarHelper;
  late Isar isar;
  late MockLocalTodoService mockLocalTodoService;

  setUpAll(() async {
    isarHelper = IsarHelper();
    isar = await setupIsar();
  });

  tearDownAll(() async {
    isar.close(deleteFromDisk: true);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.todos.clear();
      await isar.todos.putAll(listOfTodoModels);
    });
    mockLocalTodoService = FakeLocalTodoService(isar: isar);
  });

  group('LocalTodoService', () {
    test('should be a subclass of LocalTodoService', () async {
      // assert
      expect(mockLocalTodoService, isA<LocalTodoService>());
    });

    group('getTodos()', () {
      test('should return a list of valid todos stored in Local Storage',
          () async {
        // arrange
        when(mockLocalTodoService.getTodos()).thenAnswer(
          (_) => Future.value(listOfTodoModels),
        );

        // act
        final result = await mockLocalTodoService.getTodos();

        // assert
        verify(mockLocalTodoService.getTodos()).called(1);
        expect(result, isA<List<TodoModel>>());
        expect(result, listOfTodoModels);
        expect(result[0], isA<TodoModel>());
        expect(result[0].id, listOfTodoModels[0].id);
        expect(result[0].title, listOfTodoModels[0].title);
        expect(result[0].complete, listOfTodoModels[0].complete);
        expect(await isar.todos.count(), listOfTodoModels.length);
      });

      test('should return an empty list if no todos are found in Local Storage',
          () async {
        // arrange
        await isar.writeTxn(() async {
          await isar.todos.clear();
        });
        when(mockLocalTodoService.getTodos()).thenAnswer(
          (_) => Future.value(<TodoModel>[]),
        );

        // act
        final result = await mockLocalTodoService.getTodos();

        // assert
        verify(mockLocalTodoService.getTodos()).called(1);
        expect(result, isA<List<TodoModel>>());
        expect(result, []);
        expect(await isar.todos.count(), 0);
      });
    });

    group('addTodo()', () {
      test('should return true after saving a new todo to Local Storage',
          () async {
        // arrange
        when(mockLocalTodoService.addTodo(newTestTodoModel)).thenAnswer(
            (_) => isarHelper.addTodoToIsar(isar, newTestTodoModel));

        // act
        final result = await mockLocalTodoService.addTodo(newTestTodoModel);
        final todo = await isar.todos
            .filter()
            .idEqualTo(newTestTodoModel.id)
            .findFirst();

        // assert
        verify(mockLocalTodoService.addTodo(newTestTodoModel)).called(1);
        expect(result, isA<bool>());
        expect(result, true);

        if (todo != null) {
          expect(todo, isA<TodoModel>());
          expect(todo.id, newTestTodoModel.id);
          expect(todo.title, newTestTodoModel.title);
          expect(todo.complete, newTestTodoModel.complete);
        }

        expect(await isar.todos.count(), (listOfTodoModels.length + 1));
      });

      test(
          'should return false after failing to add a new todo to Local Storage',
          () async {
        // arrange
        when(mockLocalTodoService.addTodo(newTestTodoModel))
            .thenAnswer((_) => Future.value(false));

        // act
        final result = await mockLocalTodoService.addTodo(newTestTodoModel);

        // assert
        verify(mockLocalTodoService.addTodo(newTestTodoModel)).called(1);
        expect(result, isA<bool>());
        expect(result, false);
        expect(await isar.todos.count(), listOfTodoModels.length);
      });
    });

    group('removeTodo()', () {
      test(
          'should return true after removing a todo from Local Storage by the id',
          () async {
        // arrange
        when(mockLocalTodoService.removeTodo(newTestTodoModel.id)).thenAnswer(
            (_) => isarHelper.removeTodoFromIsar(
                isar, newTestTodoModel.id as int));

        // act
        final result = await mockLocalTodoService.removeTodo(2);

        // assert
        verify(mockLocalTodoService.removeTodo(2)).called(1);
        expect(result, isA<bool>());
        expect(result, true);
        expect(await isar.todos.count(), listOfTodoModels.length);
      });

      test(
          'should return false after failing to remove a todo from Local Storage by the id',
          () async {
        // arrange
        when(mockLocalTodoService.removeTodo(2)).thenAnswer(
          (_) => Future.value(false),
        );

        // act
        final result = await mockLocalTodoService.removeTodo(2);

        // assert
        verify(mockLocalTodoService.removeTodo(2)).called(1);
        expect(result, isA<bool>());
        expect(result, false);
        expect(await isar.todos.count(), listOfTodoModels.length);
      });
    });

    group('toggleTodo()', () {
      test(
          'should return true after toggling a todo from Local Storage by the id',
          () async {
        // arrange
        when(mockLocalTodoService.toggleTodo(testTodoModel.id)).thenAnswer(
            (_) =>
                isarHelper.toggleTodoFromIsar(isar, testTodoModel.id as int));

        // act
        final result = await mockLocalTodoService.toggleTodo(testTodoModel.id);

        // assert
        verify(mockLocalTodoService.toggleTodo(testTodoModel.id)).called(1);
        expect(result, isA<bool>());
        expect(result, true);
      });

      test(
          'should return false after failing to toggle a todo from Local Storage by the id',
          () async {
        // arrange
        when(mockLocalTodoService.toggleTodo(testTodoModel.id)).thenAnswer(
          (_) => Future.value(false),
        );

        // act
        final result = await mockLocalTodoService.toggleTodo(testTodoModel.id);

        // assert
        verify(mockLocalTodoService.toggleTodo(testTodoModel.id)).called(1);
        expect(result, isA<bool>());
        expect(result, false);
      });
    });
  });
}
