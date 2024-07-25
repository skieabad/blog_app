import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

// Call the UseCase abstract interface and implement it's method
class UserSignUpCase implements UseCase<User, UserSignUpCaseParams> {
  final AuthRepository _authRepository;
  const UserSignUpCase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignUpCaseParams params) async {
    return await _authRepository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpCaseParams {
  final String name;
  final String email;
  final String password;

  const UserSignUpCaseParams(this.name, this.email, this.password);
}
