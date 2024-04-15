import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/legal_from_entity.dart';

part 'legal_form_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LegalFormModel extends LegalFormEntity {
  const LegalFormModel({
    super.id,
    super.name,
    super.description,
    super.short,
  });

  factory LegalFormModel.fromJson(Map<String, dynamic> json) =>
      _$LegalFormModelFromJson(json);

  Map<String, dynamic> toJson() => _$LegalFormModelToJson(this);
}
