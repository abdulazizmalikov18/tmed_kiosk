part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusd;
  final FormzSubmissionStatus statusAccounts;
  final List<AccountsEntity> accounts;
  final SelectionAccountEntity selectAccount;
  final List<RegionEntity> regions;
  final List<RegionEntity> regions1;
  final List<RegionEntity> regions2;
  final List<ProfessionEntity> profession;
  final List<ProfessionEntity> profession2;
  final List<HistoryEntity> historys;
  final List<CuponEntity> cupons;
  final List<RecommendationEntity> recommendations;
  final bool isFocused;
  final int count;
  const AccountsState({
    this.status = FormzSubmissionStatus.initial,
    this.statusd = FormzSubmissionStatus.initial,
    this.statusAccounts = FormzSubmissionStatus.initial,
    this.accounts = const [],
    this.regions = const [],
    this.regions1 = const [],
    this.regions2 = const [],
    this.profession = const [],
    this.profession2 = const [],
    this.selectAccount = const SelectionAccountEntity(),
    this.isFocused = false,
    this.historys = const [],
    this.cupons = const [],
    this.recommendations = const [],
    this.count = 0,
  });

  AccountsState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusd,
    FormzSubmissionStatus? statusAccounts,
    List<AccountsEntity>? accounts,
    List<RegionEntity>? regions,
    List<RegionEntity>? regions1,
    List<RegionEntity>? regions2,
    SelectionAccountEntity? selectAccount,
    bool? isFocused,
    List<ProfessionEntity>? profession,
    List<ProfessionEntity>? profession2,
    List<HistoryEntity>? historys,
    List<CuponEntity>? cupons,
    List<RecommendationEntity>? recommendations,
    int? count,
  }) =>
      AccountsState(
        status: status ?? this.status,
        statusd: statusd ?? this.statusd,
        statusAccounts: statusAccounts ?? this.statusAccounts,
        accounts: accounts ?? this.accounts,
        regions: regions ?? this.regions,
        regions1: regions1 ?? this.regions1,
        regions2: regions2 ?? this.regions2,
        isFocused: isFocused ?? this.isFocused,
        selectAccount: selectAccount ?? this.selectAccount,
        profession: profession ?? this.profession,
        profession2: profession2 ?? this.profession2,
        historys: historys ?? this.historys,
        cupons: cupons ?? this.cupons,
        recommendations: recommendations ?? this.recommendations,
        count: count ?? this.count,
      );

  @override
  List<Object> get props => [
        status,
        statusd,
        statusAccounts,
        accounts,
        regions,
        regions1,
        regions2,
        isFocused,
        selectAccount,
        profession,
        profession2,
        historys,
        cupons,
        recommendations,
        count,
      ];
}
