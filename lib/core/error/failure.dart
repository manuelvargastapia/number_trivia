import 'package:equatable/equatable.dart';

/// Failures Class.
/// It defines our Failure objects to handle exceptions through the app.
/// In this Clean Architecture implementation, we want to handle errors ASAP,
/// concretely, in Repositories (Domain layer).
/// We want to return a Failure object to Use Cases from Repositories.

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]) : super(properties);
}

// General failures

// We want to map all the Exceptions to Failures. So the Repository (Data layer) can
// convert any Exception to a Failure object.

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}
