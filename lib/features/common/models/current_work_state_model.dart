import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/common/entity/creator_entity.dart';
import 'package:tmed_kiosk/features/common/entity/current_work_state_etity.dart';
import 'package:tmed_kiosk/features/common/entity/order_status_entity.dart';

part 'current_work_state_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CurrentWorkStateModel extends CurrentWorkStateEntity {
  const CurrentWorkStateModel({
    super.id,
    super.count,
    super.status,
    super.specialist,
    super.startTime,
    super.endTime,
    super.createDate,
    super.product,
  });

  factory CurrentWorkStateModel.fromJson(Map<String, dynamic> json) =>
      _$CurrentWorkStateModelFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentWorkStateModelToJson(this);
}
