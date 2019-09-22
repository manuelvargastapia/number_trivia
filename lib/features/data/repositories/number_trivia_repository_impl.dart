import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../core/error/failure.dart';
import '../../../core/platform/NetworkInfo.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/repositories/number_trivia_repository.dart';
import '../data_sources/number_trivia_local_data_source.dart';
import '../data_sources/number_trivia_remote_data_source.dart';

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

  /// Convert raw external data retrieved for Data Suurces into a NumberTrivia or a Failure,
  /// in case of exceptions.
  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number) {
    // TODO: implement getConcreteNumberTrivia
    return null;
  }

  /// Convert raw external data retrieved for Data Suurces into a NumberTrivia or a Failure,
  /// in case of exceptions.
  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    return null;
  }
}
