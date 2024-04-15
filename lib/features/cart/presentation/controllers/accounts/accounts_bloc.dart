import 'package:dio/dio.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/account_username_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/del_cupon_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tmed_kiosk/core/exceptions/failures.dart';
import 'package:tmed_kiosk/features/cart/data/models/account_create_model.dart';
import 'package:tmed_kiosk/features/cart/data/models/accounts_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_filter.dart';
import 'package:tmed_kiosk/features/cart/data/models/cupon/cupon_selection.dart';
import 'package:tmed_kiosk/features/cart/data/models/history/history_filter.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/accounts_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/cupon_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/history/history_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/profession_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/recommendation/recommendation_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/region_entity.dart';
import 'package:tmed_kiosk/features/cart/domain/entity/user_set/selection_account.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/accounts_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/check_phone_usecae.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/create_account_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/cupon_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/history_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/post_phone_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/profession_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/recommendation_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/region_usecase.dart';
import 'package:tmed_kiosk/features/cart/domain/usecase/sel_cupon_usecase.dart';
import 'package:tmed_kiosk/features/common/models/popular_category_filter.dart';

part 'accounts_event.dart';
part 'accounts_state.dart';

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsUseCase accounts = AccountsUseCase();
  CreateAccountUseCase createaccount = CreateAccountUseCase();
  PostPhoneUseCase postPhone = PostPhoneUseCase();
  CheckPhoneUseCase checkPhone = CheckPhoneUseCase();
  RegionUseCase regionUse = RegionUseCase();
  ProfessionUseCase professionUse = ProfessionUseCase();
  CuponUseCase cuponUse = CuponUseCase();
  HistoryUseCase historyUse = HistoryUseCase();
  SelCuponUseCase selcuponUse = SelCuponUseCase();
  RecommendationUseCase recommendUse = RecommendationUseCase();
  DelCuponUseCase delCuponUseCase = DelCuponUseCase();
  AccountUsernameUseCase accountUsernameUseCase = AccountUsernameUseCase();
  AccountsBloc() : super(const AccountsState()) {
    on<SelectionAccount>((event, emit) async {
      SelectionAccountEntity selectionA = SelectionAccountEntity(
        selectAccount: event.account,
      );
      emit(state.copyWith(selectAccount: selectionA));
    });

    on<GetReccommendation>((event, emit) async {
      emit(state.copyWith(statusd: FormzSubmissionStatus.inProgress));
      final username = state.selectAccount.selectAccount.username;
      final result = await recommendUse.call(username);
      if (result.isRight) {
        emit(state.copyWith(
            recommendations: result.right.results,
            statusd: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(statusd: FormzSubmissionStatus.failure));
      }
    });

    on<SelectionCupon>((event, emit) {
      SelectionAccountEntity account = SelectionAccountEntity(
        selectAccount: state.selectAccount.selectAccount,
        cupons: state.selectAccount.cupons,
        selectCupon: event.isDisebled
            ? state.selectAccount.cupons[event.id]
            : const CuponEntity(),
      );
      event.onCupon(event.isDisebled
          ? state.selectAccount.cupons[event.id]
          : const CuponEntity());
      emit(state.copyWith(selectAccount: account));
    });

    on<RemoveCuponA>((event, emit) {
      SelectionAccountEntity account = SelectionAccountEntity(
        selectAccount: state.selectAccount.selectAccount,
        cupons: state.selectAccount.cupons,
        selectCupon: const CuponEntity(),
      );
      emit(state.copyWith(selectAccount: account));
    });

    on<SelCuponPost>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await selcuponUse.call(CuSel(
        user: event.username,
        id: event.id,
      ));
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        event.onError((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<RemCuponPost>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result =
          await delCuponUseCase.call(CuSel(user: event.username, id: event.id));
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSuccess();
      } else {
        event.onError((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetHistory>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      HFilter filter = HFilter(
        username: state.selectAccount.selectAccount.username,
      );
      final result = await historyUse.call(filter);
      if (result.isRight) {
        emit(state.copyWith(
          historys: result.right.results,
          status: FormzSubmissionStatus.success,
        ));
      } else {
        event.onError!((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetCupon>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result =
          await cuponUse.call(CFilter(user: event.user, search: event.search));
      if (result.isRight) {
        if (event.user == null) {
          emit(state.copyWith(
            cupons: result.right.results,
            status: FormzSubmissionStatus.success,
          ));
        } else {
          SelectionAccountEntity account = SelectionAccountEntity(
            selectAccount: state.selectAccount.selectAccount,
            cupons: result.right.results,
            selectCupon: state.selectAccount.selectCupon,
          );
          emit(state.copyWith(
            selectAccount: account,
            status: FormzSubmissionStatus.success,
          ));
        }
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<DelSelectionAcccount>(
      (event, emit) {
        emit(state.copyWith(selectAccount: const SelectionAccountEntity()));
        add(AccountsGet());
      },
    );

    on<IsFocused>(
      (event, emit) => emit(state.copyWith(isFocused: event.isFocused)),
    );

    on<AccountsUsernameEvent>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await accountUsernameUseCase.call(event.username);
      if (result.isRight) {
        add(SelectionAccount(account: result.right));
        emit(state.copyWith(status: FormzSubmissionStatus.success));
        event.onSucces();
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<CreateAccount>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await createaccount.call(event.formData);
      if (result.isRight) {
        add(AccountsUsernameEvent(
          username: result.right.user.username,
          onSucces: event.onSucces,
          onError: () {},
        ));
        add(AccountsGet());
      } else {
        event.onError();
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<PostPhone>((event, emit) async {
      AccountCreateModel phone = AccountCreateModel(
        param: event.phoneJshshr[0] == '+' ? "phone" : "pinfl",
        mydata: event.phoneJshshr[0] == '+'
            ? {"phone": event.phoneJshshr}
            : {"pinfl": event.phoneJshshr},
      );
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await postPhone.call(phone);
      if (result.isRight) {
        if (result.right) {
          event.onError("Ushu raqam bilan user mavjud");
          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          if (event.phoneJshshr[0] == '+') {
            add(CheckPhone(
              phone: event.phoneJshshr,
              onSuccess: event.onSuccess,
            ));
          } else {
            emit(state.copyWith(status: FormzSubmissionStatus.success));
            if (event.onSuccess != null) {
              event.onSuccess!();
            }
          }
        }
      } else {
        event.onError((result.left as ServerFailure).errorMessage);
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<CheckPhone>((event, emit) async {
      final result = await checkPhone.call(event.phone);
      if (result.isRight) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));
        event.onSuccess!();
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<GetRegion>((event, emit) async {
      if (state.regions.isEmpty || event.index != 0 || event.search != null) {
        emit(state.copyWith(statusd: FormzSubmissionStatus.inProgress));
        final param = Filter(
          parent: (event.search != null) ? null : event.id,
          search: event.search,
        );
        final result = await regionUse.call(param);
        if (result.isRight) {
          if (event.index == 1) {
            emit(state.copyWith(regions1: result.right.results));
          } else if (event.index == 2) {
            emit(state.copyWith(regions2: result.right.results));
          } else {
            emit(state.copyWith(regions: result.right.results));
          }
          emit(state.copyWith(statusd: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(statusd: FormzSubmissionStatus.failure));
        }
      }
    });

    on<GetProfession>((event, emit) async {
      if (state.profession.isEmpty ||
          event.index != 0 ||
          event.search != null) {
        emit(state.copyWith(statusd: FormzSubmissionStatus.inProgress));
        final param = Filter(
          parent: (event.search != null) ? null : event.id,
          search: event.search,
        );
        final result = await professionUse.call(param);
        if (result.isRight) {
          if (event.index == 1) {
            emit(state.copyWith(profession2: result.right.results));
          } else {
            emit(state.copyWith(profession: result.right.results));
          }
          emit(state.copyWith(statusd: FormzSubmissionStatus.success));
        } else {
          emit(state.copyWith(statusd: FormzSubmissionStatus.failure));
        }
      }
    });

    on<AccountsGet>((event, emit) async {
      AccountsFilter filter = AccountsFilter(search: event.search);
      emit(state.copyWith(statusAccounts: FormzSubmissionStatus.inProgress));
      final result = await accounts.call(filter);
      if (result.isRight) {
        emit(state.copyWith(
          accounts: result.right.results,
          count: result.right.count,
          statusAccounts: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusAccounts: FormzSubmissionStatus.failure));
      }
    });
    on<GetMoreAccounts>((event, emit) async {
      AccountsFilter filter = AccountsFilter(
        offset: state.accounts.length,
        search: event.search,
      );
      final result = await accounts.call(filter);
      if (result.isRight) {
        emit(state.copyWith(
          accounts: [...state.accounts, ...result.right.results],
          count: result.right.count,
          statusAccounts: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(statusAccounts: FormzSubmissionStatus.failure));
      }
    });
  }
}
