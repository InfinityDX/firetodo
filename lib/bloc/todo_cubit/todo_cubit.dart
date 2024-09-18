import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firetodo/data/enums/cubit_enums.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/repository/interfaces/i_todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  ITodoRepository repositroy;
  TodoCubit(this.repositroy) : super(const TodoState());

  StreamSubscription<List<Todo>>? todoCollectionSub;

  Future<void> getTodos() async {
    emit(state.copyWith(status: CubitStatus.gettingData));
    final todos = await repositroy.getTodos();
    emit(state.copyWith(
      status: CubitStatus.initial,
      todos: todos,
    ));
    if (todoCollectionSub == null) {
      final todoStream = repositroy.getStream();
      todoCollectionSub = todoStream.listen(_todoCollectListener);
    }
  }

  void _todoCollectListener(List<Todo> snapshots) {
    emit(state.copyWith(todos: snapshots));
  }

  Future<void> refreshTodo() async {
    final todos = await repositroy.getTodos();
    emit(state.copyWith(todos: todos));
  }

  Future<void> addTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
    await repositroy.addTodo(todo);
    emit(state.copyWith(status: CubitStatus.initial));
  }

  Future<void> updateTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
    await repositroy.updateTodo(todo);
    emit(state.copyWith(status: CubitStatus.initial));
  }

  Future<void> deleteTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
    await repositroy.deleteTodo(todo);
    emit(state.copyWith(status: CubitStatus.initial));
  }
}
