import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/entity/orders_entity.dart';
import 'package:tmed_kiosk/features/common/entity/organization_entity.dart';
import 'package:tmed_kiosk/features/common/entity/user_order_entity.dart';

part 'orders_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrdersModel extends OrdersEntity {
  const OrdersModel({
    super.id,
    super.number,
    super.qrCode,
    super.clientComment,
    super.user,
    super.status,
    super.rates,
    super.payment,
    super.paymentStatus,
    super.prepaidAmount,
    super.totalCost,
    super.deviceId,
    super.specsComment,
    super.productNumber,
    super.insertedValue,
    super.creator,
    super.createDate,
    super.finishDate,
    super.products,
    super.meetAddress,
    super.organization,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) =>
      _$OrdersModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersModelToJson(this);
}
