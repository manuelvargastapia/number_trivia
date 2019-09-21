import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/error/failure.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

/// Use Case Class
/// It holds one of our use cases: get an Entity (or Failure) from Repository.

class GetConcreteNumberTrivia {
  final NumberTriviaRepository numberTriviaRepository;

  GetConcreteNumberTrivia(this.numberTriviaRepository);

  // This method is being implemented here only after we write the test for this class.
  // In the test, we've defined what is the actual behaviour of this method.
  // To follow TDD in a strict way, we should run the test without implementing completely this
  // method. In this case, though, only have one line.
  Future<Either<Failure, NumberTrivia>> execute({@required int number}) async {
    return await numberTriviaRepository.getConcreteNumberTrivia(number);
  }
}
