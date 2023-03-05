import 'package:flutter/material.dart';

import '../main.dart';

void showSnackBar({
  required BuildContext context,
  required String message,
}) {
  scaffoldMessenger.currentState?.hideCurrentSnackBar();
  scaffoldMessenger.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ),
  );
}
