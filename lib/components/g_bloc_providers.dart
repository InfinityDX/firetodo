import 'package:firetodo/bloc/todo_cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GBlocProviders extends StatelessWidget {
  final Widget child;
  const GBlocProviders({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TodoCubit()..getTodos()),
      ],
      child: child,
    );
  }
}
