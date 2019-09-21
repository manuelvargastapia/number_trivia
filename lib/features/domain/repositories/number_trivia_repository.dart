import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../entities/number_trivia.dart';

/// Repository abstract class.
/// This is the contractual part of the Repository layer for the app.
/// It's an abstract class that must be implemented by Data layer repository.
/// In Domain layer, NumberTriviaRepository defines an interface to Use Cases.
abstract class NumberTriviaRepository {
  // We're using functional programming to return a Future whose type is a the wrapper
  // Either type that receives a pair of an error type (left) and success type (right).
  // This way, NumberTriviaRepositry will convert exceptions to Failure objects, so we
  // don't need handle errors with try-catch block anymore.

  /// Abstract method to be implemented by Use Cases.
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);

  /// Abstract method to be implemented by Use Cases.
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
