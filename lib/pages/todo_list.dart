import 'package:firetodo/components/todo_component.dart';
import 'package:firetodo/components/todo_search.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/gbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        backgroundColor: GColor.scheme.primary,
        title: const Text(
          "Todo List",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        foregroundColor: GColor.scheme.onPrimary,
      ),
      body: Column(
        children: [
          const TodoSearch(),
          Expanded(
            child: ListView.separated(
              itemCount: 15,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 128),
              separatorBuilder: (context, index) {
                return const SizedBox(height: 8);
              },
              itemBuilder: (context, index) {
                return TodoComponent(
                  todo: Todo(title: '$index'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: GBottomSheet.showAddSheet,
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
