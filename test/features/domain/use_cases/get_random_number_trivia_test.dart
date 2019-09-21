import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/core/use_cases/use_case.dart';
import 'package:number_trivia/features/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/domain/use_cases/get_random_number_trivia.dart';

// In the TDD methodology, tests are always written before functional code.
// In this case, also, we're mocking abstract class.

/// Use cases test for execute(number) (former, now call(Params)) method of GetRandomNumberTrivia class.
class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

// Test setup
// Any test run in main() method.
void main() {
  // Variables holding our objects
  GetRandomNumberTrivia useCase; // We need to create the actual class
  MockNumberTriviaRepository mockNumberTriviaRepository;

  // Instanciate all the objects we need
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final NumberTrivia testNumberTrivia =
      NumberTrivia(number: 1, text: "test text");

  // Four-steps test:
  // - Arrange: provide a funcionality to the mocked instance of repository
  // - Act: get the result from calling the use case method
  // - Assert: evaluate wether previous result matches the arranged one
  // - Verify (extra step): crucial validation to ensure correct test setup
  test('should get trivia from the repository', () async {
    // ARRANGE
    // "When the getRandomNumberTrivia() method of mocked repository is called,
    // the right side of Either Future returned must contain the testNumberTrivia instance".
    when(mockNumberTriviaRepository.getRandomNumberTrivia()).thenAnswer(
        (_) async =>
            Right(testNumberTrivia)); // Right: the successful side of Either
    // ACT
    // Store result from calling unimplemented method of use case (because of TDD)
    // We need to create this method in GetRandomNumberTrivia class
    // final result = await useCase.execute(number: testNumber);
    //
    // Refactoring using Dart Callable Class:
    // Now, instead of execute(), we're calling to call().
    final result = await useCase(NoParams());

    // ASSERT
    // "The result should be the right side of either with test NumberTrivia instance inside"
    expect(result, Right(testNumberTrivia));

    // VERIFY
    // Mockito utility that ensure us that the relevant method was called always with the
    // same test value. This is life-saver!
    verify(mockNumberTriviaRepository.getRandomNumberTrivia());

    // Verify that use case is not using repository anymore
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
