part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final UserModel user;
  final List<KassaSpecialModel> listSpecial;
  const AuthenticationState._({
    required this.status,
    required this.user,
    required this.listSpecial,
  });

  const AuthenticationState.authenticated(UserModel user, List<KassaSpecialModel> listSpecial)
      : this._(
          status: AuthenticationStatus.authenticated,
          user: user,
          listSpecial: listSpecial,
        );
  const AuthenticationState.update(UserModel user)
      : this._(
          status: AuthenticationStatus.cancelLoading,
          user: user,
          listSpecial: const [],
        );
  const AuthenticationState.unauthenticated()
      : this._(
          status: AuthenticationStatus.unauthenticated,
          user: const UserModel(),
          listSpecial: const [],
        );
  const AuthenticationState.loading()
      : this._(
          status: AuthenticationStatus.loading,
          user: const UserModel(),
          listSpecial: const [],
        );
  const AuthenticationState.cancelLoading()
      : this._(
          status: AuthenticationStatus.cancelLoading,
          user: const UserModel(),
          listSpecial: const [],
        );

  AuthenticationState copyWith({
    AuthenticationStatus? status,
    UserModel? user,
    List<KassaSpecialModel>? listSpecial,
  }) =>
      AuthenticationState._(
        status: status ?? this.status,
        user: user ?? this.user,
        listSpecial: listSpecial ?? this.listSpecial,
      );

  @override
  List<Object?> get props => [user, status, listSpecial];
}
