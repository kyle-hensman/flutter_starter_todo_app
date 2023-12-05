import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_state.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_bloc.dart';

import '../../../../../_helpers/containts.dart';
import '../../../../../_helpers/setup_isar.dart';
import '../../../../../_mocks/data_sources/local_todo_service.dart';
import '../../../../../_mocks/data_sources/local_todo_service.mocks.dart';
import '../../../../../_mocks/repositories/todo_respository.dart';
import '../../../../../_mocks/repositories/todo_respository.mocks.dart';
import '../../../../../_mocks/usecases/add_todo_usecase.dart';
import '../../../../../_mocks/usecases/add_todo_usecase.mocks.dart';
import '../../../../../_mocks/usecases/get_todos_usecase.dart';
import '../../../../../_mocks/usecases/get_todos_usecase.mocks.dart';
import '../../../../../_mocks/usecases/remove_todo_usecase.dart';
import '../../../../../_mocks/usecases/remove_todo_usecase.mocks.dart';
import '../../../../../_mocks/usecases/toggle_todo_usecase.dart';
import '../../../../../_mocks/usecases/toggle_todo_usecase.mocks.dart';

void main() {
  late Isar isar;
  late MockLocalTodoService mockLocalTodoService;
  late MockTodoRepository mockTodoRepository;
  late MockGetTodosUsecase mockGetTodosUsecase;
  late MockAddTodoUsecase mockAddTodosUsecase;
  late MockRemoveTodoUsecase mockRemoveTodosUsecase;
  late MockToggleTodoUsecase mockToggleTodosUsecase;
  late HomePageBloc homePageBloc;

  setUpAll(() async {
    isar = await setupIsar();
    mockLocalTodoService = FakeLocalTodoService(isar: isar);
    mockTodoRepository =
        FakeTodoRepository(localTodoService: mockLocalTodoService);
    mockGetTodosUsecase =
        FakeGetTodoUsecase(todoRepository: mockTodoRepository);
    mockAddTodosUsecase =
        FakeAddTodoUsecase(todoRepository: mockTodoRepository);
    mockRemoveTodosUsecase =
        FakeRemoveTodoUsecase(todoRepository: mockTodoRepository);
    mockToggleTodosUsecase =
        FakeToggleTodoUsecase(todoRepository: mockTodoRepository);
  });

  setUp(() async {
    homePageBloc = HomePageBloc(
      getTodosUsecase: mockGetTodosUsecase,
      addTodoUsecase: mockAddTodosUsecase,
      removeTodoUsecase: mockRemoveTodosUsecase,
      toggleTodoUsecase: mockToggleTodosUsecase,
    );
  });

  group('HomePageBloc', () {
    test('initial state should be empty', () async {
      // assert
      expect(homePageBloc.state, const HomePageStarted());
    });

    blocTest<HomePageBloc, HomePageState>(
      'should emit [HomePageLoading, HomePageLoaded] when data is successfully recieved',
      build: () {
        when(mockGetTodosUsecase.call())
            .thenAnswer((_) => Future.value([testTodoEntity]));
        return homePageBloc;
      },
      act: (bloc) => bloc.add(const GetTodos()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const HomePageLoading(),
        const HomePageLoaded(todos: [testTodoEntity]),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'should emit [HomePageLoading, HomePageLoaded] when data is successfully recieved if there are no todos on the device',
      build: () {
        when(mockGetTodosUsecase.call()).thenAnswer((_) => Future.value([]));
        return homePageBloc;
      },
      act: (bloc) => bloc.add(const GetTodos()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const HomePageLoading(),
        const HomePageLoaded(todos: []),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'should emit [HomePageLoading, HomePageLoaded] a todo is added and data is successfully recieved',
      build: () {
        when(mockAddTodosUsecase.call(todo: newTestTodoModel))
            .thenAnswer((_) => Future.value(true));
        when(mockGetTodosUsecase.call()).thenAnswer((_) => Future.value([
              testTodoEntity,
              newTestTodoModel,
            ]));
        return homePageBloc;
      },
      act: (bloc) => bloc.add(const AddTodo(newTestTodoModel)),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const HomePageLoading(),
        const HomePageLoaded(todos: [testTodoEntity, newTestTodoModel]),
      ],
    );

    blocTest<HomePageBloc, HomePageState>(
      'should emit [HomePageLoading, HomePageLoaded] a todo is removed and data is successfully recieved',
      build: () {
        when(mockRemoveTodosUsecase.call(id: newTestTodoModel.id))
            .thenAnswer((_) => Future.value(true));
        when(mockGetTodosUsecase.call()).thenAnswer((_) => Future.value([
              testTodoEntity,
            ]));
        return homePageBloc;
      },
      act: (bloc) => bloc.add(RemoveTodo(newTestTodoModel.id as int)),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        const HomePageLoading(),
        const HomePageLoaded(todos: [testTodoEntity]),
      ],
    );
  });
}
