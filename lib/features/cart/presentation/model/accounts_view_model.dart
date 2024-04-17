import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmed_kiosk/core/utils/my_function.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_set/region_sel.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/accounts/accounts_bloc.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';

class AccountsViewModel {
  TextEditingController phone = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController latname = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController region = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController cupon = TextEditingController();
  RegionEntity? regionEntity;
  ProfessionEntity? professionEntity;
  bool isChek = false;
  bool isCreat = false;
  List<RegionSelection> pageInTitle = [];
  List<RegionSelection> professionList = [];

  void selectPag(BuildContext context, int ind, String name, int id) async {
    if (ind == 1 || ind == 2) {
      if (name.isNotEmpty) {
        pageInTitle.add(RegionSelection(id: id, name: name));
      } else {
        pageInTitle.removeLast();
      }
    } else {
      pageInTitle = [];
    }
    context.read<AccountsBloc>().add(GetRegion(index: ind, id: id));
  }

  void selectPagProffesion(
      BuildContext context, int ind, String name, int id) async {
    if (ind == 1 || ind == 2) {
      if (name.isNotEmpty) {
        professionList.add(RegionSelection(id: id, name: name));
      } else {
        professionList.removeLast();
      }
    } else {
      professionList = [];
    }
    context.read<AccountsBloc>().add(GetProfession(index: ind, id: id));
  }

  void selectAccount(AccountsEntity account) {
    Log.w(account);
    isChek = true;
    phone.text = account.pinfl.isEmpty ? account.phone : account.pinfl;
    name.text = account.name;
    latname.text = account.lastname;
    controller.text = "${account.name} ${account.lastname}";
    gender.text = account.gender;
    region.text = account.region.name;
    profession.text = account.mainCat.name;
    isCreat = true;
    age.text = MyFunctions.parseDate(account.birthday);
  }

  void clearAccount(BuildContext context) {
    controller.clear();
    phone.clear();
    name.clear();
    name.clear();
    latname.clear();
    profession.clear();
    region.clear();
    age.clear();
    isChek = false;
    isCreat = false;
    regionEntity = null;
    professionEntity = null;
    context.read<AccountsBloc>().add(DelSelectionAcccount());
  }
}
