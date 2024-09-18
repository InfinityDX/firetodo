import 'package:firetodo/components/g_bloc_providers.dart';
import 'package:firetodo/data/configs/g_color.dart';
import 'package:firetodo/pages/todo_list.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> materialAppKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GBlocProviders(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: GColor.light,
        darkTheme: GColor.dark,
        themeMode: ThemeMode.light,
        navigatorKey: materialAppKey,
        home: const TodoList(),
      ),
    );
  }
}
