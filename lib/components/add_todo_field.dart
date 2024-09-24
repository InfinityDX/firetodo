import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/galert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoField extends StatefulWidget {
  const AddTodoField({super.key});

  @override
  State<AddTodoField> createState() => _AddTodoFieldState();
}

class _AddTodoFieldState extends State<AddTodoField> {
  late final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: BlocConsumer<TodoCubit, TodoState>(
        listenWhen: (p, c) => p.editingTodo != c.editingTodo,
        listener: (context, state) {
          textEditingController.text = state.editingTodo?.title ?? '';
        },
        builder: (context, state) {
          final todo = state.editingTodo;
          return Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: textEditingController,
                onChanged: (title) {
                  BlocProvider.of<TodoCubit>(context).filterTodo(title);
                  textEditingController.text = title;
                },
                onFieldSubmitted: (title) async {
                  if (title.isEmpty) {
                    GAlert.showAlert("Title cannot be empty");
                    return;
                  }
                  var success = false;
                  if (todo == null) {
                    final newTodo = Todo(title: title);
                    success = await BlocProvider.of<TodoCubit>(context)
                        .addTodo(newTodo);
                  } else {
                    final updatedTodo = todo.copyWith(title: title);
                    success = await BlocProvider.of<TodoCubit>(context)
                        .updateTodo(updatedTodo);
                  }

                  if (success) textEditingController.clear();
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
              )),
              if (todo != null) const SizedBox(width: 8),
              if (todo != null)
                IconButton.filled(
                  onPressed: () {
                    BlocProvider.of<TodoCubit>(context).selectTodoForUpdate();
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  icon: const Icon(Icons.close),
                ),
            ],
          );
        },
      ),
    );
  }
}
