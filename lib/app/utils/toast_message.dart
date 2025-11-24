import 'package:flutter/material.dart';

class AppToast {
  static void _show(
      BuildContext context,
      String message,
      Color bgColor,
      ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showError(BuildContext context, String message) {
    _show(context, message, Colors.redAccent);
  }

  static void showSuccess(BuildContext context, String message) {
    _show(context, message, Colors.green);
  }

  static void showInfo(BuildContext context, String message) {
    _show(context, message, Colors.blueAccent);
  }
}
