import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/day_orders.dart';

part 'day_order_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class DayOrderModel extends DayOrderEntity {
  const DayOrderModel({
    super.meetDate,
    super.expectedEndDate,
    super.responsible,
    super.user,
  });

  factory DayOrderModel.fromJson(Map<String, dynamic> json) =>
      _$DayOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$DayOrderModelToJson(this);
}
