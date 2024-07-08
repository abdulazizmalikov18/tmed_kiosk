import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';

class SelectionAccountEntity {
  final AccountsEntity selectAccount;
  final List<CuponModel> cupons;
  final CuponModel selectCupon;

  const SelectionAccountEntity({
    this.selectAccount = const AccountsEntity(),
    this.cupons = const [],
    this.selectCupon = const CuponModel(),
  });
}
