import 'package:flutter/material.dart';

class AuthFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;

  const AuthFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.focusNode,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: obscureText,
      focusNode: focusNode,
    );
  }
}
