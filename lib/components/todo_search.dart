import 'package:firetodo/data/configs/g_color.dart';
import 'package:flutter/material.dart';

class TodoSearch extends StatelessWidget {
  const TodoSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search',
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
    );
  }
}
