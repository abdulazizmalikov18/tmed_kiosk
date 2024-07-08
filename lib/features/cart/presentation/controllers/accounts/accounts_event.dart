part of 'accounts_bloc.dart';

sealed class AccountsEvent {}

class AccountsGet extends AccountsEvent {
  final String? search;
  final Function(AccountsEntity entity)? onSucces;
  final VoidCallback? onError;
  AccountsGet({
    this.search,
    this.onSucces,
    this.onError,
  });
}

class AccountsUsernameEvent extends AccountsEvent {
  final String username;
  final VoidCallback onSucces;
  final VoidCallback onError;

  AccountsUsernameEvent({
    required this.username,
    required this.onSucces,
    required this.onError,
  });
}

class GetMoreAccounts extends AccountsEvent {
  final String? search;

  GetMoreAccounts({this.search});
}

class UpdateAccountEvent extends AccountsEvent {
  final String username;
  final Map<String, dynamic> data;
  final Function(AccountsEntity account) onSucces;

  UpdateAccountEvent({
    required this.username,
    required this.data,
    required this.onSucces,
  });
}

class DelSelectionAcccount extends AccountsEvent {}

class GetReccommendation extends AccountsEvent {}

class GetHistory extends AccountsEvent {
  final Function(String)? onError;

  GetHistory({required this.onError});
}

class SelectionAccount extends AccountsEvent {
  final AccountsEntity account;

  SelectionAccount({required this.account});
}

class GetRegion extends AccountsEvent {
  final int index;
  final int id;
  final String? search;

  GetRegion({
    this.index = 0,
    this.id = 0,
    this.search,
  });
}

class GetProfession extends AccountsEvent {
  final int index;
  final int id;
  final String? search;

  GetProfession({
    this.index = 0,
    this.id = 0,
    this.search,
  });
}

class GetCupon extends AccountsEvent {
  final String? user;
  final String? search;
  final bool feetchMore;

  GetCupon({
    this.user,
    this.search,
    this.feetchMore = false,
  });
}

class CheckPhone extends AccountsEvent {
  final String phone;
  final Function(Exodim)? onSuccess;

  CheckPhone({
    required this.phone,
    required this.onSuccess,
  });
}

class PostPhone extends AccountsEvent {
  final String phoneJshshr;
  final Function(Exodim)? onSuccess;
  final Function(String) onError;
  PostPhone({
    required this.phoneJshshr,
    required this.onSuccess,
    required this.onError,
  });
}

class CreateAccount extends AccountsEvent {
  final FormData formData;
  final VoidCallback onSucces;
  final VoidCallback onError;

  CreateAccount({
    required this.formData,
    required this.onSucces,
    required this.onError,
  });
}

class IsFocused extends AccountsEvent {
  final bool isFocused;

  IsFocused({required this.isFocused});
}

class SelCuponPost extends AccountsEvent {
  final int id;
  final String username;
  final VoidCallback onSuccess;
  final Function(String) onError;

  SelCuponPost({
    required this.id,
    required this.onError,
    required this.onSuccess,
    required this.username,
  });
}

class RemCuponPost extends AccountsEvent {
  final int id;
  final String username;
  final VoidCallback onSuccess;
  final Function(String) onError;

  RemCuponPost({
    required this.id,
    required this.onError,
    required this.onSuccess,
    required this.username,
  });
}

class RemoveCuponA extends AccountsEvent {}

class SelectionCupon extends AccountsEvent {
  final int id;
  final bool isDisebled;
  final Function(CuponModel) onCupon;

  SelectionCupon({
    required this.id,
    required this.isDisebled,
    required this.onCupon,
  });
}
