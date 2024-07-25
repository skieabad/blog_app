import 'package:blog_app/core/utils/show_loader.dart';
import 'package:blog_app/core/theme/app_palette.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/sign_up_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_field_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_gradient_button_widget.dart';
import 'package:blog_app/features/auth/presentation/widgets/auth_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                return showLoader(context);
              }

              if (state is AuthFailedState) {
                hideLoader(context);
                return showSnackbar(context, state.message);
              }

              if (state is AuthSuccessState) {
                hideLoader(context);
                return showSnackbar(
                    context, "User sign in successfully", Colors.green);
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
                        'Sign In',
                        style: TextStyle(
                          fontSize: 42.0,
                          fontWeight: FontWeight.bold,
                          color: AppPallete.whiteColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    AuthFieldWidget(
                      controller: _emailController,
                      hintText: 'Email',
                      focusNode: _emailFocusNode,
                    ),
                    const SizedBox(height: 18.0),
                    AuthFieldWidget(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                      focusNode: _passwordFocusNode,
                    ),
                    const SizedBox(height: 24.0),
                    AuthGradientButtonWidget(
                      buttonText: 'Sign in',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _emailFocusNode.unfocus();
                          _passwordFocusNode.unfocus();

                          context.read<AuthBloc>().add(
                                AuthSignInEvent(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                ),
                              );

                          _passwordController.clear();
                        }
                      },
                    ),
                    const SizedBox(height: 12.0),
                    AuthStatusWidget(
                      statusContent: 'Don\'t have an account?',
                      buttonText: 'Sign Up',
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const SignUpPage(),
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
    );
  }
}
