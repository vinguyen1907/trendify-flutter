import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/repositories/auth_repository.dart';
import 'package:ecommerce_app/utils/firebase_constants.dart';
import 'package:ecommerce_app/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
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
    if (firebaseAuth.currentUser != null) {
      emit(Authenticated());
    } else {
      emit(Unauthenticated());
    }
  }

  _onSignUpWithEmailAndPassword(event, emit) async {
    try {
      emit(Authenticating());
      await AuthRepository().signUpWithEmailAndPassword(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (e) {
      print("e1");
      emit(AuthenticationFailure(
          message: e.message ?? "Sign up failed. Try again!"));
      // Utils.showSnackBar(
      //     message: e.message ?? "Sign up failed. Try again!",
      //     context: event.context);
    } catch (e) {
      print("e2");
      emit(AuthenticationFailure(message: e.toString()));
      // Utils.showSnackBar(message: e.toString(), context: event.context);
    }
  }

  _onSignInWithEmailAndPassword(event, emit) async {
    try {
      emit(Authenticating());
      await AuthRepository().signInWithEmailAndPassword(
          email: event.email, password: event.password);
      emit(Authenticated());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationFailure(
          message: e.message ?? "Sign in failed. Try again!"));
      Utils.showSnackBar(
          message: e.message ?? "Sign in failed. Try again!",
          context: event.context);
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
      Utils.showSnackBar(message: e.toString(), context: event.context);
    }
  }

  _onAuthWithGoogle(event, emit) async {
    try {
      emit(Authenticating());
      await AuthRepository().signInWithGoogle();
      emit(Authenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onAuthWithFacebook(event, emit) async {
    try {
      emit(Authenticating());
      // await AuthRepository().signInWithFacebook();
      emit(Authenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onLogOut(event, emit) async {
    try {
      AuthRepository().logOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthenticationFailure(message: e.toString()));
    }
  }

  _onStartShopping(event, emit) {
    emit(Authenticated());
  }
}
