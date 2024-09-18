part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final CubitStatus status;
  final List<Todo> todos;
  final Todo? editingTodo;
  const TodoState({
    this.status = CubitStatus.initial,
    this.todos = const [],
    this.editingTodo,
  });

  TodoState copyWith({
    CubitStatus? status,
    List<Todo>? todos,
    Todo? editingTodo,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      editingTodo: editingTodo,
    );
  }

  @override
  List<Object> get props => [status, todos, editingTodo ?? Todo];
}
