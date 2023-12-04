import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int? id;
  final String? title;
  final bool complete;

  const TodoEntity({
    this.id,
    this.title,
    this.complete = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        complete,
      ];
}
