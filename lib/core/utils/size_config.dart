import 'package:flutter/widgets.dart'
    show BuildContext, MediaQuery, MediaQueryData, WidgetsBinding;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double _h;
  static late double _v;

  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static late double _pixelRatio;

  static double h(num n) => (n / screenWidth * _h) * 100;
  static double v(num n) => (n / screenHeight * _v) * 100;
  static double t(num n) => (n / screenHeight) * screenWidth;
  static double get pixelRatio => _pixelRatio;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;

    screenHeight = _mediaQueryData.size.height;
    _h = screenWidth / 100;
    _v = screenHeight / 100;
    _pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
