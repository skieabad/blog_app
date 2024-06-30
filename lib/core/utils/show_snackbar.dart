import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context,
  String content, [
  Color backgroundColor = Colors.red,
]) {
  if (content.isEmpty) {
    return;
  }

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(
          milliseconds: 1500,
        ),
        backgroundColor: backgroundColor,
        content: Text(
          content,
          style: const TextStyle(color: AppPallete.whiteColor),
        ),
      ),
    );
}
