import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final num statusCode;
  final String errorMessage;

  ServerFailure({required this.errorMessage, required this.statusCode});
}

class DioFailure extends Failure {}

class ParsingFailure extends Failure {
  final String errorMessage;

  ParsingFailure({required this.errorMessage});
}

class CacheFailure extends Failure {}

class ParsingException implements Exception {
  final String errorMessage;

  const ParsingException({required this.errorMessage});
}

class NetworkFailure extends Failure {
  final String errorMessage;
  NetworkFailure({required this.errorMessage});
}
