// ignore_for_file: constant_identifier_names

import 'package:tmed_kiosk/assets/constants/images.dart';

enum SearchesTypeEnum {
  magazine('magazine'),
  vacancy('vacancy'),
  announcement('announcement');

  const SearchesTypeEnum(this.value);

  final String value;
}

enum ComplainEnum {
  lies_and_deception('lies_and_deception'),
  illegal_actions('illegal_actions'),
  violent_and_gruesome_content('violent_and_gruesome_content'),
  dangerous_actions('dangerous_actions'),
  delete('delete');

  const ComplainEnum(this.value);

  final String value;
}

enum ModerationStatusEnum {
  //pending, approved, rejected
  pending('pending'),
  approved('approved'),
  rejected('rejected');

  const ModerationStatusEnum(this.value);

  final String value;
}

enum AppType {
  TMED,
  DASUTY,
  MPD,
  DWED;

  String get appTitle => switch (this) {
        AppType.DASUTY => "DASUTY TASK",
        AppType.DWED => "DWED TASK",
        AppType.TMED => "T-MED Kassa",
        AppType.MPD => "MPD KASSA",
      };

  String get logoImage => switch (this) {
        AppType.DASUTY => AppImages.dasuty,
        AppType.DWED => AppImages.dwed,
        AppType.TMED => AppImages.tmed,
        AppType.MPD => AppImages.logoMpd,
      };
}

enum SampleItem {
  er,
  ayol,
  other;

  String get genderType => switch (this) {
        SampleItem.er => "m",
        SampleItem.ayol => "f",
        SampleItem.other => "n",
      };
}

enum AppUrl {
  LOCAL,
  GLOBAL;

  String get baseUrl => switch (this) {
        AppUrl.LOCAL => "http://82.215.78.34/",
        AppUrl.GLOBAL => "http://82.215.78.34/",
      };

  String get socketUrl => switch (this) {
        AppUrl.LOCAL => "ws://82.215.78.34",
        AppUrl.GLOBAL => "ws://82.215.78.34",
      };
}
