import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/category/data/datasources/category_datasource.dart';
import 'package:tmed_kiosk/features/category/data/model/category_model.dart';
import 'package:tmed_kiosk/features/category/data/model/catigory_filter_model.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';

class CatigoryLocalDataSource extends CatrgoryDataSource {
  final box = Hive.box(StorageKeys.PRODUCTS);
  @override
  Future<GenericPagination<CategoryModel>> categoryList(
      CatigoryFilter param) async {
    try {
      List<dynamic> usersJson = box.get(StorageKeys.CATIGORY, defaultValue: []);
      List<CategoryModel> catigorys = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return CategoryModel.fromJson(map);
      }).toList();
      if (param.search != null) {
        catigorys = catigorys
            .where((element) => element.name
                .toLowerCase()
                .contains(param.search!.toLowerCase()))
            .toList();
      }
      final pagination = GenericPagination<CategoryModel>(
        results: catigorys,
      );
      return pagination;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
