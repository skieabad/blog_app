import 'package:blog_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/use_cases/current_user_case.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_in_case.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUpCase _userSignUpCase;
  final UserSignInCase _userSignInCase;
  final CurrentUserCase _currentUserCase;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUpCase userSignUpCase,
    required UserSignInCase userSignInCase,
    required CurrentUserCase currentUserCase,
    required AppUserCubit appUserCubit,
  })  : _userSignUpCase = userSignUpCase,
        _userSignInCase = userSignInCase,
        _currentUserCase = currentUserCase,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    // Handle all auth loading states in one place to avoid putting it on every event
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));

    on<AuthSignUpEvent>(_onAuthSignUpAsync);
    on<AuthSignInEvent>(_onAuthSignInAsync);
    on<AuthCurrentUserEvent>(_onAuthCurrentUserAsync);
  }

  void _onAuthCurrentUserAsync(
    AuthCurrentUserEvent authCurrentUserEvent,
    Emitter<AuthState> emit,
  ) async {
    final result = await _currentUserCase(NoParams());

    result.fold(
      (left) => emit(AuthFailedState(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  // Auth Sign Up
  void _onAuthSignUpAsync(
    AuthSignUpEvent authSignUpEvent,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userSignUpCase(UserSignUpCaseParams(
      authSignUpEvent.name,
      authSignUpEvent.email,
      authSignUpEvent.password,
    ));

    result.fold(
      (left) => emit(AuthFailedState(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  // Auth Sign In
  void _onAuthSignInAsync(
    AuthSignInEvent authSignInEvent,
    Emitter<AuthState> emit,
  ) async {
    final result = await _userSignInCase(UserSignInCaseParams(
      authSignInEvent.email,
      authSignInEvent.password,
    ));

    result.fold(
      (left) => emit(AuthFailedState(left.message)),
      (right) => _emitAuthSuccess(right, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user));
  }
}
