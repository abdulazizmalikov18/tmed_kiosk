part of 'price_bloc.dart';

class PriceState extends Equatable {
  final bool isPrice;
  final UserType userType;

  const PriceState({
    this.isPrice = false,
    this.userType = UserType.none,
  });

  PriceState copyWith({
    bool? isPrice,
    UserType? userType,
  }) =>
      PriceState(
        isPrice: isPrice ?? this.isPrice,
        userType: userType ?? this.userType,
      );

  @override
  List<Object> get props => [isPrice, userType];
}
