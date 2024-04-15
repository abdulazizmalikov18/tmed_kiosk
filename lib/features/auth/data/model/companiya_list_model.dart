import 'package:json_annotation/json_annotation.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiy_category_entity.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/companiya_list_entity.dart';
import 'package:tmed_kiosk/features/auth/domain/entity/legal_from_entity.dart';

part 'companiya_list_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CompaniyaListModel extends CompaniyaListEntity {
  const CompaniyaListModel({
    super.id,
    super.legalForm,
    super.region,
    super.category,
    super.name,
    super.logo,
    super.juridicName,
    super.slugName,
    super.location,
    super.phone,
    super.status,
    super.createDate,
    super.isOfficial,
    super.textForPrint,
  });

  factory CompaniyaListModel.fromJson(Map<String, dynamic> json) =>
      _$CompaniyaListModelFromJson(json);

  Map<String, dynamic> toJson() => _$CompaniyaListModelToJson(this);
}
