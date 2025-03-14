import 'package:flutter/material.dart';

class BlogFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;

  const BlogFieldWidget({
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
      // if maxLines is null, the text will wrap to a new line when it reaches the end
      maxLines: null,
    );
  }
}
