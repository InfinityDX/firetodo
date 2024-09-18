import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/gnavigation.dart';
import 'package:firetodo/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GAlert {
  const GAlert._();

  static void showAlert(String msg) {
    showDialog(
      context: materialAppKey.currentContext!,
      builder: (context) {
        Theme.of(context);
        return AlertDialog(
          title: Text(msg),
          backgroundColor: GColor.scheme.surface,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Ok'),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void showDeleteAlert(Todo todo) {
    bool isLoading = false;
    showDialog(
      context: materialAppKey.currentContext!,
      builder: (context) {
        Theme.of(context);
        return AlertDialog(
          title: const Text("Delete Todo?"),
          content: Text("Are you sure you want to delete todo ${todo.title}"),
          backgroundColor: GColor.scheme.surface,
          actions: [
            StatefulBuilder(
              builder: (context, setState) {
                Theme.of(context);
                return FilledButton(
                  onPressed: () async {
                    setState(() => isLoading = true);
                    await BlocProvider.of<TodoCubit>(context).deleteTodo(todo);
                    setState(() => isLoading = false);
                    GNavigation.pop();
                  },
                  child: isLoading
                      ? SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            color: GColor.scheme.onPrimary,
                            strokeWidth: 2,
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      : const Text('Ok'),
                );
              },
            ),
            const FilledButton.tonal(
              onPressed: GNavigation.pop,
              child: Text('Cancel'),
            )
          ],
        );
      },
    );
  }
}
