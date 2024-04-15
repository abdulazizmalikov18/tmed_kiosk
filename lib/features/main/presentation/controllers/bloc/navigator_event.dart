part of 'navigator_bloc.dart';

abstract class MyNavigatorEvent {}

class OpenCart extends MyNavigatorEvent {
  final bool openCart;

  OpenCart(this.openCart);
}

class IsImage extends MyNavigatorEvent {
  final bool isImage;

  IsImage(this.isImage);
}

class IsImageC extends MyNavigatorEvent {
  final bool isImage;

  IsImageC(this.isImage);
}

class NavId extends MyNavigatorEvent {
  final int index;

  NavId(this.index);
}
