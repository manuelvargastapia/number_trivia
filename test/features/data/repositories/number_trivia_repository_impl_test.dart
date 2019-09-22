import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/error/exception.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/platform/NetworkInfo.dart';
import 'package:number_trivia/features/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/data/data_sources/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/domain/entities/number_trivia.dart';

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

  // Helper functions to handle flow control
  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  // We've structured our test by grouping them according to use cases and
  // possible situations
  group("getConcreteNumberTrivia", () {
    final int testNumber = 1;
    final NumberTriviaModel testNumberTriviaModel =
        NumberTriviaModel(number: testNumber, text: "Test");
    final NumberTrivia testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () async {
      // Arrange
      // Set up for mocked NetworkInfo to make its getter always return "true"
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      repository.getConcreteNumberTrivia(testNumber);
      // Assert
      // Verify
      // Verify that the mockNetworkInfo isConnected getter is being called
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      // Test name convention: "should [action] when [condition]"
      test(
          'should return remote data when the call to remote data is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        // Assert
        expect(result, Right(testNumberTrivia));
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'should cache the data locally when the call to remote data is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        await repository.getConcreteNumberTrivia(testNumber);
        // Assert
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
        // Verify that mocked local data source has cached the proper trivia
        verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
      });

      test(
          'should return ServerFailure when the call to remote data is unsuccessful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());
        // Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        // Assert
        expect(result, Left(ServerFailure()));
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getConcreteNumberTrivia(testNumber));
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        // Assert
        expect(result, Right(testNumberTrivia));
        // Verify
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getConcreteNumberTrivia(testNumber);
        // Assert
        expect(result, Left(CacheFailure()));
        // Verify
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });

  group("getRandomNumberTrivia", () {
    final NumberTriviaModel testNumberTriviaModel =
        NumberTriviaModel(number: 1, text: "Test");
    final NumberTrivia testNumberTrivia = testNumberTriviaModel;

    test('should check if the device is online', () async {
      // Arrange
      // Set up for mocked NetworkInfo to make its getter always return "true"
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      // Act
      repository.getRandomNumberTrivia();
      // Assert
      // Verify
      // Verify that the mockNetworkInfo isConnected getter is being called
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      // Test name convention: "should [action] when [condition]"
      test(
          'should return remote data when the call to remote data is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        final result = await repository.getRandomNumberTrivia();
        // Assert
        expect(result, Right(testNumberTrivia));
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'should cache the data locally when the call to remote data is successful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        await repository.getRandomNumberTrivia();
        // Assert
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        // Verify that mocked local data source has cached the proper trivia
        verify(mockLocalDataSource.cacheNumberTrivia(testNumberTriviaModel));
      });

      test(
          'should return ServerFailure when the call to remote data is unsuccessful',
          () async {
        // Arrange
        when(mockRemoteDataSource.getRandomNumberTrivia())
            .thenThrow(ServerException());
        // Act
        final result = await repository.getRandomNumberTrivia();
        // Assert
        expect(result, Left(ServerFailure()));
        // Verify
        // Verify that the mocked remote data source was called with proper argument
        verify(mockRemoteDataSource.getRandomNumberTrivia());
        verifyNoMoreInteractions(mockRemoteDataSource);
        verifyZeroInteractions(mockLocalDataSource);
      });
    });

    runTestsOffline(() {
      test(
          'should return last locally cached data when the cached data is present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => testNumberTriviaModel);
        // Act
        final result = await repository.getRandomNumberTrivia();
        // Assert
        expect(result, Right(testNumberTrivia));
        // Verify
        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource.getLastNumberTrivia());
      });

      test('should return CacheFailure when there is no cached data present',
          () async {
        // Arrange
        when(mockLocalDataSource.getLastNumberTrivia())
            .thenThrow(CacheException());
        // Act
        final result = await repository.getRandomNumberTrivia();
        // Assert
        expect(result, Left(CacheFailure()));
        // Verify
        verify(mockLocalDataSource.getLastNumberTrivia());
        verifyZeroInteractions(mockRemoteDataSource);
      });
    });
  });
}
