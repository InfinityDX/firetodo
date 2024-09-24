import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firetodo/data/enums/cubit_enums.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/galert.dart';
import 'package:firetodo/repository/interfaces/i_todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  ITodoRepository repositroy;
  TodoCubit(this.repositroy) : super(const TodoState());

  String searchedTitle = '';

  StreamSubscription<List<Todo>>? todoCollectionSub;

  Future<void> getTodos() async {
    emit(state.copyWith(status: CubitStatus.gettingData));
    final todos = await repositroy.getTodos();
    emit(state.copyWith(
      status: CubitStatus.initial,
      todos: todos,
      todosView: todos.toList(),
    ));
    if (todoCollectionSub == null) {
      final todoStream = repositroy.getStream();
      todoCollectionSub = todoStream.listen(_todoCollectListener);
    }
  }

  void filterTodo(String title) {
    searchedTitle = title;
    List<Todo> todoView;
    if (searchedTitle.isEmpty) {
      todoView = state.todos.toList();
    } else {
      todoView = state.todos
          .where((todo) => todo.title?.contains(searchedTitle) ?? false)
          .toList();
    }

    emit(state.copyWith(
      todosView: todoView,
      editingTodo: state.editingTodo,
    ));
  }

  void _todoCollectListener(List<Todo> snapshots) {
    List<Todo> todoView;
    if (searchedTitle.isEmpty) {
      todoView = snapshots.toList();
    } else {
      todoView = snapshots
          .where((todo) => todo.title?.contains(searchedTitle) ?? false)
          .toList();
    }

    emit(state.copyWith(
      todos: snapshots,
      todosView: todoView,
      editingTodo: state.editingTodo,
    ));
  }

  // Future<void> refreshTodo() async {
  //   final todos = await repositroy.getTodos();
  //   emit(state.copyWith(
  //     todos: todos,
  //     todosView: todos.toList(),
  //   ));
  // }

  Future<bool> addTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
    final response = await repositroy.addTodo(todo);
    if (!response.isSuccess) {
      GAlert.showAlert(response.msg);
      return false;
    }
    filterTodo("");
    emit(state.copyWith(status: CubitStatus.initial));
    return true;
  }

  Future<void> selectTodoForUpdate([Todo? todo]) async {
    if (todo == null) filterTodo('');
    if (todo?.isCompleted ?? false) {
      GAlert.showAlert('Cannot Edit Completed Todo');
      return;
    }
    emit(state.copyWith(editingTodo: todo));
    filterTodo(todo?.title ?? '');
  }

  Future<bool> updateTodo(Todo todo) async {
    emit(state.copyWith(
      status: CubitStatus.updating,
      editingTodo: state.editingTodo,
    ));
    final response = await repositroy.updateTodo(todo);
    if (!response.isSuccess) {
      GAlert.showAlert(response.msg);
      return false;
    }
    filterTodo("");
    emit(state.copyWith(status: CubitStatus.initial));
    return true;
  }

  Future<void> markTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
    final response = await repositroy.markTodo(todo);
    if (!response.isSuccess) GAlert.showAlert(response.msg);
    emit(state.copyWith(status: CubitStatus.initial));
  }

  Future<void> deleteTodo(Todo todo) async {
    emit(state.copyWith(
      status: CubitStatus.updating,
      editingTodo: state.editingTodo,
    ));
    await repositroy.deleteTodo(todo);
    // filterTodo('');
  }
}
