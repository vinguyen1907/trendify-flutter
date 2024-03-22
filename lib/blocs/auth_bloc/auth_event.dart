part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpWithEmailAndPassword extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;

  const SignUpWithEmailAndPassword({
    required this.name,
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password];
}

class StartShopping extends AuthEvent {}
// This event is used when user click on "Start Shopping" button after sign up successfully

class SignInWithEmailAndPassword extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const SignInWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object> get props => [email, password];
}

class LogOut extends AuthEvent {}

class CheckAuthentication extends AuthEvent {}

class AuthWithGoogle extends AuthEvent {}

class AuthWithFacebook extends AuthEvent {}
