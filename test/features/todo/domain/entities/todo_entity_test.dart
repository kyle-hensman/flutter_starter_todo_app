import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';

import '../../../../_helpers/containts.dart';

void main() {
  group('TodoEntity', () {
    test('should create a subclass of TodoEntity', () async {
      // act
      var todoEntity = const TodoEntity();

      // assert
      expect(todoEntity, isA<TodoEntity>());
    });

    test('should support comparing objects by value', () async {
      // act
      var todoEntity1 = const TodoEntity();
      var todoEntity2 = const TodoEntity();

      // assert
      expect(todoEntity1, isA<Equatable>());
      expect(todoEntity2, isA<TodoEntity>());
      expect(todoEntity1, todoEntity2);
    });

    test(
        'should create an valid empty TodoEntity when no values are passed into the constructor',
        () async {
      // act
      var todoEntity = const TodoEntity();

      // assert
      expect(todoEntity, isA<TodoEntity>());
      expect(todoEntity.id, isNot(0));
    });

    test(
        'should create a valid TodoEntity when constructed with all the values',
        () async {
      // act
      var todoEntity = const TodoEntity(
        id: 1,
        title: 'todo 1',
        complete: false,
      );

      // assert
      expect(todoEntity, testTodoEntity);
      expect(todoEntity, isA<TodoEntity>());
      expect(todoEntity.id, 1);
      expect(todoEntity.title, 'todo 1');
      expect(todoEntity.complete, false);
    });
  });
}
