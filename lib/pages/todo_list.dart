import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo List",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: BlocProvider.of<TodoCubit>(context).refreshTodo,
        child: Column(
          children: [
            BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                final todo = state.editingTodo;
                return AddTodoField(todo: todo);
              },
            ),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) {
                  final todos = state.todos;
                  if (state.status == CubitStatus.gettingData &&
                      todos.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeCap: StrokeCap.round,
                      ),
                    );
                  }
                  if (todos.isEmpty) {
                    return const CustomScrollView(
                      slivers: [
                        SliverFillRemaining(
                          child: Center(
                            child: Text(
                              "No Todos",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    itemCount: state.todos.length,
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
                    // separatorBuilder: (context, index) {
                    //   return const SizedBox(height: 8);
                    // },
                    findChildIndexCallback: (key) {
                      final valueKey = key as ValueKey;
                      final index =
                          todos.indexWhere((todo) => todo.id == valueKey.value);
                      return index;
                    },
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
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
      ),
      // floatingActionButton: const FloatingActionButton(
      //   onPressed: GBottomSheet.showAddSheet,
      //   tooltip: 'Add Todo',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
