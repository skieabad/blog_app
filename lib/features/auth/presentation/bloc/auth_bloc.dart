import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_in_case.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;
  final UserSignInCase _userSignInCase;

  AuthBloc({
    required UserSignUpCase userSignUpCase,
    required UserSignInCase userSignInCase,
  })  : _userSignUpCase = userSignUpCase,
        _userSignInCase = userSignInCase,
        super(AuthInitial()) {
    on<AuthSignUpEvent>(_onAuthSignUpAsync);
    on<AuthSignInEvent>(_onAuthSignInAsync);
  }

  // Auth Sign Up
  void _onAuthSignUpAsync(
    AuthSignUpEvent authSignUpEvent,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await _userSignUpCase(UserSignUpCaseParams(
      authSignUpEvent.name,
      authSignUpEvent.email,
      authSignUpEvent.password,
    ));

    result.fold(
      (left) => emit(AuthFailedState(left.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }

  // Auth Sign In
  void _onAuthSignInAsync(
    AuthSignInEvent authSignInEvent,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    final result = await _userSignInCase(UserSignInCaseParams(
      authSignInEvent.email,
      authSignInEvent.password,
    ));

    result.fold(
      (left) => emit(AuthFailedState(left.message)),
      (user) => emit(AuthSuccessState(user)),
    );
  }
}
