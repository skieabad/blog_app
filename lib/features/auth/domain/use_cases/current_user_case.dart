import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/use_case/use_case.dart';
import 'package:blog_app/core/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUserCase implements UseCase<User, NoParams> {
  final AuthRepository _authRepository;
  CurrentUserCase(this._authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await _authRepository.getCurrentUser();
  }
}
