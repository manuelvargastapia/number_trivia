import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

/// Abstract class implemented by any Use Case class.
/// The class will be implemented specifying the current Type each time.
/// And Params will be implemented in a class Params that we can create for
/// every Use case.

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// Shared method to pass "no params" to the Params generic type when UseCase is implemented
class NoParams extends Equatable {}
