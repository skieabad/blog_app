import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignInCase implements UseCase<User, UserSignInCaseParams> {
  final AuthRepository _authRepository;
  const UserSignInCase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignInCaseParams params) async {
    return await _authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInCaseParams {
  final String email;
  final String password;

  const UserSignInCaseParams(this.email, this.password);
}
