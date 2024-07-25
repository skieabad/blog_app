import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthStatusWidget extends StatelessWidget {
  final String statusContent;
  final String buttonText;
  final void Function()? onPressed;

  const AuthStatusWidget({
    super.key,
    required this.statusContent,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          statusContent,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 4.0),
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0.0),
          ),
          child: Text(
            buttonText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppPallete.gradient2, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
