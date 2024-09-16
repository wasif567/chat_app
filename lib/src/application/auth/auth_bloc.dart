import 'dart:developer';

import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:chat/src/infrastructure/auth/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(state.copyWith(
        errorMsg: "",
        isRegister: false,
        loading: false,
        logIn: false,
        logOut: false,
      ));
    });

    on<LoginAuth>(_loginUser);
    on<RegisterAuth>(_registerUser);
    on<AuthCheck>(_authCheck);
    on<LogOutEvent>(_logOutUser);
  }

  Future _loginUser(LoginAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(loading: true, errorMsg: "", logIn: false));
      final response = await _authRepo.loginUser(email: event.email, password: event.password);
      if (response.user != null) {
        emit(state.copyWith(errorMsg: "", loading: false, logIn: true));
      } else {
        emit(state.copyWith(
          errorMsg: "",
          loading: false,
        ));
      }
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(errorCode: e.code, loading: false, logIn: false));
    } catch (e) {
      emit(state.copyWith(
        errorMsg: 'Login failed',
        loading: false,
        logIn: false,
      ));
    }
  }

  Future _registerUser(RegisterAuth event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(
        isRegister: false,
        loading: true,
      ));
      final response = await _authRepo.registerUser(
          registerUser: RegisterUserModel(
              email: event.email,
              password: event.password,
              mobileNumber: event.mobileNumber,
              country: event.country,
              fullName: event.fullName));
      if (response) {
        emit(state.copyWith(
          isRegister: true,
          loading: false,
        ));
      } else {
        emit(state.copyWith(
          isRegister: false,
          loading: false,
        ));
      }
    } on FirebaseException catch (e) {
      emit(state.copyWith(
        isRegister: false,
        loading: false,
      ));
      if (event.context.mounted) {
        showDialog(
            context: event.context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  e.message ?? "Registration Failed",
                  style: const TextStyle(fontSize: 14),
                ),
              );
            });
      }
    } catch (_) {
      emit(state.copyWith(
        isRegister: false,
        loading: false,
      ));
    }
  }

  Future _authCheck(AuthCheck event, Emitter<AuthState> emit) async {
    try {
      final response = await _authRepo.authCheck();
      log("$response");
    } catch (_) {}
  }

  Future _logOutUser(LogOutEvent event, Emitter<AuthState> emit) async {
    try {
      await _authRepo.logoutUser();
      emit(state.copyWith(
        logOut: true,
      ));
    } catch (_) {
      emit(state.copyWith(logOut: false));
    }
  }
}
