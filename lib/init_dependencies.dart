import 'package:blog_app/features/auth/data/datasources/auth_supabase_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/use_cases/user_sign_up_case.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // Load .env file
  await dotenv.load(fileName: ".env");

  // Call the value from the .env file
  var supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  var supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  _initAuth();
  final supabase = await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
  );

  // Register the supabase
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

// Register the classes that have constructor with required an instance
void _initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSourceImpl(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(
    () => UserSignUpCase(serviceLocator()),
  );

  // We use registerLazySingleton here since we only need one instance of the AuthBloc
  // Otherwise, our app will create a new instance of AuthBloc every time we call it
  // And that's a big problem since we need to keep the state of the AuthBloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUpCase: serviceLocator()),
  );
}
