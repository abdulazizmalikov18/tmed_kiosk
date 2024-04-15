import 'package:equatable/equatable.dart';

class OrgCartEntity extends Equatable {
  final int id;
  final String org;
  final dynamic user;
  final String creator;
  final String createDate;

  const OrgCartEntity({
    this.id = 0,
    this.org = '',
    this.user = '',
    this.creator = '',
    this.createDate = '',
  });

  @override
  List<Object?> get props => [
        id,
        org,
        user,
        creator,
        createDate,
      ];
}
