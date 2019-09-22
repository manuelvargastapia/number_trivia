import 'package:meta/meta.dart';

import '../../domain/entities/number_trivia.dart';

/// Model class for NumberTrivia entity.
/// This class extends from NumberTrivia and add some new funcionaltity.
/// The idea behind keeping an Entity in domain (internal) layer and also a
/// Model in data (external) layer is follow the principles of Clean
/// Architecture: we want our internal level be inmutable, while external
/// layer could change over time. For example, if we don't want to work with
/// JSON anymore, we'll have to change the Model implementations, but not our
/// Domain layer.

// We've create this class only after we build its test and failed (becasuse doesn't
// even compiles without this class implmented). Thus, the class implementation is written
// with the only objective in mind of passing the test. That is, only defines the minumun
// ammount of funciotnality required to pass the test.

class NumberTriviaModel extends NumberTrivia {
  NumberTriviaModel({@required String text, @required int number})
      : super(text: text, number: number);

  factory NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    // To pass the two tests (integer and double cases), we've used the num type
    // provided by Dart. num can be an int or a double.
    return NumberTriviaModel(
        text: json["text"], number: (json["number"] as num).toInt());
  }

  // To pass the test, we've created an instance method that returns a Map using the
  // class attributes.
  Map<String, dynamic> toJson() {
    return {"text": text, "number": number};
  }
}
