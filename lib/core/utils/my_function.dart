// ignore_for_file: constant_identifier_names

import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_model.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/process_status_entity.dart';
import 'package:tmed_kiosk/features/cart/presentation/controllers/bloc/cart_bloc.dart';
import 'package:tmed_kiosk/features/common/controllers/price_bloc/price_bloc.dart';
import 'package:tmed_kiosk/features/common/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/common/entity/kassa_special_entity.dart';
import 'package:tmed_kiosk/features/common/entity/order_product_entity.dart';
import 'package:tmed_kiosk/features/common/repo/log_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmed_kiosk/assets/colors/colors.dart';
import 'package:tmed_kiosk/features/auth/presentation/widgets/lenguage_select.dart';
import 'package:tmed_kiosk/features/common/user_type/user_type.dart';
import 'package:tmed_kiosk/features/goods/domain/entity/list_count.dart';
import 'package:tmed_kiosk/generated/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as html_parser;

class MyFunctions {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  static bool isOpenProduct(String key) {
    return (key != "cancel" && key != "finish");
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Remove leading '+' if present
    if (cleanedNumber.startsWith('998')) {
      return cleanedNumber;
    } else if (cleanedNumber.startsWith('998')) {
      return cleanedNumber.substring(1);
    }

    return cleanedNumber;
  }

  static UserType usertype(KassaSpecialEntity model) {
    switch (model.org.operationType) {
      case "medicine":
        return UserType.medicine;
      case "business":
        return UserType.business;
      case "administration":
        return UserType.administration;
      case "freelance":
        return UserType.freelance;
      default:
        return UserType.none;
    }
  }

  static ProcessStatusEntity? checkStatus(List<ProcessStatusEntity> entity) {
    for (var element in entity) {
      if (element.key != 'cancel' && element.key != 'finish') {
        return element;
      }
    }
    return null;
  }

  static String formattedDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'xx.xx.xxxx';
    } else {
      return DateFormat(DATE_FORMAT).format(dateTime.toLocal());
    }
  }

  static double paddingRespons(double height) {
    if (height <= 800) {
      return 8;
    } else {
      return 12;
    }
  }

  static double height(double height) {
    if (height <= 800) {
      return 36;
    } else {
      return 44;
    }
  }

  static String priceFormat(num data) {
    int price = data.toInt();
    String result = '';
    int count = 0;

    if (price == 0) {
      return '-';
    } else {
      for (int i = price.toString().length - 1; i >= 0; i--) {
        if (count == 3) {
          result = '${price.toString()[i]} $result';
          count = 0;
        } else {
          result = price.toString()[i] + result;
        }
        count++;
      }
      return result;
    }
  }

  static String getforDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat('dd MMM, EEE').format(dateTime);
    return formattedDate;
  }

  static String ageDate(DateTime dateTime) {
    String formattedDateTime =
        DateFormat('yyyy-MM-dd').format(dateTime.toLocal());

    return formattedDateTime;
  }

  static String information(String date) {
    if (date == "Oliy") {
      return "high";
    } else if (date == "Orta") {
      return "middle";
    } else if (date == "Maktab") {
      return "low";
    } else {
      return "no";
    }
  }

  static String informationConvert(String date) {
    if (date == "high") {
      return "Oliy";
    } else if (date == "middle") {
      return "Orta";
    } else if (date == "low") {
      return "Maktab";
    } else if (date == "no") {
      return "Oqmagan";
    } else {
      return date;
    }
  }

  static String informationParse(String date) {
    if (date == "high") {
      return "Oliy";
    } else if (date == "middle") {
      return "Orta";
    } else if (date == "low") {
      return "Maktab";
    } else {
      return "Oqimagan";
    }
  }

  static String secondToTime(int time) {
    int hour = (time / 3600).floor();
    int min = ((time - hour * 3600) / 60).floor();
    int sec = time % 60;
    String hours = hour.toString().length <= 1 ? "0$hour" : "$hour";
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$hours:$minute:$second";
  }

  static String getShifrPhone(String string) {
    if (string.isNotEmpty) {
      return " **********${string.substring(string.length - 2)}";
    } else {
      return " **********";
    }
  }

  static int changeNegativeToPositive(int number) {
    if (number < 0) {
      return number * -1;
    } else {
      return number;
    }
  }

  static int discountPrice(int discount, int price) {
    int eprice = 0;
    if (discount > 0) {
      eprice = price + price * discount ~/ 100;
      Log.w("discount > 0 : $eprice");
    } else if (discount < 0) {
      eprice = price + price * discount ~/ 100;
      Log.w("discount < 0 : $eprice");
    } else {
      eprice = price;
    }
    return price - eprice;
  }

  static String createPrice(BuildContext context) {
    if (context.read<PriceBloc>().state.isPrice) {
      return 'Vazifa yaratildi';
    } else {
      return "Vazifa yaratildi";
    }
  }

  static String formatDate(String inputDate) {
    try {
      if (inputDate.length == 10) {
        Log.w("Nima gap $inputDate");
        if (inputDate[2] == "-") {
          DateFormat dateFormat = DateFormat("dd-MM-yyyy");
          DateTime dateTime = dateFormat.parse(inputDate);
          return DateFormat(DATE_FORMAT).format(dateTime);
        } else {
          DateFormat dateFormat = DateFormat("yyyy-MM-dd");
          DateTime dateTime = dateFormat.parse(inputDate);
          return DateFormat(DATE_FORMAT).format(dateTime);
        }
      } else {
        Log.w("Nima gap 2");
        Log.d(inputDate);
        // Parse the input string into a DateTime object
        DateTime dateTime = DateTime.parse(inputDate);
        // Format the DateTime object into the desired format
        return DateFormat(DATE_FORMAT).format(dateTime);
      }
    } catch (e) {
      return "";
    }
  }

  static bool isCupon(CuponModel model, int id) {
    for (var partner in model.partner) {
      for (var group in partner.groups) {
        if (group.products.contains(id)) {
          return true;
        }
      }
    }
    return false;
  }

  static String formatDate2(String inputDate) {
    // Parse the input string into a DateTime object
    DateTime originalDate = DateFormat('dd/MM/yyyy').parse(inputDate).toLocal();

    // Format the date in 'yyyy-MM-dd' format
    String formattedDate = DateFormat('yyyy-MM-dd').format(originalDate);
    // Format the DateTime object into the desired format
    return formattedDate;
  }

  static int discountInt(int discount, int price) {
    int eprice = 0;
    if (discount > 0) {
      eprice = price + price * discount ~/ 100;
      return eprice;
    } else if (discount < 0) {
      eprice = price + price * discount ~/ 100;
      return eprice;
    } else {
      eprice = price;
      return eprice;
    }
  }

  static String discount(int discount, int price) {
    int eprice = 0;
    if (discount > 0) {
      eprice = price + price * discount ~/ 100;
    } else if (discount < 0) {
      eprice = price + price * discount ~/ 100;
    } else {
      eprice = price;
    }
    return getThousandsSeparatedPrice(eprice.toString());
  }

  static String parseHtmlString(String htmlString) {
    var document = html_parser.parse(htmlString);
    var paragraphs = document.getElementsByTagName('p');
    List<String> result = [];

    for (var paragraph in paragraphs) {
      var text = "${paragraph.text.trim()}\n";
      result.add(text);
    }

    return result.join();
  }

  static String parseDate(String date) {
    try {
      var myDate = DateTime.parse(date).toLocal();
      return DateFormat(DATE_FORMAT).format(myDate);
    } catch (e) {
      return "";
    }
  }

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: onClicked,
            child: const Text('Done'),
          ),
        ),
      );

  static String getFilter(int count) {
    switch (count) {
      case 3:
        return 'Tugallanmagan Vazifalar';
      case 1:
        return 'Tugallangan Vazifalar';
      default:
        return 'Hamma Vazifalar keldi';
    }
  }

  static ColorFilter? getColor(int i) {
    switch (i) {
      case 1:
        return null;
      case 2:
        return const ColorFilter.mode(Colors.orange, BlendMode.srcIn);
      default:
        return const ColorFilter.mode(greyText, BlendMode.srcIn);
    }
  }

  static String getThousandsSeparatedPrice(String price) {
    var priceInText = '';
    price = price.replaceAll('.0', '');
    var counter = 0;
    for (var i = price.length - 1; i >= 0; i--) {
      counter++;
      var str = price[i];
      if ((counter % 3) != 0 && i != 0) {
        priceInText = '$str$priceInText';
      } else if (i == 0) {
        priceInText = '$str$priceInText';
      } else {
        priceInText = ' $str$priceInText';
      }
    }
    return priceInText.trim();
  }

  static String getType(SampleItem item) {
    switch (item) {
      case SampleItem.en:
        return LocaleKeys.language_en.tr();
      case SampleItem.ru:
        return LocaleKeys.language_ru.tr();
      case SampleItem.uz:
        return LocaleKeys.language_uz.tr();
      case SampleItem.kz:
        return LocaleKeys.language_en.tr();
    }
  }

  static String getFormatCost(String cost) {
    if (cost.isEmpty) return '';
    var oldCost = cost;
    if (cost.contains('.')) {
      final arr = cost.split('.');
      oldCost = arr.first;
    }
    var newCost = '';
    for (var i = 0; i < oldCost.length; i++) {
      if ((oldCost.length - i) % 3 == 0) newCost += ' ';
      newCost += oldCost[i];
    }
    return newCost.trimLeft();
  }

  static OrderCouponEntity? filterCupons(List<OrderProductEntity> products) {
    for (var element in products) {
      if (element.coupon.id != 0) {
        return element.coupon;
      }
    }
    return null;
  }

  // static String getFormatCost(String cost) {
  //   if (cost.isEmpty) return '';
  //   var oldCost = cost;
  //   if (cost.contains('.')) {
  //     final arr = cost.split('.');
  //     oldCost = arr.first;
  //   }
  //   var newCost = '';
  //   for (var i = 0; i < oldCost.length; i++) {
  //     if ((oldCost.length - i) % 3 == 0) newCost += ' ';
  //     newCost += oldCost[i];
  //   }
  //   return newCost.trimLeft();
  // }

  static String getClockFormat(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();

    String formattedDateTime = DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

    return formattedDateTime;
  }

  static String getClockFormatSek(String date) {
    try {
      DateTime dateTime = DateTime.parse(date).toLocal();
      String formattedDateTime = DateFormat('HH:mm').format(dateTime);
      return formattedDateTime;
    } catch (e) {
      String formattedDateTime = DateFormat('HH:mm').format(DateTime.now());
      return formattedDateTime;
    }
  }

  static String getClockFormat2(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();

    String formattedDateTime = DateFormat('HH:mm dd.MM.yyyy').format(dateTime);

    return formattedDateTime;
  }

  static String getformCloc(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDateTime = DateFormat('HH:mm').format(dateTime);
    return formattedDateTime;
  }

  static String getformDate(String date) {
    DateTime dateTime = DateTime.parse(date).toLocal();

    String formattedDateTime = DateFormat('HH:mm dd.MM.yyyy').format(dateTime);

    return formattedDateTime;
  }

  static String clockform(String date) {
    if (date.length > 6) {
      final a = date.substring(0, 5);
      return a;
    }

    return date;
  }

  static int weekday(String day) {
    switch (day) {
      case "mon":
        return 1;
      case "tue":
        return 2;
      case "wed":
        return 3;
      case "thu":
        return 4;
      case "fri":
        return 5;
      case "sat":
        return 6;
      case "sun":
        return 7;
      default:
        return 0;
    }
  }

  static String payment(int id) {
    switch (id) {
      case 1:
        return "Cash";
      case 2:
        return "Terminal";
      case 3:
        return "Online";
      case 4:
        return "From debt";
      case 5:
        return "Payment Merchant";
      case 6:
        return "Transition";
      case 7:
        return "HUMO";
      case 8:
        return "UZCARD";
      case 9:
        return "VISA";
      case 10:
        return "MASTERCARD";
      case 11:
        return "ANORBANK";
      default:
        return "Cash";
    }
  }

  static Color paymentColor(int id) {
    switch (id) {
      case 1:
        return lightBlue;
      case 2:
        return greyText;
      case 3:
        return green;
      case 4:
        return Colors.brown;
      case 5:
        return Colors.amber;
      case 6:
        return Colors.purple;
      case 7:
        return const Color(0xFF364652);
      case 8:
        return const Color(0xFF00397f);
      case 9:
        return blue;
      case 10:
        return orang;
      case 11:
        return const Color(0xFF98120D);
      default:
        return lightBlue;
    }
  }

  static ProductType getProductType(String type) {
    switch (type) {
      case 'product':
        return ProductType.product;
      case 'task':
        return ProductType.task;
      default:
        return ProductType.offering;
    }
  }
}
