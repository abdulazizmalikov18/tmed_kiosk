import 'package:tmed_kiosk/assets/constants/storage_keys.dart';
import 'package:tmed_kiosk/features/common/repo/storage_repository.dart';

enum UserType {
  none,
  medicine,
  business,
  administration,
  freelance;

  static UserType get getStorage =>
      switch (StorageRepository.getInt(StorageKeys.USERTYPE)) {
        1 => UserType.none,
        2 => UserType.medicine,
        3 => UserType.business,
        4 => UserType.administration,
        5 => UserType.freelance,
        _ => UserType.none,
      };

  Future<bool?> putStorage() async => await StorageRepository.putInt(
        StorageKeys.USERTYPE,
        switch (this) {
          UserType.none => 1,
          UserType.medicine => 2,
          UserType.business => 3,
          UserType.administration => 4,
          UserType.freelance => 5,
        },
      );

  @override
  String toString() => switch (this) {
        UserType.none => "NONE",
        UserType.medicine => "medicine",
        UserType.business => "business",
        UserType.administration => "administration",
        UserType.freelance => "freelance",
      };
}
