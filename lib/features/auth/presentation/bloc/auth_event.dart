part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSignUpEvent(
    this.name,
    this.email,
    this.password,
  );
}

final class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;

  AuthSignInEvent(
    this.email,
    this.password,
  );
}

final class AuthCurrentUserEvent extends AuthEvent {}
