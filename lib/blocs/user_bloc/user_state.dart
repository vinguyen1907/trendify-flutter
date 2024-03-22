// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserProfile user;
  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];

  UserLoaded copyWith({
    UserProfile? user,
  }) {
    return UserLoaded(
      user: user ?? this.user,
    );
  }
}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserUpdated extends UserState {}
