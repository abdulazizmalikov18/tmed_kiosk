import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';

class SelectionAccountEntity {
  final AccountsEntity selectAccount;
  final List<CuponEntity> cupons;
  final CuponEntity selectCupon;

  const SelectionAccountEntity({
    this.selectAccount = const AccountsEntity(),
    this.cupons = const [],
    this.selectCupon = const CuponEntity(),
  });
}
