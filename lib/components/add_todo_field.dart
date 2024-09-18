import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/galert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoField extends StatelessWidget {
  final Todo? todo;
  const AddTodoField({this.todo, super.key});

  @override
  Widget build(BuildContext context) {
    final textEditingController = TextEditingController(text: todo?.title);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: textEditingController,
              onFieldSubmitted: (title) {
                if (title.isEmpty) {
                  GAlert.showAlert("Title cannot be empty");
                  return;
                }
                if (todo == null) {
                  final newTodo = Todo(title: title);
                  BlocProvider.of<TodoCubit>(context).addTodo(newTodo);
                } else {
                  final updatedTodo = todo!.copyWith(title: title);
                  BlocProvider.of<TodoCubit>(context).updateTodo(updatedTodo);
                }

                textEditingController.clear();
              },
              decoration: InputDecoration(
                hintText: 'Add Todos...',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0.5,
                    color: GColor.scheme.outline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 1,
                    color: GColor.scheme.outline,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (todo != null)
            IconButton.filled(
              onPressed: () {
                BlocProvider.of<TodoCubit>(context).selectTodoForUpdate();
                FocusManager.instance.primaryFocus?.unfocus();
              },
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}
