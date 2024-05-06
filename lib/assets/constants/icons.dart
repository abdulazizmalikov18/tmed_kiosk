import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static const logo = 'assets/icons/logo.svg';
  static const bookMark = 'assets/icons/book_mark.svg';
  static const logoGr = 'assets/icons/logo_gr.svg';
  static const cosmo = 'assets/icons/cosmo.svg';
  static const cart = 'assets/icons/cart.svg';
  static const camera = 'assets/icons/camera.svg';
  static const box = 'assets/icons/box.svg';
  static const timer = 'assets/icons/timer.svg';
  static const category = 'assets/icons/category.svg';
  static const userAdd = 'assets/icons/user-add.svg';
  static const users = 'assets/icons/user-add.svg';
  static const search = 'assets/icons/search.svg';
  static const noConnect = 'assets/icons/no_connect.svg';
  static const cosmoCart = 'assets/icons/cosmo_cart.svg';
  static const noData = 'assets/icons/no_data.svg';
  static const receiptSearch = 'assets/icons/receipt-search.svg';
  static const rowVertical = 'assets/icons/row-vertical.svg';
  static const shoppingCart = 'assets/icons/shopping-cart.svg';
  static const moneyRecive = 'assets/icons/money-recive.svg';
  static const addCircle = 'assets/icons/add-circle.svg';
  static const minusCircle = 'assets/icons/minus_circle.svg';
  static const barCode = 'assets/icons/barcode.svg';
  static const dwedLogo = 'assets/icons/dwed_logo.svg';
  static const filterRemove = 'assets/icons/filter-remove.svg';
  static const infoCircle = 'assets/icons/info-circle.svg';
  static const languageCircle = 'assets/icons/language-circle.svg';
  static const dollarCircle = 'assets/icons/dollar-circle.svg';
  static const global = 'assets/icons/global.svg';
  static const arrowDown = 'assets/icons/arrow_down.svg';
  static const arrowDownB = 'assets/icons/arrow-down_b.svg';
  static const moneySend = 'assets/icons/money-send.svg';
  static const receiptItem = 'assets/icons/receipt-item.svg';
  static const discount = 'assets/icons/discount-shape.svg';
  static const calendar = 'assets/icons/calendar.svg';
  static const calendarEdit = 'assets/icons/calendar_edit.svg';
  static const eye = 'assets/icons/eye.svg';
  static const arrowSwapHorizontal = 'assets/icons/arrow-swap-horizontal.svg';
  static const call = 'assets/icons/call.svg';
  static const personalcard = 'assets/icons/personalcard.svg';
  static const walletMoney = 'assets/icons/wallet-money.svg';
  static const userVip = 'assets/icons/user_vip.svg';
  static const prodajit = 'assets/icons/prodajit.svg';
  static const moneys = 'assets/icons/moneys.svg';
  static const moneysend = 'assets/icons/money-send.svg';
  static const money3 = 'assets/icons/money-3.svg';
  static const home = 'assets/icons/home.svg';
  static const homeend = 'assets/icons/homeend.svg';
  static const person = 'assets/icons/person.svg';
  static const personend = 'assets/icons/personend.svg';
  static const bag = 'assets/icons/bag.svg';
  static const bagend = 'assets/icons/bagend.svg';
  static const notificationend = 'assets/icons/notificationend.svg';
  static const autoBrightness = 'assets/icons/auto-brightness.svg';
  static const sort = 'assets/icons/sort.svg';
  static const arrowLeft = 'assets/icons/arrow-left.svg';
  static const arrowRight = 'assets/icons/arrow-right.svg';
  static const directUp = 'assets/icons/direct-up.svg';
  static const timeCircle = 'assets/icons/time-circle.svg';
  static const building = 'assets/icons/building.svg';
  static const user = 'assets/icons/user.svg';
  static const statusUp = 'assets/icons/status-up.svg';
  static const statusend = 'assets/icons/statusend.svg';
  static const delate = 'assets/icons/delate.svg';
  static const printer = 'assets/icons/printer.svg';
  static const wifi = 'assets/icons/wifi.svg';
  static const logout = 'assets/icons/logout.svg';
  static const infinity = 'assets/icons/infinity.svg';
  static const add = 'assets/icons/add.svg';
  static const minus = 'assets/icons/minus.svg';
  static const map = 'assets/icons/map.svg';
  static const mapend = 'assets/icons/mapend.svg';
  static const filter = 'assets/icons/setting-4.svg';
  static const send = "assets/icons/send.svg";
  static const location = "assets/icons/location.svg";
  static const avatarDefault = "assets/icons/avatar_default.svg";
  static const closeCircle = 'assets/icons/close_circle.svg';
  static const size = 'assets/icons/size.svg';
  static const myLocation = 'assets/icons/my_location.svg';
  static const tag = "assets/icons/tag.svg";
  static const cancel = "assets/icons/cancel.svg";
  static const tickSquare = "assets/icons/tick-square.svg";
  static const languageSquare = "assets/icons/language-square.svg";
  static const wallet = "assets/icons/wallet.svg";
  static const boxBold = "assets/icons/box_bold.svg";
  static const checkbox = "assets/icons/checkbox.svg";
  static const task = "assets/icons/task.svg";
  static const checkboxNull = "assets/icons/checkbox_null.svg";
  static const icSmsTracking = 'assets/icons/ic_sms_tracking.svg';
  static const icMoon = "assets/icons/ic_moon.svg";
  static const icSun = "assets/icons/ic_sun.svg";
  static const checkboxesOff = "assets/icons/checkbox_base.svg";
  static const checkboxesOn = "assets/icons/checkboxes.svg";
  static const icProfileArrowUp = "assets/icons/arrow_up_profile.svg";
  static const icProfileArrowDown = "assets/icons/arrow_down_profile.svg";
  static const image360 = "assets/icons/360_image.svg";
}

extension SvgExt on String {
  SvgPicture svg({
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      this,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      width: width,
      height: height,
    );
  }
}
