import 'package:firetodo/pages/app.dart';
import 'package:flutter/material.dart';

class GAlert {
  const GAlert._();

  static void showAlert(String msg) {
    showDialog(
      context: materialAppKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
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
}
