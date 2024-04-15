part of 'specialists_bloc.dart';

class SpecialistsState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusP;
  final bool isImage;
  final List<SpecialistsEntity> specialistsList;
  final List<SpecCatEntity> specialCatrs;
  final int catCount;
  final int specCat;
  final String search;
  final int count;
  final int selection;
  const SpecialistsState({
    this.status = FormzSubmissionStatus.initial,
    this.statusP = FormzSubmissionStatus.initial,
    this.isImage = false,
    this.specialistsList = const [],
    this.specialCatrs = const [],
    this.specCat = 0,
    this.search = '',
    this.count = 0,
    this.selection = -1,
    this.catCount = 0,
  });
  SpecialistsState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusP,
    bool? isImage,
    List<SpecialistsEntity>? specialistsList,
    List<SpecCatEntity>? specialCatrs,
    int? specCat,
    String? search,
    int? count,
    int? selection,
    int? catCount,
  }) =>
      SpecialistsState(
        status: status ?? this.status,
        statusP: statusP ?? this.statusP,
        isImage: isImage ?? this.isImage,
        specialistsList: specialistsList ?? this.specialistsList,
        specialCatrs: specialCatrs ?? this.specialCatrs,
        specCat: specCat ?? this.specCat,
        search: search ?? this.search,
        count: count ?? this.count,
        selection: selection ?? this.selection,
        catCount: catCount ?? this.catCount,
      );

  @override
  List<Object> get props => [
        status,
        statusP,
        isImage,
        specialistsList,
        specialCatrs,
        specCat,
        count,
        search,
        selection,
        catCount,
      ];
}
