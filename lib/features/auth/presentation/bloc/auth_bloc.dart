import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;

  AuthBloc({required UserSignUpCase userSignUpCase})
      : _userSignUpCase = userSignUpCase,
        super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _userSignUpCase(UserSignUpCaseParams(
        event.name,
        event.email,
        event.password,
      ));

      result.fold(
        (left) => emit(AuthFailedState(left.message)),
        (user) => emit(AuthSuccessState(user)),
      );
    });
  }
}
