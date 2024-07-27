import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

// We create an abstract interface class here since this will be called in the domain layer and in the presentation layer (specific for bloc)
// We use generics here to define it's methods which is SuccessType and Params
abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

class NoParams {}
