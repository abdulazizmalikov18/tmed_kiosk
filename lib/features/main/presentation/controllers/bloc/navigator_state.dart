part of 'navigator_bloc.dart';

class MyNavigatorState extends Equatable {
  final bool openCart;
  final bool isImage;
  final bool isImageC;
  final int navid;

  const MyNavigatorState({
    this.openCart = false,
    this.isImage = false,
    this.isImageC = false,
    this.navid = 0,
  });

  MyNavigatorState copyWith({
    bool? openCart,
    bool? isImage,
    bool? isImageC,
    int? navid,
  }) =>
      MyNavigatorState(
        openCart: openCart ?? this.openCart,
        isImage: isImage ?? this.isImage,
        isImageC: isImageC ?? this.isImageC,
        navid: navid ?? this.navid,
      );

  @override
  List<Object> get props => [
        openCart,
        isImage,
        isImageC,
        navid,
      ];
}
