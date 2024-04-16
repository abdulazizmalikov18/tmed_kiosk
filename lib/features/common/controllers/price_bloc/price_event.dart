part of 'price_bloc.dart';

sealed class PriceEvent {
  const PriceEvent();
}

class ChangePrise extends PriceEvent {
  const ChangePrise();
}

class ChangeUserType extends PriceEvent {
  final UserType userType;

  const ChangeUserType({required this.userType});
}

class InitPrice extends PriceEvent {
  const InitPrice();
}

class ModeControllerEvent extends PriceEvent {
  final bool themeMode;
  const ModeControllerEvent({required this.themeMode});
}

