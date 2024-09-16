import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/gbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TodoComponent extends StatefulWidget {
  final Todo todo;
  const TodoComponent({required this.todo, super.key});

  @override
  State<TodoComponent> createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  late bool isCompleted = widget.todo.isCompleted;
  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return GestureDetector(
      onTap: () => toggleComplete(null),
      onLongPress: () => GBottomSheet.showEditSheet(widget.todo),
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
          color: isCompleted
              ? GColor.scheme.primary
              : GColor.scheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.todo.title ?? '--',
                style: TextStyle(
                  color: isCompleted
                      ? GColor.scheme.onPrimary
                      : GColor.scheme.onSurface,
                ),
              ),
            ),
            Checkbox(
              value: isCompleted,
              onChanged: toggleComplete,
            )
          ],
        ),
      ),
    );
  }

  void toggleComplete(bool? value) {
    HapticFeedback.lightImpact();
    setState(() => isCompleted = !isCompleted);
  }
}
