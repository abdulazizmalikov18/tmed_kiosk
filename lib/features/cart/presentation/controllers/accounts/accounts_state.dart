part of 'accounts_bloc.dart';

class AccountsState extends Equatable {
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusPhone;
  final FormzSubmissionStatus statusd;
  final FormzSubmissionStatus statusAccounts;
  final FormzSubmissionStatus statusOrder;
  final List<AccountsEntity> accounts;
  final List<AccountsEntity> accountsPhone;
  final SelectionAccountEntity selectAccount;
  final List<RegionEntity> regions;
  final List<RegionEntity> regions1;
  final List<RegionEntity> regions2;
  final List<ProfessionEntity> profession;
  final List<ProfessionEntity> profession2;
  final List<HistoryEntity> historys;
  final List<CuponModel> cupons;
  final List<RecommendationModel> recommendations;
  final bool isFocused;
  final int count;
  final int countCupon;
  final AccountBalanceModel accountBalanceModel;

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
    this.countCupon = 0,
    this.accountBalanceModel = const AccountBalanceModel(),
    this.accountsPhone = const [],
    this.statusPhone = FormzSubmissionStatus.initial,
    this.statusOrder = FormzSubmissionStatus.initial,
  });

  AccountsState copyWith({
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusPhone,
    FormzSubmissionStatus? statusd,
    FormzSubmissionStatus? statusAccounts,
    FormzSubmissionStatus? statusOrder,
    List<AccountsEntity>? accounts,
    List<AccountsEntity>? accountsPhone,
    List<RegionEntity>? regions,
    List<RegionEntity>? regions1,
    List<RegionEntity>? regions2,
    SelectionAccountEntity? selectAccount,
    bool? isFocused,
    List<ProfessionEntity>? profession,
    List<ProfessionEntity>? profession2,
    List<HistoryEntity>? historys,
    List<CuponModel>? cupons,
    List<RecommendationModel>? recommendations,
    int? count,
    int? countCupon,
    AccountBalanceModel? accountBalanceModel,
  }) =>
      AccountsState(
        status: status ?? this.status,
        statusOrder: statusOrder ?? this.statusOrder,
        statusPhone: statusPhone ?? this.statusPhone,
        accountsPhone: accountsPhone ?? this.accountsPhone,
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
        countCupon: countCupon ?? this.countCupon,
        accountBalanceModel: accountBalanceModel ?? this.accountBalanceModel,
      );

  @override
  List<Object> get props => [
    status,
    statusd,statusOrder,
    statusAccounts,
    accounts,
    regions,
    regions1,
    regions2,
    accountsPhone,
    accountBalanceModel,
    isFocused,
    selectAccount,
    profession,
    profession2,
    historys,
    cupons,
    recommendations,
    count,
    countCupon
  ];
}
