import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/galert.dart';
import 'package:flutter/material.dart';

class AddTodoSheet extends StatefulWidget {
  final Todo? todo;
  const AddTodoSheet({this.todo, super.key});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  late String title = widget.todo?.title ?? '';
  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: InputDecorationTheme(
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
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.todo == null ? 'Add Todo' : 'Edit Todo',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.todo?.title ?? '',
                decoration: const InputDecoration(hintText: "Title"),
                onChanged: (title) => this.title = title,
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: widget.todo == null ? onAdd : onEdit,
                child: Text(widget.todo == null ? "Add" : "Edit"),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAdd() {
    if (title.isEmpty) {
      GAlert.showAlert("Title cannot be empty");
      return;
    }
  }

  void onEdit() {
    if (title.isEmpty) {
      GAlert.showAlert("Title cannot be empty");
      return;
    }
  }
}
