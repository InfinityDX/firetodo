import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/helpers/galert.dart';
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
  final double defaultHeight = 48;
  bool isLoading = false;
  bool isExapnded = false;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return AnimatedContainer(
      curve: Curves.fastOutSlowIn,
      margin: const EdgeInsets.only(bottom: 8),
      duration: const Duration(milliseconds: 250),
      height: isExapnded ? defaultHeight * 2 : defaultHeight,
      decoration: BoxDecoration(
        color: GColor.scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: defaultHeight,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () => GBottomSheet.showEditSheet(widget.todo),
                      child: const Text('Edit'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: () => GAlert.showDeleteAlert(widget.todo),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isExapnded = !isExapnded;
              });
            },
            // onLongPress: () => GBottomSheet.showEditSheet(widget.todo),
            child: AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.only(left: 16),
              height: 48,
              onEnd: () {
                print('end expanding');
              },
              decoration: BoxDecoration(
                color: isCompleted
                    ? GColor.scheme.primary
                    : GColor.scheme.surfaceContainerHighest,
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
                    onChanged: (value) => toggleComplete(),
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
      ),
    );
  }

  void toggleComplete() async {
    HapticFeedback.lightImpact();

    setState(() => isLoading = true);

    isCompleted = !isCompleted;
    final updatedTodo = widget.todo.copyWith(isCompleted: isCompleted);
    await BlocProvider.of<TodoCubit>(context).updateTodo(updatedTodo);

    setState(() => isLoading = false);
  }
}
