import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firetodo/data/enums/cubit_enums.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());

  Future<void> getTodos() async {
    emit(state.copyWith(status: CubitStatus.gettingData));
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: CubitStatus.inital));
  }

  Future<void> refreshTodo() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> addTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
  }

  Future<void> updateTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(status: CubitStatus.updating));
  }

  Future<void> deleteTodo(Todo todo) async {
    emit(state.copyWith(status: CubitStatus.updating));
  }
}
