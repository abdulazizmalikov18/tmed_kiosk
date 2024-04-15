part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  AuthenticationStatusChanged({required this.status});
}

class LoginUser extends AuthenticationEvent {
  final String userName;

  final String password;

  final Function(String)? onError;
  final VoidCallback? onSuccess;

  LoginUser({
    required this.password,
    required this.userName,
    this.onError,
    this.onSuccess,
  });
}

class ChangeLanguageEvent extends AuthenticationEvent {
  final String language;

  ChangeLanguageEvent(this.language);
}

class CheckUser extends AuthenticationEvent {}

class CheckLogin extends AuthenticationEvent {}

class Logout extends AuthenticationEvent {}

class RefreshToken extends AuthenticationEvent {}

class ChangeNotificationAllRead extends AuthenticationEvent {}
