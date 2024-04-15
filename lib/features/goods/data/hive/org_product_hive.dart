import 'package:hive_flutter/hive_flutter.dart';
import 'package:tmed_kiosk/features/goods/data/model/org_product_model.dart';

@HiveType(typeId: 0)
class OrgProductAdapter extends TypeAdapter<OrgProductModel> {
  @override
  final typeId = 0;

  @override
  OrgProductModel read(BinaryReader reader) {
    return OrgProductModel.fromJson(reader.read());
  }

  @override
  void write(BinaryWriter writer, OrgProductModel obj) {
    writer.write(obj.toJson());
  }
}
