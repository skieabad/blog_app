import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

// Implementation for AuthRepository from Domain Layer
class AuthRepositoryImpl implements AuthRepository {
  // Call the abstract interface we create from Data Layer and inject it
  final AuthSupabaseDataSource _authSupabaseDataSource;
  AuthRepositoryImpl(this._authSupabaseDataSource);

  @override
  Future<Either<Failure, UserModel>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authSupabaseDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      // Right: return type would be a String
      return right(user);
    } on ServerException catch (e) {
      // Left: return type would be a Failure class
      return left(Failure(e.message));
    }
  }
}
