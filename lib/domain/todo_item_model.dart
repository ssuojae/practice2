import 'package:uuid/uuid.dart';


final class TodoEntity {
  final String id;
  final TodoEntityState state;
  final String title;
  final String description;
  final bool done;

  TodoEntity({
    required this.state,
    required this.title,
    required this.description,
    this.done = false,
  }) : id = const Uuid().v4(); // 고유한 id를 생성

  TodoEntity.withId({
    required this.id,
    required this.state,
    required this.title,
    required this.description,
    this.done = false,
  });

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity.withId(
      id: json['id'],
      state: TodoEntityState.values[json['state']],
      title: json['title'],
      description: json['description'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'state': state.index,
      'title': title,
      'description': description,
      'done': done,
    };
  } 
}

enum TodoEntityState { empty, inProgress, complete }