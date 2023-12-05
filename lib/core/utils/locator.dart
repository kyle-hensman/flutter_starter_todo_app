import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';
import 'package:flutter_starter_todo_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/repositories/todo_repository.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/toggle_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/data/data_sources/local/local_todo_service.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [TodoModelSchema],
    directory: dir.path,
  );

  // Isar local database
  locator.registerSingleton<Isar>(isar);

  // Services
  locator.registerSingleton<LocalTodoService>(LocalTodoServiceImpl(isar: isar));

  // Repositories
  locator.registerSingleton<TodoRepository>(
      TodoRepositoryImpl(localTodoService: locator.get<LocalTodoService>()));

  // Usecases
  locator.registerSingleton<GetTodosUsecase>(GetTodosUsecase(
    todoRepository: locator<TodoRepository>(),
  ));
  locator.registerSingleton<AddTodoUsecase>(AddTodoUsecase(
    todoRepository: locator<TodoRepository>(),
  ));
  locator.registerSingleton<RemoveTodoUsecase>(RemoveTodoUsecase(
    todoRepository: locator<TodoRepository>(),
  ));
  locator.registerSingleton<ToggleTodoUsecase>(ToggleTodoUsecase(
    todoRepository: locator<TodoRepository>(),
  ));

  // Blocs
  // locator.registerFactory<HomePageBloc>(
  //   () => HomePageBloc(
  //     getTodosUsecase: locator<GetTodosUsecase>(),
  //     addTodoUsecase: locator<AddTodoUsecase>(),
  //     removeTodoUsecase: locator<RemoveTodoUsecase>(),
  //     toggleTodoUsecase: locator<toggleTodoUsecase>(),
  //   ),
  // );
}
