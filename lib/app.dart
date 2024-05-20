import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:flutter/material.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      // central theme configuration
      theme: AppTheme.darkThemeMode,
      home: const SignInPage(),
    );
  }
}
