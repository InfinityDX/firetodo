import 'package:firetodo/data/models/base_response.dart';
import 'package:firetodo/data/models/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos();
  Future<BaseResponse<Todo>> addTodo(Todo todo);
  Future<BaseResponse<Todo>> updateTodo(Todo todo);
  Future<String> deleteTodo(Todo todo);
  Stream<List<Todo>> getStream();
}
