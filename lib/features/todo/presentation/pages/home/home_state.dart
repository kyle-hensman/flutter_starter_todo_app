import 'package:equatable/equatable.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class HomePageStarted extends HomePageState {
  const HomePageStarted();
}

class HomePageLoading extends HomePageState {
  const HomePageLoading();
}

class HomePageFailure extends HomePageState {
  final String? error;

  const HomePageFailure({
    this.error,
  });

  @override
  List<Object?> get props => [
        error!,
      ];
}

class HomePageLoaded extends HomePageState {
  final List<TodoEntity> todos;

  const HomePageLoaded({
    required this.todos,
  });

  @override
  List<Object?> get props => [
        todos,
      ];
}
