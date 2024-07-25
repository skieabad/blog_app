import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

// Implementation for AuthRepository from Domain Layer
class AuthRepositoryImpl implements AuthRepository {
  // Call the abstract interface we create from Data Layer and inject it
  final AuthSupabaseDataSource _authSupabaseDataSource;
  AuthRepositoryImpl(this._authSupabaseDataSource);

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUserAsync(
      () async => await _authSupabaseDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return _getUserAsync(
      () async => await _authSupabaseDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  // Create a wrapper function, since the implementation are the same
  Future<Either<Failure, User>> _getUserAsync(
    Future<User> Function() function,
  ) async {
    try {
      final user = await function();

      // Right: return type would be a String
      return right(user);
    } on supabase.AuthException catch (e) {
      // Left: return type would be a Failure class
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
