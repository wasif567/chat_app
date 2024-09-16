part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthIntial extends AuthEvent {}

class LoginAuth extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginAuth(this.context, {required this.email, required this.password});
}

class RegisterAuth extends AuthEvent {
  final String email;
  final String password;
  final String mobileNumber;
  final String country;
  final String fullName;
  final BuildContext context;
  RegisterAuth({
    required this.fullName,
    required this.email,
    required this.password,
    required this.country,
    required this.mobileNumber,
    required this.context,
  });
}

class AuthCheck extends AuthEvent {
  AuthCheck();
}

class LogOutEvent extends AuthEvent {
  LogOutEvent();
}
