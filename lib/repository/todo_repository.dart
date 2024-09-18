import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetodo/data/models/base_response.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/repository/interfaces/i_todo_repository.dart';

class TodoRepository implements ITodoRepository {
  CollectionReference<Todo> todoCollection =
      FirebaseFirestore.instance.collection('todos').withConverter<Todo>(
    fromFirestore: (snapshot, options) {
      return Todo.fromSnapshot(snapshot);
    },
    toFirestore: (todo, options) {
      return {
        ...todo.toMap(),
        'timestamp': todo.timestamp == null
            ? FieldValue.serverTimestamp()
            : Timestamp.fromMillisecondsSinceEpoch(todo.timestamp!),
      };
    },
  );

  @override
  Future<BaseResponse<Todo>> addTodo(Todo todo) async {
    final existingTodo =
        await todoCollection.where('title', isEqualTo: todo.title).get();

    if (existingTodo.docs.isEmpty) {
      final docRef = await todoCollection.add(todo);
      return BaseResponse(
        data: todo.copyWith(id: docRef.id),
        isSuccess: true,
      );
    }
    return BaseResponse(msg: "Todo title already exists");
  }

  @override
  Future<String> deleteTodo(Todo todo) async {
    String status = 'Success';
    await todoCollection.doc(todo.id).delete().catchError((_) {
      status = "Failed to delete todo";
    });
    return status;
  }

  @override
  Future<List<Todo>> getTodos() async {
    final todos =
        await todoCollection.orderBy('timestamp', descending: true).get();
    return todos.docs.map((e) => e.data()).toList();
  }

  @override
  Future<BaseResponse<Todo>> updateTodo(Todo todo) async {
    final exisitngTodo =
        await todoCollection.where('title', isEqualTo: todo.title).get();
    if (exisitngTodo.docs.isEmpty) {
      await todoCollection.doc(todo.id).set(todo);
      return BaseResponse(data: todo.copyWith(), isSuccess: true);
    }
    return BaseResponse(msg: 'Todo title already exists');
  }

  @override
  Stream<List<Todo>> getStream() {
    return todoCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .asyncMap(
      (event) async {
        return event.docs.map((doc) => doc.data()).toList();
      },
    );
  }
}
