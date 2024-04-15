import 'package:equatable/equatable.dart';

class ProcessWorkEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String creator;
  final String org;
  final bool active;

  const ProcessWorkEntity({
    this.id = 0,
    this.name = '',
    this.description = '',
    this.creator = '',
    this.org = '',
    this.active = true,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        creator,
        org,
        active,
      ];
}
