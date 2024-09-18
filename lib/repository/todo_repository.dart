import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<Todo> addTodo(Todo todo) async {
    final docRef = await todoCollection.add(todo);
    return todo.copyWith(id: docRef.id);
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
  Future<Todo> updateTodo(Todo todo) async {
    await todoCollection.doc(todo.id).set(todo);
    return todo.copyWith();
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
