part of 'price_bloc.dart';

class PriceState extends Equatable {
  final bool isPrice;
  final bool isMode;
  final UserType userType;

  const PriceState({
    this.isPrice = false,
    this.isMode = false,
    this.userType = UserType.none,
  });

  PriceState copyWith({
    bool? isPrice,
    bool? isMode,
    UserType? userType,
  }) =>
      PriceState(
        isPrice: isPrice ?? this.isPrice,
        isMode: isMode ?? this.isMode,
        userType: userType ?? this.userType,
      );

  @override
  List<Object> get props => [isPrice, userType,isMode];
}
