part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}

class ReloadUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final String name;
  final Gender gender;
  final int? age;
  final String email;
  final XFile? image;

  const UpdateUser({
    required this.name,
    required this.gender,
    required this.age,
    required this.email,
    required this.image,
  });
}
