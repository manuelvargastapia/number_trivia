import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/domain/entities/number_trivia.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  // First, instantiate a Model object, following Entity structure (because Model
  // extends Entity)
  final testNumberTriviaModel = NumberTriviaModel(number: 1, text: "Test");

  // Test 1: verify that NumberTriviaModel extends from NumberTrivia
  test('should be a subclass of NumberTrivia entity', () async {
    // Arrange
    // Act
    // Assert
    // In this caso, we only need assert step
    expect(testNumberTriviaModel, isA<NumberTrivia>());
    // Verify
  });

  // Test 2: a bunch of tests for the Dart conversion from JSON to Model
  group('fromJson', () {
    test('should return a valid model when the JSON number is an integer',
        () async {
      // Arrange
      // Simulate the fetching of a json, converted to a Map, from an external source
      final Map<String, dynamic> jsonMap =
          json.decode(fixtureReader("trivia.json"));
      // Act
      // Invoke the to-be-implemented real function to convert from Map to JSON
      final result = NumberTriviaModel.fromJson(jsonMap);
      // Assert
      // Evaluate that the previous result matches the test Model
      expect(result, testNumberTriviaModel);
      // Verify
    });

    test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
      // Arrange
      // Simulate the fetching of a json, converted to a Map, from an external source
      final Map<String, dynamic> jsonMap =
          json.decode(fixtureReader("trivia_double.json"));
      // Act
      // Invoke the to-be-implemented real function to convert from Map to JSON
      final result = NumberTriviaModel.fromJson(jsonMap);
      // Assert
      // Evaluate that the previous result matches the test Model
      expect(result, testNumberTriviaModel);
      // Verify
    });
  });

  // Test 3: a bunch of tests for the Dart conversion from Model to JSON
  group("toJson", () {
    test('should return a JSON map containing the proper data', () async {
      // Arrange
      // Act
      final result = testNumberTriviaModel.toJson();
      // Assert
      final expectedMap = {"text": "Test", "number": 1};
      expect(result, expectedMap);
      // Verify
    });
  });
}
