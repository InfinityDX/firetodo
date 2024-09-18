import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/components/search_todo_field.dart';
import 'package:firetodo/components/todo_component.dart';
import 'package:firetodo/components/add_todo_field.dart';
import 'package:firetodo/data/enums/cubit_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Todo List",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                final todo = state.editingTodo;
                return AddTodoField(todo: todo);
              },
            ),
            const SizedBox(height: 8),
            const SearchTodoField(),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  if (state.status == CubitStatus.gettingData &&
                      state.todos.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }
                  if (state.todosView.isEmpty) {
                    final isTodoAlsoEmpty = state.todos.isEmpty;
                    return Center(
                      child: Text(
                        isTodoAlsoEmpty
                            ? "No Todos"
                            : "No result. Create a new one instead",
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.todosView.length,
                    padding: const EdgeInsets.all(16),
                    // separatorBuilder: (context, index) {
                    //   return const SizedBox(height: 8);
                    // },
                    // findChildIndexCallback: (key) {
                    //   final valueKey = key as ValueKey;
                    //   final index = state.todosView
                    //       .indexWhere((todo) => todo.id == valueKey.value);
                    //   return index;
                    // },
                    itemBuilder: (context, index) {
                      final todo = state.todosView[index];
                      return TodoComponent(
                        key: ValueKey(todo.id),
                        todo: todo,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        // floatingActionButton: const FloatingActionButton(
        //   onPressed: GBottomSheet.showAddSheet,
        //   tooltip: 'Add Todo',
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}
