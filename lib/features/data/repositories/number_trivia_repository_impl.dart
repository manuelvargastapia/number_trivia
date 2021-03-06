import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../core/platform/NetworkInfo.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';
import '../models/number_trivia_model.dart';

/// Typedef for High Order Function used in refactoring
typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

/// Implementation of the abstract class NumberTriviaRepository (Domain layer).

class NumberTriviaRepositoryImpl extends NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  /// Highr Order Function to refactor duplicated code between getConcreteNumberTrivia()
  /// and getRandomNumberTrivia()
  Future<Either<Failure, NumberTrivia>> _getTrivia(
    _ConcreteOrRandomChooser getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        // Passing "should return remote data when the call to remote data is successful"
        final NumberTriviaModel remoteTrivia = await getConcreteOrRandom();
        // Passing "should cache the data locally when the call to remote data is successful"
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        // Passing "should return ServerFailure when the call to remote data is unsuccessful"
        return Left(ServerFailure());
      }
    } else {
      try {
        //Passing "should return last locally cached data when the cached data is present"
        final NumberTriviaModel localTrivia =
            await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        // Passing "should return CacheFailure when there is no cached data present"
        return Left(CacheFailure());
      }
    }
  }

  /// Convert raw external data retrieved for Data Suurces into a NumberTrivia or a Failure,
  /// in case of exceptions.
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
    int number,
  ) async =>
      await _getTrivia(() => remoteDataSource.getConcreteNumberTrivia(number));

  /// Convert raw external data retrieved for Data Suurces into a NumberTrivia or a Failure,
  /// in case of exceptions.
  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async =>
      await _getTrivia(() => remoteDataSource.getRandomNumberTrivia());
}
