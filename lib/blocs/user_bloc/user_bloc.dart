import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/constants/app_constants.dart';
import 'package:ecommerce_app/constants/enums/gender.dart';
import 'package:ecommerce_app/models/user_profile.dart';
import 'package:ecommerce_app/repositories/interfaces/user_repository_interface.dart';
import 'package:ecommerce_app/repositories/user_repository.dart' as firebase_repos;
import 'package:ecommerce_app/repositories/api_repositories/api_repositories.dart' as api_repos;
import 'package:ecommerce_app/services/call_service.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IUserRepository userRepository = AppConstants.databaseSource == DataSource.api ? api_repos.UserRepository() : firebase_repos.UserRepository();

  UserBloc() : super(UserInitial()) {
    on<LoadUser>(_onLoadUser);
    on<ReloadUser>(_onReloadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  _onLoadUser(event, emit) async {
    try {
      final UserProfile user = await userRepository.fetchUser();
      await userRepository.updateFcmToken();
      await CallService().initCallService(user);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  _onReloadUser(event, emit) async {
    try {
      final UserProfile user = await userRepository.fetchUser();
      if (state is UserLoaded) {
        emit((state as UserLoaded).copyWith(user: user));
      }
    } catch (e) {
      print("Load user error: $e");
    }
  }

  _onUpdateUser(UpdateUser event, emit) async {
    if (state is UserLoaded) {
      try {
        await userRepository.updateUser(
            name: event.name != (state as UserLoaded).user.name ? event.name : null,
            age: event.age != (state as UserLoaded).user.age ? event.age : null,
            gender: event.gender != (state as UserLoaded).user.gender ? genderToString[event.gender] : null,
            email: event.email != (state as UserLoaded).user.email ? event.email : null,
            image: event.image);
      } catch (e) {
        print("Update user error: $e");
        print("User updated");
      }

      // Reload user
      final UserProfile user = await userRepository.fetchUser();
      if (state is UserLoaded) {
        emit(UserUpdated());
        emit(UserLoaded(user: user));
      }
    }
  }
}
