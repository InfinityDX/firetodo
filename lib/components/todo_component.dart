import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/gbottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoComponent extends StatefulWidget {
  final Todo todo;
  const TodoComponent({required this.todo, super.key});

  @override
  State<TodoComponent> createState() => _TodoComponentState();
}

class _TodoComponentState extends State<TodoComponent> {
  late bool isCompleted = widget.todo.isCompleted;
  bool isLoading = false;
  @override
  void didUpdateWidget(covariant TodoComponent oldWidget) {
    isCompleted = widget.todo.isCompleted;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () => toggleComplete(null),
          onLongPress: () => GBottomSheet.showEditSheet(widget.todo),
          child: AnimatedContainer(
            curve: Curves.fastOutSlowIn,
            duration: const Duration(milliseconds: 250),
            padding: const EdgeInsets.only(left: 16),
            height: 48,
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
                    maxLines: 1,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
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
        ),
        IgnorePointer(
          ignoring: !isLoading,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isLoading ? Colors.white38 : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeCap: StrokeCap.round,
                      strokeWidth: 3,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  void toggleComplete(bool? value) async {
    HapticFeedback.lightImpact();

    setState(() => isLoading = true);

    isCompleted = !isCompleted;
    final updatedTodo = widget.todo.copyWith(isCompleted: isCompleted);
    await BlocProvider.of<TodoCubit>(context).updateTodo(updatedTodo);

    setState(() => isLoading = false);
  }
}
