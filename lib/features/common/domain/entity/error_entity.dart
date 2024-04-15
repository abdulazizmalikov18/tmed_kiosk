import 'package:equatable/equatable.dart';

class ErrorEntity extends Equatable {
  final String field;
  final List<String> message;

  const ErrorEntity({
    this.field = "",
    this.message = const [],
  });

  @override
  List<Object?> get props => [
        field,
        message,
      ];
}
