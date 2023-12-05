import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';
import 'package:flutter_starter_todo_app/features/todo/data/repository/todo_repository_impl.dart';

import '../../../../_helpers/setup_isar.dart';
import '../../../../_helpers/containts.dart';
import '../../../../_helpers/isar_hepler.dart';
import '../../../../_mocks/data_sources/local_todo_service.dart';
import '../../../../_mocks/data_sources/local_todo_service.mocks.dart';

final listOfTestTodoModles = [testTodoModel];

void main() {
  late IsarHelper isarHelper;
  late Isar isar;
  late MockLocalTodoService mockLocalTodoService;
  late TodoRepositoryImpl todoRepositoryImpl;

  setUpAll(() async {
    isar = await setupIsar();
    isarHelper = IsarHelper();
  });

  tearDownAll(() async {
    isar.close(deleteFromDisk: true);
  });

  setUp(() async {
    await isar.writeTxn(() async {
      await isar.todos.clear();
      await isar.todos.putAll(listOfTestTodoModles);
    });
    mockLocalTodoService = FakeLocalTodoService(isar: isar);
    todoRepositoryImpl =
        TodoRepositoryImpl(localTodoService: mockLocalTodoService);
  });

  group('getTodos()', () {
    test(
        'should return a list of valid todos when a call to data source is successful',
        () async {
      // arrange
      when(todoRepositoryImpl.getTodos())
          .thenAnswer((_) async => Future.value(listOfTestTodoModles));

      // active
      final result = await todoRepositoryImpl.getTodos();

      // assert
      verify(todoRepositoryImpl.getTodos()).called(1);
      expect(result, listOfTestTodoModles);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });

    test(
        'should return an empty list if no todos are found when calling to data source is successful',
        () async {
      // arrange
      await isar.writeTxn(() async {
        await isar.todos.clear();
      });
      when(todoRepositoryImpl.getTodos()).thenAnswer(
        (_) => Future.value(<TodoModel>[]),
      );

      // act
      final result = await todoRepositoryImpl.getTodos();

      // assert
      verify(todoRepositoryImpl.getTodos()).called(1);
      expect(result, isA<List<TodoModel>>());
      expect(result, []);
      expect(await isar.todos.count(), 0);
    });
  });

  group('addTodo()', () {
    test('should return true after saving a new todo to Local Storage',
        () async {
      // arrange
      when(todoRepositoryImpl.addTodo(newTestTodoModel))
          .thenAnswer((_) => isarHelper.addTodoToIsar(isar, newTestTodoModel));

      // act
      final result = await todoRepositoryImpl.addTodo(newTestTodoModel);

      // assert
      verify(todoRepositoryImpl.addTodo(newTestTodoModel)).called(1);
      expect(result, isA<bool>());
      expect(result, true);
      expect(await isar.todos.count(), listOfTestTodoModles.length + 1);
    });

    test('should return false after failing to add a new todo to Local Storage',
        () async {
      // arrange
      when(todoRepositoryImpl.addTodo(newTestTodoModel))
          .thenAnswer((_) => Future.value(false));

      // act
      final result = await todoRepositoryImpl.addTodo(newTestTodoModel);

      // assert
      verify(todoRepositoryImpl.addTodo(newTestTodoModel)).called(1);
      expect(result, isA<bool>());
      expect(result, false);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });
  });

  group('removeTodo()', () {
    test(
        'should return true after removing a todo from Local Storage by the id',
        () async {
      // arrange
      when(todoRepositoryImpl.removeTodo(newTestTodoModel.id as int))
          .thenAnswer((_) =>
              isarHelper.removeTodoFromIsar(isar, newTestTodoModel.id as int));

      // act
      final result =
          await todoRepositoryImpl.removeTodo(newTestTodoModel.id as int);

      // assert
      verify(todoRepositoryImpl.removeTodo(newTestTodoModel.id as int))
          .called(1);
      expect(result, isA<bool>());
      expect(result, true);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });

    test('should return false after failing to remove a todo from LocalStorage',
        () async {
      // arrange
      when(todoRepositoryImpl.removeTodo(newTestTodoModel.id as int))
          .thenAnswer(
        (_) => Future.value(false),
      );

      // act
      final result =
          await todoRepositoryImpl.removeTodo(newTestTodoModel.id as int);

      // assert
      verify(todoRepositoryImpl.removeTodo(newTestTodoModel.id as int))
          .called(1);
      expect(result, isA<bool>());
      expect(result, false);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });
  });

  group('toggleTodo()', () {
    test('should return true after roggling a todo in Local Storage by the id',
        () async {
      // arrange
      when(todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int))
          .thenAnswer((_) =>
              isarHelper.toggleTodoFromIsar(isar, newTestTodoModel.id as int));

      // act
      final result =
          await todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int);

      // assert
      verify(todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int))
          .called(1);
      expect(result, isA<bool>());
      expect(result, true);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });

    test(
        'should return false after failing to toggle a todo in LocalStorage by the id',
        () async {
      // arrange
      when(todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int))
          .thenAnswer(
        (_) => Future.value(false),
      );

      // act
      final result =
          await todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int);

      // assert
      verify(todoRepositoryImpl.toggleTodo(newTestTodoModel.id as int))
          .called(1);
      expect(result, isA<bool>());
      expect(result, false);
      expect(await isar.todos.count(), listOfTestTodoModles.length);
    });
  });
}
