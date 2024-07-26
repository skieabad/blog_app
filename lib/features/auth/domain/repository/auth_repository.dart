import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  // Either is a package that provides a functional programming style to work with Dart types.
  // Either is also a type that represents one of two possible return types: (Failure or Success)
  // Supabase is asynchronous, so we use Future to handle the asynchronous operation.
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failure, User>> getCurrentUser();
}
