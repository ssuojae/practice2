import 'dart:async';
import 'dart:convert';
import '../../domain/todo_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class ITodoRepository {
  Future<List<TodoEntity>> requestTodos();
  Future<void> saveTodos(List<TodoEntity> todos);
  Future<void> clearTodos(); 
  void dispose();
}

class TodoRepository implements ITodoRepository {
  final StreamController<List<TodoEntity>> _todoController = StreamController.broadcast();
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    _todoController.close();
  }

  @override
  Stream<List<TodoEntity>> get todos => _todoController.stream;

  Future<void> _initializeData() async {
    final todos = await requestTodos();
    _todoController.add(todos);
  }

  @override
  Future<List<TodoEntity>> requestTodos() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('todos')) {
      String? jsonString = prefs.getString('todos');
      List<dynamic> jsonList = json.decode(jsonString!);
      List<TodoEntity> todos = jsonList.map((json) => TodoEntity.fromJson(json as Map<String, dynamic>)).toList();
      return todos;
    }
    return [];
  }

  @override
  Future<void> saveTodos(List<TodoEntity> todos) async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = todos.map((todo) => todo.toJson()).toList();
    await prefs.setString('todos', json.encode(jsonList));
    _todoController.add(todos);
  }

  @override
  Future<void> clearTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('todos');
    _todoController.add([]);
  }

}