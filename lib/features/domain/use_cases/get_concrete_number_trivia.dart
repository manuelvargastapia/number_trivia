import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';

import '../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

/// Use Case Class.
/// It holds one of our use cases: get an Entity (or Failure) from Repository.
class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  // This method is being implemented here only after we write the test for this class.
  //
  // TDD workflow:
  // 1. RED (fail the test)
  // 2. GREEN (pass the test)
  // 3. REFACTOR (rewrite the code already written from the test and the test itself)

  // Implementation of Repostiroy method (before refactoring)
  // Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
  //  return await numberTriviaRepository.getConcreteNumberTrivia(number);
  // }

  // Implementation of Repository method (refactored, using Dart Callable Class
  // via implementing UseCase abstract class)
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async =>
      await numberTriviaRepository.getConcreteNumberTrivia(params.number);
}

/// Params class to hold all the params for call() in abstract UseCase class.
class Params extends Equatable {
  final int number;

  Params({@required this.number});
}
