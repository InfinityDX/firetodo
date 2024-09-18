part of 'todo_cubit.dart';

class TodoState extends Equatable {
  final CubitStatus status;
  final List<Todo> todos;
  final List<Todo> todosView;
  final Todo? editingTodo;
  const TodoState({
    this.status = CubitStatus.initial,
    this.todos = const [],
    this.todosView = const [],
    this.editingTodo,
  });

  TodoState copyWith({
    CubitStatus? status,
    List<Todo>? todos,
    List<Todo>? todosView,
    Todo? editingTodo,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      todosView: todosView ?? this.todosView,
      editingTodo: editingTodo,
    );
  }

  @override
  List<Object> get props => [
        status,
        todos,
        todosView,
        editingTodo ?? Todo,
      ];
}
