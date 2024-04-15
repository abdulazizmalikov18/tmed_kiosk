import 'package:equatable/equatable.dart';

class CuponResEntity extends Equatable {
  final int id;
  final String user;
  final String date;

  const CuponResEntity({
    this.id = 0,
    this.user = "",
    this.date = "",
  });

  @override
  List<Object?> get props => [
        id,
        user,
        date,
      ];
}
