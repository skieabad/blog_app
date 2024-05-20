import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/features/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_status_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold,
                      color: AppPallete.whiteColor,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                AuthFieldWidget(
                  controller: _nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 18.0),
                AuthFieldWidget(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 18.0),
                AuthFieldWidget(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 24.0),
                const AuthGradientButtonWidget(buttonText: 'Sign up'),
                const SizedBox(height: 12.0),
                AuthStatusWidget(
                  statusContent: 'Already have an account?',
                  buttonText: 'Sign In',
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const SignInPage(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
