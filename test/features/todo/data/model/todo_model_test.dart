import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/data/model/todo_model.dart';

import '../../../../_helpers/containts.dart';

void main() {
  group('TodoModel', () {
    test('should be a subclass of TodoModel', () async {
      // assert
      expect(testTodoModel, isA<TodoModel>());
    });

    group('fromEntity()', () {
      test('should return a valid TodoModel from a TodoEntity', () async {
        // act
        final result = TodoModel.fromEntity(testTodoEntity);

        // assert
        expect(result, isA<TodoModel>());
        expect(result, testTodoModel);
        expect(result.id, testTodoModel.id);
        expect(result.title, testTodoModel.title);
        expect(result.complete, testTodoModel.complete);
        expect(result.toString(),
            'TodoModel(${testTodoModel.id}, ${testTodoModel.title}, ${testTodoModel.complete})');
      });
    });

    group('toEntity()', () {
      test('should return a valid TodoEntity from a TodoModel', () async {
        // act
        var result = testTodoModel.toEntity();

        // assert
        expect(result, isA<TodoEntity>());
        expect(result, testTodoEntity);
        expect(result.id, testTodoEntity.id);
        expect(result.title, testTodoEntity.title);
        expect(result.complete, testTodoEntity.complete);
        expect(result.toString(),
            'TodoEntity(${testTodoEntity.id}, ${testTodoEntity.title}, ${testTodoEntity.complete})');
      });
    });
  });
}
