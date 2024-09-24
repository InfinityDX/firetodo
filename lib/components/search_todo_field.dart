
import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTodoField extends StatelessWidget {
  const SearchTodoField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (p, c) => p.todos != c.todos,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            onChanged: (title) {
              BlocProvider.of<TodoCubit>(context).filterTodo(title);
            },
            decoration: InputDecoration(
              hintText: 'Filter',
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
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          ),
        );
      },
    );
  }
}
