part of 'specialists_bloc.dart';

abstract class SpecialistsEvent {}

class GetSpecialists extends SpecialistsEvent {
  final int? index;
  final String? search;
  final bool canel;
  final Function(List<SpecialistsEntity> specialistsList)? onSucces;

  GetSpecialists({
    this.index,
    this.search,
    this.canel = false,
    this.onSucces,
  });
}

class GetMoreSpecialists extends SpecialistsEvent {}

class GetSpeciaCats extends SpecialistsEvent {
  final bool isMore;

  GetSpeciaCats({this.isMore = false});
}

class IsImage extends SpecialistsEvent {
  final bool isImage;

  IsImage(this.isImage);
}

class SelectionIndex extends SpecialistsEvent {
  final int index;

  SelectionIndex({required this.index});
}
