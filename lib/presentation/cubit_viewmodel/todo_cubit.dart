import 'package:bloc/bloc.dart';
import '../../domain/todo_item_model.dart';
import '../../data/repositories/todo_repository.dart';

abstract class ITodoCubit {
  void fetchTodos();
  Future<void> close();
  void toggleCheckboxState(int index);
  Future<void> saveTodo(TodoEntity todo);
  void markAsDonTrue(int index);
  void deleteTodoEntity(TodoEntity todo);
  void markAsDoneFalse(int index);
  void toggleDoneStatus(TodoEntity item);
}

final class TodoCubit extends Cubit<List<TodoEntity>> implements ITodoCubit {
  final ITodoRepository _repository;

  TodoCubit(this._repository) : super([]) {
    fetchTodos();
  }

  @override
  void fetchTodos() async {
    final todos = await _repository.requestTodos();
    emit(todos);
  }

  @override
  Future<void> close() async => await super.close();
  

  @override
  void toggleCheckboxState(int index) {
    final updatedItems = List<TodoEntity>.from(state);
    final item = updatedItems[index];
    final newState = TodoEntityState.values[(item.state.index + 1) % TodoEntityState.values.length];
    updatedItems[index] = TodoEntity.withId(
      id: item.id,
      state: newState,
      title: item.title,
      description: item.description,
      done: item.done, 
    );
    emit(updatedItems);
    _repository.saveTodos(updatedItems); 
  }

  @override
  Future<void> saveTodo(TodoEntity todo) async {
    final updatedItems = List<TodoEntity>.from(state)..add(todo);
    await _repository.saveTodos(updatedItems);
    emit(updatedItems);
  }

  @override
  void markAsDonTrue(int index) {
    final updatedItems = List<TodoEntity>.from(state);
    final item = updatedItems[index];
    updatedItems[index] = TodoEntity.withId(
      id: item.id,
      state: item.state,
      title: item.title,
      description: item.description,
      done: true,
    );
    emit(updatedItems);
    _repository.saveTodos(updatedItems); 
  }

    @override
  void markAsDoneFalse(int index) {
    final updatedItems = List<TodoEntity>.from(state);
    final item = updatedItems[index];
    updatedItems[index] = TodoEntity.withId(
      id: item.id,
      state: item.state,
      title: item.title,
      description: item.description,
      done: false,
    );
    emit(updatedItems);
    _repository.saveTodos(updatedItems); 
  }


  @override
  void deleteTodoEntity(TodoEntity todo) {
    final updatedItems = List<TodoEntity>.from(state)..remove(todo);
    emit(updatedItems);
    _repository.saveTodos(updatedItems); 
  }

  @override
  void toggleDoneStatus(TodoEntity item) {
    final updatedItems = state.map((todo) {
      if (todo.id == item.id) {
        return TodoEntity.withId(
          id: todo.id,
          state: todo.state,
          title: todo.title,
          description: todo.description,
          done: false,
        );
      }
      return todo;
    }).toList();
    emit(updatedItems);
    _repository.saveTodos(updatedItems);
  }
}
