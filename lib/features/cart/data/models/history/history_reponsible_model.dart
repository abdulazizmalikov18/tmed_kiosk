import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_responsible_entity.dart';

part 'history_reponsible_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class HistoryResponsibleModel extends HistoryResponsibleEntity {
  const HistoryResponsibleModel({
    super.id,
    super.name,
    super.lastname,
    super.org,
    super.job,
  });

  factory HistoryResponsibleModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponsibleModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponsibleModelToJson(this);
}
