import 'package:blog_app/core/utils/show_loader.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthFailedState) {
                    hideLoader(context);
                    return showSnackbar(context, state.message);
                  }

                  if (state is AuthSuccessState) {
                    hideLoader(context);
                    return showSnackbar(
                        context, 'User created successfully', Colors.green);
                  }

                  if (state is AuthLoadingState) {
                    return showLoader(context);
                  }
                },
                builder: (context, state) {
                  return Form(
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
                          focusNode: _nameFocusNode,
                          hintText: 'Name',
                        ),
                        const SizedBox(height: 18.0),
                        AuthFieldWidget(
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          hintText: 'Email',
                        ),
                        const SizedBox(height: 18.0),
                        AuthFieldWidget(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          hintText: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 24.0),
                        AuthGradientButtonWidget(
                          buttonText: 'Sign up',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              _nameFocusNode.unfocus();
                              _emailFocusNode.unfocus();
                              _passwordFocusNode.unfocus();

                              context.read<AuthBloc>().add(
                                    AuthSignUpEvent(
                                      _nameController.text.trim(),
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    ),
                                  );

                              _nameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                            }
                          },
                        ),
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
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
