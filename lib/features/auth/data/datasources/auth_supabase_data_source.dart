import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthSupabaseDataSource {
  Session? get getCurrentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();
}

class AuthSupabaseDataSourceImpl implements AuthSupabaseDataSource {
  // Create a constructor that takes a SupabaseClient as a parameter and suitable for dependency injection
  // So, we can easily change from Supabase to Firebase or any other service
  // And also, we can easily test the class by mocking the SupabaseClient
  final SupabaseClient _supabaseClient;
  const AuthSupabaseDataSourceImpl(this._supabaseClient);

  @override
  Session? get getCurrentUserSession => _supabaseClient.auth.currentSession;

  @override
  Future<UserModel?> getCurrentUser() async {
    // Query the table from supabase
    try {
      if (getCurrentUserSession != null) {
        final user = await _supabaseClient
            .from('profiles')
            .select()
            .eq('id', getCurrentUserSession?.user.id ?? "");

        return UserModel.fromJson(user.first);
      }

      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) {
        throw const ServerException('No user data received from the server');
      }

      return UserModel.fromJson(response.user?.toJson() ?? {});
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabaseClient.auth.signUp(
        email: email,
        password: password,
        // Since data is a Map<String, dynamic>
        // So we can pass here the additional fields like age, gender and etc
        data: {
          'name': name,
        },
      );

      if (response.user == null) {
        throw const ServerException('No user data received from the server');
      }

      return UserModel.fromJson(response.user?.toJson() ?? {});
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
