part of 'goods_bloc.dart';

class GoodsState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusProduct;
  final FormzSubmissionStatus status2;
  final FormzSubmissionStatus status3;
  final List<OrgProductModel> orgProduct;
  final List<OrgProductModel> catigoryPro;
  final List<OrgProductModel> specialistPro;
  final List<int> itemCount;
  final List<ProductSpecialEntity> psp;
  final Map<int, List<ProductSpecialEntity>> pspSave;
  final List<SuppliesEntity> supplies;
  final Map<int, List<SuppliesEntity>> suppliesSave;
  final List<TodayTimetableEntity> timetable;
  final TodayTimetableEntity timeDay;
  final String search;
  final int count;
  final int countCategory;

  const GoodsState({
    this.status = FormzSubmissionStatus.initial,
    this.statusProduct = FormzSubmissionStatus.initial,
    this.status2 = FormzSubmissionStatus.initial,
    this.status3 = FormzSubmissionStatus.initial,
    this.timeDay = const TodayTimetableEntity(),
    this.orgProduct = const [],
    this.itemCount = const [],
    this.catigoryPro = const [],
    this.specialistPro = const [],
    this.psp = const [],
    this.supplies = const [],
    this.timetable = const [],
    this.search = '',
    this.count = 0,
    this.countCategory = 0,
    this.pspSave = const {},
    this.suppliesSave = const {},
  });

  GoodsState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusProduct,
    FormzSubmissionStatus? status2,
    FormzSubmissionStatus? status3,
    List<OrgProductModel>? orgProduct,
    List<int>? itemCount,
    List<OrgProductModel>? catigoryPro,
    List<OrgProductModel>? specialistPro,
    List<ProductSpecialEntity>? psp,
    List<SuppliesEntity>? supplies,
    List<TodayTimetableEntity>? timetable,
    String? search,
    int? count,
    int? countCategory,
    Map<int, List<ProductSpecialEntity>>? pspSave,
    Map<int, List<SuppliesEntity>>? suppliesSave,
    TodayTimetableEntity? timeDay,
  }) =>
      GoodsState(
        status: status ?? this.status,
        statusProduct: statusProduct ?? this.statusProduct,
        status2: status2 ?? this.status2,
        status3: status3 ?? this.status3,
        orgProduct: orgProduct ?? this.orgProduct,
        itemCount: itemCount ?? this.itemCount,
        catigoryPro: catigoryPro ?? this.catigoryPro,
        specialistPro: specialistPro ?? this.specialistPro,
        psp: psp ?? this.psp,
        supplies: supplies ?? this.supplies,
        timetable: timetable ?? this.timetable,
        search: search ?? this.search,
        count: count ?? this.count,
        pspSave: pspSave ?? this.pspSave,
        suppliesSave: suppliesSave ?? this.suppliesSave,
        timeDay: timeDay ?? this.timeDay,
        countCategory: countCategory ?? this.countCategory,
      );

  @override
  List<Object> get props => [
        orgProduct,
        status,
        statusProduct,
        status2,
        status3,
        itemCount,
        catigoryPro,
        specialistPro,
        count,
        psp,
        supplies,
        timetable,
        search,
        pspSave,
        suppliesSave,
        timeDay,
        countCategory,
      ];
}
