import 'dart:convert';

import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';
import 'package:hive/hive.dart';
import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/common/pagination/models/generic_pagination.dart';
import 'package:tmed_kiosk/features/specialists/data/datasources/specialists_datasources.dart';
import 'package:tmed_kiosk/features/specialists/data/model/spec_cat_model.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specialist_model.dart';
import 'package:tmed_kiosk/features/specialists/data/model/specil_filter.dart';
import 'package:tmed_kiosk/features/specialists/data/model/today_time_table_model.dart';
import 'package:tmed_kiosk/features/specialists/domain/entity/day_id.dart';

class SpecialistsLocalDataSource extends SpecialistsDataSource {
  final box = Hive.box(StorageKeys.PRODUCTS);
  @override
  Future<GenericPagination<SpecCatModel>> getSpecialistCats(
      Filter param) async {
    try {
      List<dynamic> usersJson =
          box.get(StorageKeys.SPECIALCATS, defaultValue: []);
      List<SpecCatModel> specialists = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return SpecCatModel.fromJson(map);
      }).toList();
      final pagination = GenericPagination<SpecCatModel>(
        results: specialists,
        count: specialists.length,
      );
      return pagination;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<SpecialistsModel>> getSpecialists(
      SpecialFilter param) async {
    bool isSort = false;
    try {
      List<dynamic> usersJson =
          box.get(StorageKeys.SPECIALISTS, defaultValue: []);
      int count = box.get(StorageKeys.PRODUCTCOUNT, defaultValue: 0);
      List<SpecialistsModel> specialists = usersJson.map((value) {
        final json = jsonEncode(value);
        final map = jsonDecode(json);
        return SpecialistsModel.fromJson(map);
      }).toList();
      if (param.specCat != null) {
        isSort = true;
        specialists = specialists
            .where((element) => element.specCat.id == param.specCat)
            .toList();
      }
      if (param.search != null) {
        isSort = true;
        specialists = specialists
            .where((element) => "${element.name} ${element.lastname}"
                .toLowerCase()
                .contains(param.search!.toLowerCase()))
            .toList();
      }
      final pagination = GenericPagination<SpecialistsModel>(
        results: specialists,
        count: isSort ? specialists.length : count,
      );
      return pagination;
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<GenericPagination<TodayTimetableModel>> getTimetable(int id) {
    throw UnimplementedError();
  }

  @override
  Future<TodayTimetableModel> getTimetableDay(DayId param) {
    throw UnimplementedError();
  }
}
