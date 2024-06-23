part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

// There 3 states for auth
// Loading, Success, Failed

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;
  const AuthSuccessState(this.user);
}

final class AuthFailedState extends AuthState {
  final String message;
  const AuthFailedState(this.message);
}
