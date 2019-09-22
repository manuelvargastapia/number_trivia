import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/platform/NetworkInfo.dart';
import 'package:number_trivia/features/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/data/repositories/number_trivia_repository_impl.dart';

// Mocks for all of the dependencies we want to test

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    // We want initialize Repository implementation with the data sources and network info
    // objects, so we need to add some parameters to the constructor of such class
    repository = NumberTriviaRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });
}
