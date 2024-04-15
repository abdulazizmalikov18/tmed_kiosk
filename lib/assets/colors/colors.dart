import 'package:flutter/rendering.dart';

const green = _green;
const longGrey = _longGrey;
const white = _white;
const red = _red;
const dark = _dark;
const darkText = _darkText;
const grey = _grey;
const iron = _iron;
const whiteSmoke = _whiteSmoke;
const greyText = _greyText;
const whiteGrey = _whiteGrey;
const blackGrey = _blackGrey;
const blue = _blue;
const lightBlue = _lightBlue;
const shuttleGrey = _shuttleGrey;
const bGrey = _bGrey;
const orang = _orang;
const iconGrey = _iconGrey;
const imageB = _imageB;
const backGroundColor = _backGroundColor;
const inputBlue = _inputBlue;
const scaffoldBackground = _scaffoldBackground;
const buttonBackgroundColor = _buttonBackgroundColor;
const borderColor = _borderColor;
const whiteBlack = _whiteBlack;
const white50 = _white50;

const _white = Color(0xffFFFFFF);
const _white50 = Color(0xff8FA0B8);
const _dark = Color(0xff0C161D);
const _darkText = Color(0xFF262626);
const _red = Color(0xffFA193E);
const _grey = Color(0xffE7E7E8);
const _greyText = Color(0xFF445776);
const _iron = Color(0xffCCCECF);
const _green = Color(0xff2CDB66);
const _whiteSmoke = Color(0xffF7F8FC);
const _whiteGrey = Color(0xffF2F2F2);
const _whiteBlack = Color(0xFF2C394C);
const _blackGrey = Color(0xff555555);
const _iconGrey = Color(0xff828282);
const _blue = Color(0xff1A79FF);
const _bGrey = Color(0xffEFF0F8);
const _orang = Color(0xFFFD9644);
const _shuttleGrey = Color(0xff606469);
const _imageB = Color(0xffd9d9d9);
const _lightBlue = Color(0xFF706FD3);
const _backGroundColor = Color(0xFF0C1829);
const _longGrey = Color(0xffDFE0EB);
const _inputBlue = Color(0xFFD5E5FB);
const _scaffoldBackground = Color(0xFF0C1829);
const _buttonBackgroundColor = Color(0xFFDDFF8F);
const contColor = Color(0xFF142338);
const contBlue = Color.fromRGBO(26, 121, 255, 0.20);
const contGrey = Color(0xFF2C394C);
const _borderColor = Color(0xFF414D5E);

List<BoxShadow> wboxShadow = const [
  BoxShadow(
    offset: Offset(0, 0),
    blurRadius: 10,
    spreadRadius: 0,
    color: Color.fromRGBO(38, 38, 38, 0.10),
  ),
];
LinearGradient wgradient = const LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFF1DA1F2), Color(0xFF003CC5)],
);

BoxDecoration wdecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: contColor,
  boxShadow: wboxShadow,
);

BoxDecoration wdecoration2 = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: whiteBlack,
  border: Border.all(color: borderColor),
);

BoxDecoration wdecoration3 = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: borderColor,
  border: Border.all(color: const Color(0xFF545F6E)),
);

RadialGradient radialGradient = RadialGradient(
  transform: const GradientRotation(0.15),
  stops: const [0.1, 5],
  center: Alignment.centerRight,
  radius: 1.5,
  colors: [
    blue.withOpacity(.5),
    backGroundColor.withOpacity(.5),
  ],
);