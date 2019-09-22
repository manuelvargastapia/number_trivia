import '../models/number_trivia_model.dart';

/// Interface to define the method that will retrieve data from external resource.
abstract class NumberTriviaRemoteDataSource {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);

  ///Calls the http://numbersapi.com/random endpoint.
  ///
  ///Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
