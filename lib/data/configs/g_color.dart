import 'package:firetodo/pages/app.dart';
import 'package:flutter/material.dart';

class GColor {
  const GColor._();
  static ColorScheme get scheme =>
      Theme.of(materialAppKey.currentContext!).colorScheme;

  static const Color _seedColor = Color(0xFFFF4000);

  // Theme Data to put into Material App
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          dynamicSchemeVariant: DynamicSchemeVariant.content,
        ),
        inputDecorationTheme: inputDecorationTheme,
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seedColor,
          brightness: Brightness.dark,
        ),
        inputDecorationTheme: inputDecorationTheme,
      );
  static const inputDecorationTheme = InputDecorationTheme(
    isCollapsed: true,
    isDense: true,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
