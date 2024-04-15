import 'package:equatable/equatable.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_account_entity.dart';

class CreateAccountEntity extends Equatable {
  final String access;
  final String refresh;
  @UserAccountConverter()
  final UserAccountEntity user;

  const CreateAccountEntity({
    this.access = "",
    this.refresh = "",
    this.user = const UserAccountEntity(),
  });

  @override
  List<Object?> get props => [
        access,
        refresh,
        user,
      ];
}
