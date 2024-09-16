part of 'auth_bloc.dart';

class AuthState {
  final bool? isLoading;
  final String? responseMsg;
  final String? code;
  final bool? loggedIn;
  final bool? loggedOut;
  final bool? isRegistered;
  AuthState(
      {this.code,
      this.loggedOut,
      this.isLoading = false,
      this.responseMsg,
      this.loggedIn = false,
      this.isRegistered = false});

  AuthState copyWith(
      {bool? isRegister,
      bool? loading = false,
      String? errorMsg,
      String? errorCode,
      bool? logIn = false,
      bool? logOut = false}) {
    return AuthState(
      loggedIn: logIn ?? false,
      responseMsg: errorMsg ?? "",
      isLoading: loading ?? false,
      loggedOut: logOut ?? false,
      isRegistered: isRegister ?? false,
      code: errorCode ?? "",
    );
  }
}

class AuthInitial extends AuthState {}
