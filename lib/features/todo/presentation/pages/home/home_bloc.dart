import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_starter_todo_app/core/utils/locator.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/get_todos_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/domain/usecases/toggle_todo_usecase.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GetTodosUsecase _getTodosUsecase;
  final AddTodoUsecase _addTodoUsecase;
  final RemoveTodoUsecase _removeTodoUsecase;
  final ToggleTodoUsecase _toggleTodoUsecase;

  HomePageBloc({
    GetTodosUsecase? getTodosUsecase,
    AddTodoUsecase? addTodoUsecase,
    RemoveTodoUsecase? removeTodoUsecase,
    ToggleTodoUsecase? toggleTodoUsecase,
  })  : _getTodosUsecase = getTodosUsecase ?? locator.get<GetTodosUsecase>(),
        _addTodoUsecase = addTodoUsecase ?? locator.get<AddTodoUsecase>(),
        _removeTodoUsecase =
            removeTodoUsecase ?? locator.get<RemoveTodoUsecase>(),
        _toggleTodoUsecase =
            toggleTodoUsecase ?? locator.get<ToggleTodoUsecase>(),
        super(const HomePageStarted()) {
    on<GetTodos>((event, emit) async {
      emit(const HomePageLoading());
      try {
        final todos = await _getTodosUsecase();
        print('TODOS: ${todos.toString()}');
        emit(HomePageLoaded(todos: todos));
      } catch (e) {
        var errorMessage = e.toString();
        print('HomePageBloc Error - GetTodos - $errorMessage');
        emit(HomePageFailure(error: errorMessage));
      }
    });
    on<AddTodo>((event, emit) async {
      emit(const HomePageLoading());
      try {
        final sucess = await _addTodoUsecase(todo: event.todo);
        if (sucess) {
          final todos = await _getTodosUsecase();
          emit(HomePageLoaded(todos: todos));
        } else {
          emit(const HomePageFailure());
        }
      } catch (e) {
        var errorMessage = e.toString();
        print('HomePageBloc Error - AddTodos - $errorMessage');
        emit(HomePageFailure(error: errorMessage));
      }
    });
    on<RemoveTodo>((event, emit) async {
      emit(const HomePageLoading());
      try {
        final sucess = await _removeTodoUsecase(id: event.id);
        if (sucess) {
          final todos = await _getTodosUsecase();
          emit(HomePageLoaded(todos: todos));
        } else {
          emit(const HomePageFailure());
        }
      } catch (e) {
        var errorMessage = e.toString();
        print('HomePageBloc Error - RemoveTodos - $errorMessage');
        emit(HomePageFailure(error: errorMessage));
      }
    });
    on<ToggleTodo>((event, emit) async {
      emit(const HomePageLoading());
      try {
        final success = await _toggleTodoUsecase(id: event.id);
        if (success) {
          final todos = await _getTodosUsecase();
          emit(HomePageLoaded(todos: todos));
        } else {
          emit(const HomePageFailure());
        }
      } catch (e) {
        var errorMessage = e.toString();
        print('HomePageBloc Error - ToggleTodos - $errorMessage');
        emit(HomePageFailure(error: errorMessage));
      }
    });
  }
}
