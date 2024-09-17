import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetodo/data/models/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos();
  Future<Todo> addTodo(Todo todo);
  Future<Todo> updateTodo(Todo todo);
  Future<String> deleteTodo(Todo todo);
  Stream<List<Todo>> listenTodoColec();
}
