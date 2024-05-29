import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/constants/constants.dart';
import 'package:ecommerce_app/core/error/exceptions.dart';
import 'package:ecommerce_app/repositories/interfaces/interfaces.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository = GetIt.I.get<IAuthRepository>();
  final SharedPreferences sharedPreferences = GetIt.I.get<SharedPreferences>();

  AuthBloc() : super(AuthInitial()) {
    on<CheckAuthentication>(_onCheckAuthentication);
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
    on<StartShopping>(_onStartShopping);
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
    on<AuthWithGoogle>(_onAuthWithGoogle);
    on<AuthWithFacebook>(_onAuthWithFacebook);
    on<LogOut>(_onLogOut);
  }

  _onCheckAuthentication(event, emit) {
    final bool? alreadyAuthenticated = sharedPreferences.getBool(SharedPreferencesKeys.alreadyAuthenticated);
    if (alreadyAuthenticated == true) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  _onSignUpWithEmailAndPassword(event, emit) async {
    try {
      emit(Authenticating());
      await authRepository.signUpWithEmailAndPassword(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      await _markAsAuthenticated();
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(message: e.message ?? "Sign up failed. Try again!"));
    } on ApiException catch (e) {
      if (e.errorCode == "DUPLICATE_EMAIL") {
        emit(const AuthenticationFailure(message: "Email already exists. Please try another email!"));
      } else {
        emit(AuthenticationFailure(message: e.message ?? "Sign up failed. Try again!"));
      }
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onSignInWithEmailAndPassword(event, emit) async {
    try {
      emit(Authenticating());
      await authRepository.signInWithEmailAndPassword(email: event.email, password: event.password);
      await _markAsAuthenticated();
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(message: e.message ?? "Sign in failed. Try again!"));
      Utils.showSnackBar(message: e.message ?? "Sign in failed. Try again!", context: event.context);
    } on ApiException catch (e) {
      switch (e.errorCode) {
        case "BAD_CREDENTIALS":
          emit(const AuthenticationFailure(message: "Invalid email or password. Please try again!"));
          break;
        case "USER_NOT_FOUND":
          emit(const AuthenticationFailure(message: "User not found. Please sign up!"));
          break;
      }
      // emit(AuthenticationFailure(message: e.message ?? "Sign in failed. Try again!"));
      print("Authenticate ApiError: ${e.message}");
      Utils.showSnackBar(message: e.message ?? "Sign in failed. Try again!", context: event.context);
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
      print("Authenticate error: ${e.toString()}");
      // Utils.showSnackBar(message: "Authenticate error: ${e.toString()}", context: event.context);
    }
  }

  _onAuthWithGoogle(event, emit) async {
    try {
      emit(Authenticating());
      await authRepository.signInWithGoogle();
      emit(Authenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onAuthWithFacebook(event, emit) async {
    try {
      emit(Authenticating());
      emit(Authenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onLogOut(event, emit) async {
    try {
      await authRepository.logOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onStartShopping(event, emit) {
    emit(Authenticated());
  }

  Future<void> _markAsAuthenticated() async {
    await sharedPreferences.setBool(SharedPreferencesKeys.alreadyAuthenticated, true);
  }
}
