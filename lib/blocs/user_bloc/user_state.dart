// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

enum UserStatus { initial, loading, loaded, updated, updateError, error }

class UserState extends Equatable {
  final UserStatus status;
  final UserProfile? user;
  final String? message;

  const UserState({
    required this.status,
    this.user,
    this.message,
  });

  @override
  List<Object?> get props => [
        status,
        user,
        message,
      ];

  UserState copyWith({
    UserStatus? status,
    UserProfile? user,
    String? message,
  }) {
    return UserState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
