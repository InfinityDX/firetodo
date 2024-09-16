import 'package:firetodo/data/models/todo.dart';
import 'package:firetodo/pages/add_todo_sheet.dart';
import 'package:firetodo/pages/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GBottomSheet {
  const GBottomSheet._();

  static void showEditSheet(Todo todo) async {
    HapticFeedback.lightImpact();
    await showModalBottomSheet(
      context: materialAppKey.currentContext!,
      isScrollControlled: true,
      builder: (context) {
        return AddTodoSheet(todo: todo);
      },
    );
  }

  static void showAddSheet() async {
    HapticFeedback.mediumImpact();
    await showModalBottomSheet(
      context: materialAppKey.currentContext!,
      isScrollControlled: true,
      builder: (context) {
        return AddTodoSheet();
      },
    );
  }
}
